# <app name> (`apps/<folder>`)

<One paragraph: what this app is, who uses it, where it's deployed.>

- **Stack:** <framework, language, key libraries>
- **Trunk / production branch:** see [apps.yaml](../../apps.yaml)
- **Run locally:** <command; where env comes from>
- **Deploys via:** <mechanism; link to the runbook in ../../infra/runbooks/>

## Code layout

<Only what a directory listing can't tell — the load-bearing entry points, linked:>

- `../../apps/<folder>/src/...` — <what lives here / why it matters>

## How to add a feature (checklist)

1. <step — with one exemplar file to copy: `../../apps/<folder>/src/...`>
2. <step>
3. Update [conventions](../conventions.md) / [gotchas](../gotchas.md) if you changed or hit one.

## App-specific gotchas

<Anything true only for this app; platform-wide ones go in ../gotchas.md.>
