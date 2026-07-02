# Getting Started with DevOps AI Skills

> A hands-on workshop on building, sharing, and running **Agent Skills** for DevOps
> and platform engineering — using [Pulumi](https://www.pulumi.com/) as the running
> example and [Microsoft APM](https://microsoft.github.io/apm/) to manage the
> agent primitives.

**Presenters:** Engin Diri (Senior Solutions Architect) & Adam Gordon Bell (Community Engineer) · Pulumi
**Format:** Workshop (≈ 60 min) · slides + follow-along chapters

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/dirien/getting-started-with-devops-ai-skills)

---

## What you'll learn

AI coding agents (Claude Code, Copilot, Cursor, Pulumi Neo …) are good out of the box,
but they don't know *your* runbooks, *your* golden paths, or *your* infrastructure
conventions. **Agent Skills** are the missing piece: small, composable folders of
instructions + scripts that teach an agent how your team actually ships software.

By the end you will be able to:

- **Discover and evaluate** existing skills before writing your own
- **Connect** skills to your agent and use them inside real DevOps workflows
- **Read the anatomy** of a skill (`SKILL.md`, frontmatter, bundled resources)
- **Build** skills from scratch — simple and complex/multi-file
- **Follow design principles** that make skills reliable and discoverable
- **Maintain** skills: keep them current, version them, and remove them cleanly
- **Turn an everyday DevOps workflow into a reusable skill**

This workshop reframes the LinkedIn Learning course *"Give Your Agent Skills"* for a
**DevOps / platform-engineering** audience, and grounds every lesson in real
infrastructure-as-code tasks.

## Who it's for

Platform engineers, SREs, and DevOps engineers who already use (or want to use) an AI
coding agent and want it to follow their team's standards instead of guessing.

## Run it in a Codespace (zero setup)

The fastest way to follow along: open the repo in a **GitHub Codespace** (or any
devcontainer-compatible tool — VS Code Dev Containers, DevPod). The
[`.devcontainer`](.devcontainer/) builds an environment with **Claude Code**, **Codex**,
and the **Pulumi CLI** — plus Node/Python/Go, `kubectl`/`helm`/`kind`, the LSP servers, and
the **APM CLI** — and runs `apm install` for you, so the skills, MCP server, LSP config, and
guardrail hook are already wired the moment you open a terminal.

```bash
# Click the Codespaces badge above, or:
gh codespace create -R dirien/getting-started-with-devops-ai-skills
```

Set these as **Codespaces secrets** (or host env vars) first, so the agents authenticate
without an interactive login:

| Secret | For |
|--------|-----|
| `ANTHROPIC_API_KEY` | Claude Code |
| `OPENAI_API_KEY` | Codex |
| `PULUMI_ACCESS_TOKEN` | Pulumi Cloud |
| `GITHUB_TOKEN` | GitHub CLI (usually provided automatically) |

Then: `claude` (or `codex`) starts the agent, `apm list` shows the wired skills, and
`cd slides && npm run dev` runs the deck.

> Devcontainer adapted from [dirien/devcontainer-coding-agents](https://github.com/dirien/devcontainer-coding-agents).
> Prefer local setup? The manual prerequisites are below.

## Prerequisites (local, without the devcontainer)

The published abstract says "a Pulumi Cloud account" — true to follow along, but to *run*
the repo you need more. Be honest with yourself before the day:

- **Claude Code** (the LSP + hooks integration targets Claude Code today; opencode is out of scope for now)
- The **APM CLI** — `curl -sSL https://aka.ms/apm-unix | sh` (Microsoft, pre-1.0 / v0.22; pin a version if you depend on it)
- `git`, a terminal, **Node.js 20+** (slides + the TS/MCP bits)
- **LSP server binaries on `$PATH`** — APM writes the config but does *not* install them: run [`demo/install-lsp-servers.sh`](demo/install-lsp-servers.sh) (`typescript-language-server`, `pyright`, `gopls`)
- A free [Pulumi](https://app.pulumi.com/signup) Cloud account
- *(for the incident demo)* `kind` + `kubectl` — [`demo/setup-cluster.sh`](demo/setup-cluster.sh) stands up a broken pod to triage

> **Presenting it?** Run [`demo/prewarm.sh`](demo/prewarm.sh) on the venue wifi first, and read
> [`PRESENTER.md`](PRESENTER.md) for the run-of-show, the cut list, and the "wifi dies" fallback.

## Quickstart

```bash
# Install the APM CLI (macOS / Linux)
curl -sSL https://aka.ms/apm-unix | sh          # or: brew install microsoft/apm/apm

# From the repo root: one command integrates skills, hooks, LSP, and MCP into .claude/
apm install
# (apm compile is separate: it turns .apm/ instructions into AGENTS.md/CLAUDE.md; unused here)

# Run the slides
cd slides && npm install && npm run dev
```

Prefer the per-machine route? `npx skills add pulumi/agent-skills --skill '*'` installs
the Pulumi skills without APM. (There is **no** `get.pulumi.com/skills.sh` — that's a
myth; the real tools are `npx skills` and the Claude Code plugin marketplace.)

## Repository layout

This repo is itself an **APM package** — it demonstrates the tooling it teaches.

```
getting-started-with-devops-ai-skills/
├── .devcontainer/      # Codespace/devcontainer: Claude Code + Codex + Pulumi + APM, auto-wired
├── apm.yml              # the manifest: skill deps, the Pulumi MCP server, and LSP servers
├── .apm/
│   ├── skills/          # the DevOps skills we build (source; compiles to .claude/skills/)
│   │   ├── golden-path-service/
│   │   ├── incident-triage/      (complex: references/ + scripts/ + templates/)
│   │   └── esc-secret-rotation/
│   └── hooks/           # guardrails, e.g. block-pulumi-mutations.json (→ .claude/settings.json)
├── scripts/            # hook scripts (guard-pulumi.sh — fails closed, blocks pulumi up/destroy)
├── demo/               # fixtures: crashloop pod, LSP project, setup + prewarm scripts
├── slides/             # the Slidev deck (npm run dev)
├── chapters/           # follow-along chapters, one folder per lesson
└── PRESENTER.md        # run-of-show, the cut list, and the "wifi dies" fallback
```

### Chapters

| # | Chapter | What you do |
|---|---------|-------------|
| 00 | Introduction | Why skills, and set up your environment |
| 01 | Discover & evaluate skills | Find existing skills; judge if they're worth using |
| 02 | Connect skills to your agent | Install/enable skills so the agent can reach them |
| 02b | Configure the agent (LSP + hooks) | Wire language servers + guardrail hooks so it doesn't drift |
| 03 | Use skills within workflows | Drive a real DevOps task through a skill |
| 04 | Anatomy of a skill | `SKILL.md`, frontmatter, progressive disclosure, bundled files |
| 05 | Build a skill from scratch | Author your first DevOps skill |
| 06 | Build complex skills | Multi-file skills with scripts and references |
| 07 | Skill design principles | Naming, descriptions, scope, and reliability |
| 08 | Keep skills up to date | Versioning and maintenance |
| 09 | Remove skills | Clean removal without breaking the agent |
| 10 | Turn workflows into skills | Capture an everyday runbook as a skill |

## Running the slides

```bash
cd slides
npm install        # tokenless — pulls @pulumi/slidev-theme from public npm
npm run dev        # opens the deck at http://localhost:3030
npm run build      # static build into dist/
```

## Credits & references

- LinkedIn Learning — *Give Your Agent Skills* ([companion repo](https://github.com/LinkedInLearning/give-your-agent-skills-27494005))
- Microsoft **APM** — Agent Primitives / package manager ([docs](https://microsoft.github.io/apm/) · [repo](https://github.com/microsoft/apm))
- Anthropic **Agent Skills**
- **Pulumi** Agent Skills, MCP server, and Neo

> Slide design adapted from Engin's *"Beyond `pulumi up`"* and *"Getting Started with
> Kubernetes on Google Cloud"* decks (Pulumi Slidev theme).
