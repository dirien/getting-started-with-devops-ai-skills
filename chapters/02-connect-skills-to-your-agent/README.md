# 02 · Connect skills to your agent

> **Lesson goal:** install a skill so your agent can reach it — first the per-machine
> way, then the reproducible, whole-team way with **APM**.

---

## The per-machine way: `npx skills`

The [skills.sh](https://skills.sh) CLI installs any skill into your agent. This is what the original
course uses, and it's great for a single laptop:

```bash
# Pulumi's official Agent Skills (github.com/pulumi/agent-skills)
npx skills add pulumi/agent-skills --skill '*'

# Just the core "pulumi" plugin (overview, best-practices, esc, component, …)
npx skills add pulumi/agent-skills/pulumi --skill '*'

npx skills list            # what's installed
```

Or, in **Claude Code**, use the plugin marketplace:

```bash
/plugin marketplace add pulumi/agent-skills
/plugin install pulumi
```

> ⚠️ There is **no** `curl get.pulumi.com/skills.sh | sh`; that URL doesn't exist (it
> returns 403). The real mechanisms are `npx skills` and the Claude Code marketplace.

Both write into a per-agent skills directory (`.agents/skills/` or `.claude/skills/`)
and a `skills-lock.json`. Perfect for you — but your teammate gets nothing when they
clone the repo.

## The whole-team way: APM

[Microsoft APM](https://microsoft.github.io/apm/) is "package.json for AI agents." You
declare dependencies once in `apm.yml`, commit it, and everyone who clones runs **one**
command.

```bash
# Install the APM CLI
curl -sSL https://aka.ms/apm-unix | sh      # macOS / Linux
# (Windows: irm https://aka.ms/apm-windows | iex   ·   or: brew install microsoft/apm/apm)
```

This repo already ships an [`apm.yml`](../../apm.yml):

```yaml
name: getting-started-with-devops-ai-skills
targets: [claude]                  # also: copilot, cursor, codex, gemini, …
dependencies:
  apm:
    - pulumi/agent-skills/pulumi          # Pulumi's core skill set (7 skills)
    - pulumi/agent-skills/delegation      # pulumi-neo-handoff
    # community runbooks: a dep path must point at a SKILL.md, not a category folder
    - bregman-arie/devops-sre-skills/skills/kubernetes/diagnose-crashloop
  mcp:
    - name: pulumi                        # Pulumi's hosted MCP server (OAuth on first use)
      registry: false
      transport: http
      url: https://mcp.ai.pulumi.com/mcp
```

> Verified: `apm install` integrates **14 skills** into `.claude/skills/` (our 3 + Pulumi's
> 7 + `pulumi-neo-handoff` + 3 community runbooks) and configures the Pulumi MCP server.

Then:

```bash
apm install              # resolve + scan, then integrate skills, hooks, LSP, MCP into .claude/
```

A new teammate is fully configured with `git clone … && apm install`. In CI, use
`apm install --frozen` (lockfile-only, like `npm ci`).

## ✅ Verify

Ask your agent to list its skills — you should see the Pulumi skills plus this repo's
own (`golden-path-service`, `incident-triage`, `esc-secret-rotation`).

➡️ Next: [03 · Use skills within workflows](../03-use-skills-within-workflows/)
