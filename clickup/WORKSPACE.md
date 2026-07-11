# ClickUp workspace map

Known IDs for the pinned workspace (`CLICKUP_TEAM_ID` in `clickup/.env`) so sessions don't
have to rediscover them. Refresh with `./cu.sh hierarchy` (spaces) — folders/lists via the
v2 API (see cu.sh source). **Update this file when you create/discover something new.**

> **TEMPLATE:** the rows below are a fictional example ("Acme"). After filling
> `clickup/.env`, run `./cu.sh hierarchy`, replace them with your real spaces/lists/docs,
> and delete this banner.

## Spaces → lists

| Space | Space ID | Lists |
|---|---|---|
| **Acme Operations** | `900000000001` | Platform Issues `900000000101` |
| **Acme Product** | `900000000002` | Development `900000000102`, folder "Private" `900000000103` |
| **Project Management** | `900000000003` | General `900000000104` |

## Docs

| Doc | ID | Where | Notes |
|---|---|---|---|
| **Knowledge Base** | `8x9yz1ab-42` | Acme Operations → Platform Issues | The owner's PM knowledge base — write project updates here |

### Knowledge Base page tree (as of YYYY-MM-DD)

```
- Welcome                                 8x9yz1ab-101
- SEO                                     8x9yz1ab-102
  - SEO Foundation — What We're Adding    8x9yz1ab-103
- Release Notes                           8x9yz1ab-104
```

## URL anatomy (for extracting IDs from links the owner pastes)

`https://app.clickup.com/<TEAM_ID>/v/dc/<DOC_ID>/<PAGE_ID>` — doc pages
`https://app.clickup.com/t/<TASK_ID>` — tasks
