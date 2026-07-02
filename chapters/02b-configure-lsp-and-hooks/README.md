# 02b · Configure the agent: LSP + hooks

> **Lesson goal:** skills give the agent *know-how*, but a coding agent is only as good as
> its configuration. Two more levers stop it drifting off your patterns: **LSP** (so it
> sees real types) and **hooks** (a fast local guardrail, a nudge not a wall). Both come from the same
> `apm.yml` / `.apm/`.

This is the workshop's answer to the premise *"coding agents can write Pulumi for you, but
the quality depends almost entirely on how you've configured them."*

---

## LSP: let the agent see real types

A language server gives the agent **live diagnostics, go-to-definition, and type
information** as it writes — the same red squiggles you get. So it reaches for the *real*
cloud-SDK API (the actual args on `aws.s3.Bucket`) instead of hallucinating one.

Declare a server per Pulumi language under `dependencies.lsp` (each entry needs **`name`,
`command`, and `extensionToLanguage`**):

```yaml
# apm.yml
dependencies:
  lsp:
    - name: typescript-language-server      # TypeScript Pulumi programs
      command: typescript-language-server
      args: ["--stdio"]
      extensionToLanguage: { ".ts": typescript, ".tsx": typescriptreact }
    - name: pyright                         # Python
      command: pyright-langserver
      args: ["--stdio"]
      extensionToLanguage: { ".py": python }
    - name: gopls                           # Go
      command: gopls
      args: ["serve"]
      extensionToLanguage: { ".go": go }
```

```bash
apm install        # there is NO --lsp flag; LSP servers are wired by `apm install`
```

This writes `.lsp.json` for Claude Code (project scope) and records the servers in
`apm.lock.yaml`. A few things to know:

- **APM does *not* install the binaries.** Put them on your `$PATH` yourself:
  `npm i -g typescript typescript-language-server pyright` · `go install golang.org/x/tools/gopls@latest`
  (or just run [`demo/install-lsp-servers.sh`](../../demo/install-lsp-servers.sh), which verifies they resolve).
- Today APM writes LSP config for **Claude Code and GitHub Copilot CLI** only; other
  harnesses are "not yet supported."
- The payoff: mistakes get caught as the code is typed, **not** at `pulumi up`.

## Hooks: a fast local guardrail (not a wall)

A skill *asks* the agent to "preview before apply." A **hook catches the obvious case where
it doesn't.** Hooks are file-discovered from `.apm/hooks/*.json` (no manifest key) and
compile into the agent's native config — for Claude Code, `.claude/settings.json`.

This repo ships [`.apm/hooks/block-pulumi-mutations.json`](../../.apm/hooks/block-pulumi-mutations.json):

```json
{ "PreToolUse": [{
  "matcher": "Bash",
  "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/scripts/guard-pulumi.sh", "timeout": 10 }]
}]}
```

> Why `$CLAUDE_PROJECT_DIR` and not a relative path? Claude Code sets that variable when it
> runs a hook, so the command resolves **absolutely** — even after the agent's shell has
> `cd`'d into a scaffolded subproject. A relative `.claude/hooks/…` path breaks in that
> case, and a hook that can't be found fails **open** (exit 127 is non-blocking; only
> exit 2 blocks).

The script ([`scripts/guard-pulumi.sh`](../../scripts/guard-pulumi.sh)) reads the proposed
command from stdin and **exits `2` to block** `pulumi up` / `pulumi destroy`, feeding the
reason back to the agent:

```bash
apm install        # merges the hook into .claude/settings.json; the command targets the repo's scripts/guard-pulumi.sh
```

Verified behavior (run them yourself — and notice the last two rows):

| Command the agent tries | Result |
|---|---|
| `pulumi up --yes` | 🚫 blocked (exit 2) |
| `pulumi --stack prod up` | 🚫 blocked (flags between `pulumi` and `up` don't help) |
| `pulumi update --yes` | 🚫 blocked (`update` is the canonical name; `up` is the alias) |
| `pulumi destroy` | 🚫 blocked |
| *(unparseable stdin / no `python3`)* | 🚫 blocked (**fails closed**) |
| `pulumi preview`, `kubectl get pods` | ✅ allowed |
| `make deploy` (wraps `pulumi up`) | ⚠️ **allowed** — the string has no `pulumi up` |
| `node deploy.js` (Automation API / MCP) | ⚠️ **allowed** — never touches the Bash tool |

> **Be honest about this.** The hook is a *nudge*, not enforcement. It only sees the **Bash**
> tool, so the agent can still deploy through the `pulumi-automation-api` skill or the Pulumi
> MCP server, hide `pulumi up` in a `make` target, or rewrite `settings.json` with the Write
> tool. The block semantics (stdin `tool_input.command`, exit 2 blocks) are Claude Code's
> contract; APM just delivers the file.

### The "settings" lever: a permissions deny-list

Pair the hook with Claude Code **permissions** (the teaser's "settings"). A `deny` rule is a
second client-side gate:

```jsonc
// .claude/settings.json
{ "permissions": { "deny": ["Bash(pulumi up:*)", "Bash(pulumi destroy:*)"] } }
```

### Where the *real* wall is

Both the hook and permissions are client-side and bypassable. Real enforcement lives
**server-side**: **Pulumi Cloud deployment policies** (block the apply itself) and
**OIDC-scoped, short-lived credentials** (the agent can't deploy what its token can't touch).
Use the local guardrails for fast feedback; use Pulumi Cloud for the guarantee.

## How LSP + hooks guard against drift

- **LSP** catches type/API mistakes the moment they're written, so the agent never builds
  on a hallucinated signature.
- **Hooks** stop dangerous or off-pattern actions outright, regardless of what the model
  "decides."

Together with skills (know-how) and the MCP server (live access), that's the full
"configure your agent" story.

## ✏️ Exercise

Add a second hook — a `PostToolUse` hook on `Edit|Write` that runs `pulumi preview` after
the agent changes IaC, so it always sees the plan. Run `apm install` and confirm it lands
in `.claude/settings.json`.

➡️ Next: [03 · Use skills within workflows](../03-use-skills-within-workflows/)
