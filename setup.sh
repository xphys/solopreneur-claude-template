#!/usr/bin/env bash
# Clone or update every app repo listed in apps.yaml into apps/.
#
#   ./setup.sh                      # clone (or fast-forward) all app repos via SSH
#   GIT_PROTOCOL=https ./setup.sh   # use HTTPS instead of SSH
#   ./setup.sh --install            # also run `pnpm install` where a package.json exists
#
# Safe to re-run any time: existing repos are fetched and fast-forwarded only
# (never force-updated), and skipped entirely if they have local changes.

set -euo pipefail
cd "$(dirname "$0")"

MANIFEST="apps.yaml"
INSTALL=false
[[ "${1:-}" == "--install" ]] && INSTALL=true

if [[ ! -f "$MANIFEST" ]]; then
  echo "ERROR: $MANIFEST not found." >&2
  exit 1
fi

# Parse the strict apps.yaml format into "name|repo|trunk" lines.
parse_manifest() {
  awk '
    function flush() { if (name != "") print name "|" repo "|" trunk }
    /^- name:/   { flush(); name=$3; repo=""; trunk="" }
    /^  repo:/   { repo=$2 }
    /^  trunk:/  { trunk=$2 }
    END          { flush() }
  ' "$MANIFEST"
}

FAILED=0

while IFS='|' read -r name repo trunk; do
  [[ -z "$name" ]] && continue
  dir="apps/$name"

  if [[ "$repo" == *"{{"* ]]; then
    echo "-- $name: repo URL still has template placeholders — run /bootstrap first. Skipping."
    continue
  fi

  if [[ "${GIT_PROTOCOL:-}" == "https" ]]; then
    repo="${repo/git@github.com:/https://github.com/}"
  fi

  if [[ -d "$dir/.git" ]]; then
    if [[ -n "$(git -C "$dir" status --porcelain)" ]]; then
      echo "-- $name: has local changes — skipping update."
    else
      echo "-- $name: fetching + fast-forwarding $trunk"
      git -C "$dir" fetch --prune
      current="$(git -C "$dir" rev-parse --abbrev-ref HEAD)"
      if [[ "$current" == "$trunk" ]]; then
        git -C "$dir" merge --ff-only "origin/$trunk" || {
          echo "   $name: cannot fast-forward (diverged?) — resolve manually."; FAILED=1; }
      else
        echo "   $name: on branch '$current' (not $trunk) — fetched only."
      fi
    fi
  else
    # Tolerate the template's placeholder dirs (empty or .gitkeep only).
    if [[ -d "$dir" && -n "$(ls -A "$dir" 2>/dev/null | grep -v '^\.gitkeep$' || true)" ]]; then
      echo "-- $name: $dir exists and is not empty but is not a git repo — skipping." >&2
      FAILED=1
      continue
    fi
    echo "-- $name: cloning $repo"
    rm -f "$dir/.gitkeep" 2>/dev/null || true
    git clone "$repo" "$dir" || { echo "   $name: clone failed."; FAILED=1; continue; }
  fi

  if $INSTALL && [[ -f "$dir/package.json" ]]; then
    echo "   $name: pnpm install"
    (cd "$dir" && pnpm install)
  fi
done < <(parse_manifest)

if [[ "$FAILED" -ne 0 ]]; then
  echo "Done, with warnings above." >&2
  exit 1
fi
echo "Done."
