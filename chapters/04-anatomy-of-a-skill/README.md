# 04 · Exploring the makeup of a skill

> **Lesson goal:** open a real skill and understand every part of it, so building your
> own (chapter 05) is just filling in a template you already understand.

---

## The minimum viable skill

A skill is a directory whose entry point is `SKILL.md`:

```
hello-skill/
└── SKILL.md
```

`SKILL.md` is Markdown with a **YAML frontmatter** header:

```markdown
---
name: pulumi-stack-bootstrap
description: >-
  Scaffold a new Pulumi project using our org standard: ESC for config,
  OIDC for cloud auth, and a preview-before-apply workflow. Use when asked
  to start a new stack, service, or IaC project.
---

# Pulumi stack bootstrap

When the user wants a new Pulumi project:

1. Ask for the cloud (aws | gcp | azure) and language (ts | python | go).
2. Run `pulumi new <cloud>-<language> --name <name>` …
3. Wire config to ESC instead of `Pulumi.<stack>.yaml` secrets …
4. Add the CI workflow from `references/ci.yml`.
5. Always `pulumi preview` before suggesting `pulumi up`.
```

### Frontmatter fields

| Field | Required | Purpose |
|---|---|---|
| `name` | ✅ | Stable identifier; how the skill is referenced |
| `description` | ✅ | **The trigger.** Loaded for every prompt; decides when the body loads |
| *(metadata / allowed-tools / license, where supported)* | — | Optional governance fields |

> Exact optional fields vary by agent/runtime — `name` + `description` are the universal
> core. See chapter 07 for why the `description` is the most important line you'll write.

## Progressive disclosure — the key idea

Skills stay cheap because the agent loads them in **layers**:

```mermaid {scale: 1.0, theme: 'base', themeVariables: { 'background': 'transparent', 'primaryColor': '#1f1d3a', 'primaryTextColor': '#e9e7ff', 'primaryBorderColor': '#7e6bff', 'lineColor': '#9b8cff', 'fontFamily': 'Inter, ui-sans-serif, system-ui' } }
flowchart TB
  l1["<b>Level 1 — always loaded</b><br/>name + description (~tens of tokens each)"]
  l2["<b>Level 2 — loaded on trigger</b><br/>the SKILL.md body"]
  l3["<b>Level 3 — loaded on demand</b><br/>bundled scripts, references, templates"]
  l1 -->|"task looks relevant"| l2 -->|"step needs it"| l3
```

So you can have **dozens** of skills installed; only the relevant one's body — and only
the files that step actually needs — ever enter the context window.

## Anatomy of a *complex* skill

```
incident-triage/
├── SKILL.md                 # the procedure (concise)
├── references/
│   ├── severity-matrix.md   # read only when classifying severity
│   └── escalation.md        # read only when escalating
├── scripts/
│   └── gather-diagnostics.sh
└── templates/
    └── postmortem.md
```

The body of `SKILL.md` points at these: *"To classify severity, read
`references/severity-matrix.md`."* The agent fetches it lazily.

## 🔍 Exercise

Open one of the **Pulumi skills** you installed in chapter 02. Identify:

- its `name` and `description`
- where the body ends and bundled references begin
- one thing it does with a **script** instead of prose

➡️ Next: [05 · Build a skill from scratch](../05-build-a-skill-from-scratch/)
