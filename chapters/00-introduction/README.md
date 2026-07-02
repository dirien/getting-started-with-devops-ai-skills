# 00 · Introduction

> **Lesson goals**
> 1. Understand what an Agent Skill is and why DevOps teams need them.
> 2. Set up your environment so the rest of the workshop is copy-paste runnable.

---

## Teach AI agents with skills

Your AI coding agent is genuinely good at general programming. What it *doesn't* know:

- your team's **golden paths** ("how we stand up a new service")
- your **runbooks** ("what to do when the prod cluster is degraded")
- your **conventions** (tags, naming, regions, which Pulumi component to reuse)

You can paste that context into every prompt — or you can package it **once** as an
**Agent Skill** and let the agent load it automatically when it's relevant.

An Agent Skill is, at its core, a folder with a `SKILL.md` file:

```
my-skill/
└── SKILL.md          # name + description (always loaded) + instructions (loaded on demand)
```

The agent reads the `name` and `description` of every available skill cheaply, and only
pulls in the full instructions (and any bundled scripts/files) **when the task calls for
it** — this is *progressive disclosure*, and it's why you can have dozens of skills
installed without drowning the context window.

> **Why this matters for DevOps specifically:** infra work is full of repeatable,
> high-stakes procedures that already live in wikis and runbooks nobody reads. A skill
> turns that dead documentation into something the agent actually executes — consistently.

## What this workshop builds on

| Piece | Role in this workshop |
|-------|----------------------|
| **Agent Skills** (Anthropic) | The format: `SKILL.md` + progressive disclosure |
| **Microsoft APM** | Manage / package / distribute the skills (and other agent primitives) across agents & IDEs |
| **Pulumi skills + MCP** | A real, production-grade set of DevOps skills to learn from and extend |
| **Claude Code** | The agent we drive (Copilot/Cursor noted where they differ) |

## Environment setup

> Fastest path: open the repo in a **Codespace/devcontainer** (see the root README) —
> everything below is pre-installed and `apm install` has already run. The manual steps
> that follow are the local, no-container route.

You'll need:

- An AI agent that supports Agent Skills — **Claude Code** recommended
- `git`, a terminal, **Node.js 20+** (for the slides) and **Python 3.11+** / `uv`
- A free **Pulumi** account: <https://app.pulumi.com/signup>

```bash
# 1. Clone the workshop
git clone <repo-url> && cd getting-started-with-devops-ai-skills

# 2. Install the APM CLI (macOS / Linux)
curl -sSL https://aka.ms/apm-unix | sh         # or: brew install microsoft/apm/apm

# 3. Install everything declared in apm.yml (Pulumi skills, community runbooks, MCP)
apm install                                    # integrates skills, hooks, LSP, MCP into .claude/

# 4. Sanity-check: ask your agent to list its skills
```

> Full detail — and the per-machine `npx skills` alternative — is in
> [chapter 02](../02-connect-skills-to-your-agent/).

## ✅ You're ready when…

- Your agent lists at least one available skill.
- `pulumi whoami` succeeds.
- You can run the slides locally (`cd slides && npm run dev`).

➡️ Next: [01 · Discover & evaluate skills](../01-discover-and-evaluate-skills/)
