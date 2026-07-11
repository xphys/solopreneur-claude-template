#!/usr/bin/env bash
# cu.sh — thin ClickUp API helper (works headless, no MCP server / session restart needed).
# Auth comes from clickup/.env (CLICKUP_API_KEY + CLICKUP_TEAM_ID). Docs use the v3 API,
# tasks the v2 API. Markdown page bodies are passed as FILES (JSON-encoded via python3)
# so non-ASCII text, quotes and newlines survive shell quoting.
#
# Usage:
#   cu.sh hierarchy                                    # spaces → folders → lists (with IDs)
#   cu.sh page-list   <doc_id>                         # page tree of a doc
#   cu.sh page-get    <doc_id> <page_id>               # page content as markdown
#   cu.sh page-create <doc_id> <name> <file.md> [parent_page_id]
#   cu.sh page-update <doc_id> <page_id> <file.md>     # REPLACES page content
#   cu.sh task-list   <list_id>
#   cu.sh task-get    <task_id>
#   cu.sh task-create <list_id> <name> [file.md]       # file = task description
#   cu.sh task-comment <task_id> <text...>
#
# Known IDs live in WORKSPACE.md next to this script.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
set -a; source "$DIR/.env"; set +a
: "${CLICKUP_API_KEY:?missing in clickup/.env}" "${CLICKUP_TEAM_ID:?missing in clickup/.env}"

V2="https://api.clickup.com/api/v2"
V3="https://api.clickup.com/api/v3/workspaces/$CLICKUP_TEAM_ID"

req() { # method url [json-body-file]
	local m="$1" u="$2" b="${3:-}"
	if [[ -n "$b" ]]; then
		curl -sf -X "$m" -H "Authorization: $CLICKUP_API_KEY" -H "Content-Type: application/json" --data @"$b" "$u"
	else
		curl -sf -X "$m" -H "Authorization: $CLICKUP_API_KEY" "$u"
	fi
}

# json_body <out-file> key=value... md:key=file.md  (md: values are read from file)
json_body() {
	local out="$1"; shift
	python3 - "$out" "$@" <<-'EOF'
		import json, sys
		out, body = sys.argv[1], {}
		for kv in sys.argv[2:]:
		    k, v = kv.split('=', 1)
		    if k.startswith('md:'):
		        body[k[3:]] = open(v).read()
		    else:
		        body[k] = v
		json.dump(body, open(out, 'w'))
	EOF
}

TMP="$(mktemp)"; trap 'rm -f "$TMP"' EXIT

case "${1:-}" in
hierarchy)
	req GET "$V2/team/$CLICKUP_TEAM_ID/space" | python3 -c '
import json, sys, urllib.parse
spaces = json.load(sys.stdin)["spaces"]
print(json.dumps([{"space": s["name"], "id": s["id"]} for s in spaces], ensure_ascii=False, indent=1))'
	;;
page-list)
	req GET "$V3/docs/$2/pages?max_page_depth=-1" | python3 -c '
import json, sys
def walk(pages, d=0):
    for p in pages:
        print("  "*d + "- " + (p.get("name") or "(untitled)") + "  [" + p["id"] + "]")
        walk(p.get("pages") or [], d+1)
walk(json.load(sys.stdin))'
	;;
page-get)
	req GET "$V3/docs/$2/pages/$3?content_format=text%2Fmd" | python3 -c 'import json,sys; print(json.load(sys.stdin)["content"])'
	;;
page-create)
	json_body "$TMP" "name=$3" "md:content=$4" content_format=text/md ${5:+parent_page_id=$5}
	req POST "$V3/docs/$2/pages" "$TMP" | python3 -c 'import json,sys; d=json.load(sys.stdin); print("created", d["id"], d["name"])'
	;;
page-update)
	json_body "$TMP" "md:content=$4" content_edit_mode=replace content_format=text/md
	req PUT "$V3/docs/$2/pages/$3" "$TMP" >/dev/null && echo "updated $3"
	;;
task-list)
	req GET "$V2/list/$2/task" | python3 -c '
import json, sys
for t in json.load(sys.stdin)["tasks"]:
    print(t["id"] + "  [" + t["status"]["status"] + "]  " + t["name"])'
	;;
task-get)
	req GET "$V2/task/$2" | python3 -m json.tool
	;;
task-create)
	json_body "$TMP" "name=$3" ${4:+"md:markdown_description=$4"}
	req POST "$V2/list/$2/task" "$TMP" | python3 -c 'import json,sys; d=json.load(sys.stdin); print("created", d["id"], d["url"])'
	;;
task-comment)
	tid="$2"; shift 2
	printf '%s' "$*" > "$TMP.txt"; json_body "$TMP" "md:comment_text=$TMP.txt"; rm -f "$TMP.txt"
	req POST "$V2/task/$tid/comment" "$TMP" >/dev/null && echo "commented on $tid"
	;;
*)
	sed -n '2,20p' "$0"; exit 1
	;;
esac
