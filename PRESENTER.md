# Presenter run-of-show — Getting Started with DevOps AI Skills

> 60 minutes, presenter-driven. This is the plan for the room *and* the plan for when
> the wifi dies. Decide the cuts **before** you walk on, not at minute 45.

## Pre-flight (do this before the talk, on the venue wifi if you can)

```bash
demo/install-lsp-servers.sh     # put gopls / pyright / typescript-language-server on $PATH
demo/prewarm.sh                 # apm install + pre-pull MCP + npm deps + checks (no cloud mutations)
demo/setup-cluster.sh           # kind cluster + the crashlooping 'payments' pod for incident-triage
```

Confirm: `apm install` resolves **14 skills + 3 LSP servers + 1 hook**; `pulumi whoami` works;
the `payments` pods are `CrashLoopBackOff`; `demo/pulumi-ts` shows a red squiggle on
`publicReadAccess`. If any of these is red, switch that demo to its recording.

## Minute-by-minute (target)

| Min | Segment | Live demo? |
|----:|---------|-----------|
| 0–5 | Cover, who I am, housekeeping, agenda | — |
| 5–14 | What is a skill (SKILL.md, progressive disclosure, skill ≠ MCP ≠ CLAUDE.md) | — |
| 14–18 | Why DevOps (runbooks → skills; the stat, *with the caveat*) | — |
| 18–24 | Find & evaluate · **DEMO 1**: `npx skills find`, read a SKILL.md, vet it | ✅ 2 min |
| 24–34 | Connect & configure: `apm.yml`, **DEMO 2** `apm install` → `.claude/`; skills/MCP/LSP/hooks | ✅ 3 min |
| 34–40 | **DEMO 3 (the money shot)**: the before/after — same prompt, naked vs configured | ✅ 4 min |
| 40–47 | Build: simple `golden-path-service`, complex `incident-triage`; **DEMO 4** gather-diagnostics on the crashloop pod | ✅ 3 min |
| 47–52 | Design principles, operate (update/remove) | — |
| 52–57 | Turn runbooks into skills; recap | — |
| 57–60 | Thank you, QR, questions | — |

## The cut list (in order — cut from the top when you're behind)

1. **Build-complex deep-dive** (incident-triage internals) → just show the tree, skip the live `gather-diagnostics`.
2. **Operate** (update/remove) → one sentence, point at the chapters.
3. **Find & evaluate DEMO 1** → narrate it, don't run `npx skills` live.
4. **LSP live** → fall back to the screenshot/recording of the red squiggle.

**Protect at all costs: DEMO 3, the before/after.** It's the only thing that *proves* the
thesis ("quality depends on how you configure it"). If you show one demo, show that one.

> DEMO 3 is a **sequenced composite of three artifacts**, not one magic prompt: (1) the LSP
> red squiggle on `publicReadAccess` in `demo/pulumi-ts`, (2) the golden-path skill adding
> standard tags, (3) the `guard-pulumi.sh` hook stopping `pulumi up/update`. Run them in
> that order and narrate the "off vs on" — don't imply one keystroke triggers all three.

## When the wifi dies (it will)

- `apm install` stalls → you already ran `prewarm.sh`, so deps are cached; if not, show the
  recorded run and the resulting `.claude/skills/` tree.
- `npx @pulumi/mcp-server` cold-fetch hangs → it was pre-pulled; otherwise skip the MCP beat.
- LSP shows nothing → binaries weren't installed or no project; use the recording.
- Have **screen recordings** of DEMO 2, 3, and 4 on disk as the universal fallback.

## Honest scope (say it out loud, don't get caught)

- **opencode**: the abstract names it; today's build is Claude Code only (APM writes LSP for
  Claude Code + Copilot CLI only). Say so, and that the *method* is the same for opencode.
- **Pulumi-centric**: most skills here are Pulumi. The *approach* ports to Terraform/Helm/
  ArgoCD — point at the community runbooks as the non-Pulumi takeaway.
- **The hook is a nudge, not a wall.** Real enforcement is Pulumi Cloud deployment policy +
  OIDC creds. Don't call it a security control.
- **The stat** ("LLMs run >20% of infra deployments") is Pulumi's own figure (Joe Duffy, May
  '26). Attribute it; don't present it as independent.
