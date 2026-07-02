# Presenter run-of-show — Getting Started with DevOps AI Skills

> 60 minutes, presenter-driven. The deck runs **slides first, then one live demo block at
> the end**: the argument is complete before anything can break live, and the demo is the
> payoff. This is the plan for the room *and* the plan for when the wifi dies. Decide the
> cuts **before** you walk on, not at minute 45.
>
> The [published listing](https://www.pulumi.com/events/getting-started-with-devops-ai-skills/)
> promises *"coding agents can write Pulumi for you, but the quality depends almost entirely
> on how you've configured them."* Beat 2 of the demo block is that sentence, live.

## Pre-flight (before the talk, on the venue wifi if you can)

**Devcontainer / Codespace** (the intended way): the container build already installed the
LSP binaries, kind, and the APM CLI, ran `apm install`, and pulled the npm deps. Two scripts
remain yours:

```bash
demo/prewarm.sh                 # re-RUNS apm install + npm deps and checks MCP/LSP/kind — local writes only, no cloud mutations
demo/setup-cluster.sh           # kind cluster + the crashlooping 'payments' pod — never automatic
```

**Bare-metal** (no container): add the LSP installer before those two:

```bash
demo/install-lsp-servers.sh     # put gopls / pyright / typescript-language-server on $PATH
```

**Auth is always manual** — do it now, not on stage: `pulumi login` (`pulumi whoami` to
confirm), `claude` login, approve the project's `pulumi` MCP server, `/mcp` → authenticate.

Then confirm five things:

- `apm install` resolved **14 skills + 1 hook** into `.claude/` and **3 LSP servers** into `.lsp.json`
- the hook is wired cwd-proof: `grep CLAUDE_PROJECT_DIR .claude/settings.json` hits
- `pulumi whoami` works
- `kubectl -n demo get pods` shows the `payments` pods in `CrashLoopBackOff`
- `demo/pulumi-ts/index.ts` shows a red squiggle on `publicReadAccess`

If any of these is red, switch that demo beat to its recording. The show doesn't change.
Two hard-won notes: create the Codespace **the day before** (cold build ~10 min; a repo
prebuild removes even that), and `slides/node_modules` is platform-specific — run
`npm install` fresh on whichever machine actually presents the deck.

## The shape of the hour

| Min | Segment |
|----:|---------|
| 0–5 | Cover · who we are (Engin + Adam) · housekeeping · agenda |
| 5–15 | What is a skill: `SKILL.md` + where it lives · progressive disclosure · anatomy · skill ≠ MCP ≠ CLAUDE.md |
| 15–19 | Why DevOps should use skills too (the stat, *with the caveat*) |
| 19–23 | Find & evaluate (where to look, how to vet) |
| 23–32 | Connect & configure: two install paths · APM + `apm.yml` · skills/MCP/Neo · LSP · hooks |
| 32–35 | Proof, on slides: "Same prompt, configured vs not" + "the agent triggers the skill itself" — **promise the live version** |
| 35–39 | Build complex safely (`incident-triage`) · six principles · keep current / remove clean |
| 39–41 | Recap ("What you've got now") + "What we didn't cover" |
| 41–55 | **The demo block** (next section) — everything from the slides, live, in order |
| 55–60 | Thank you, QRs, questions |

The deck's speaker notes add up to roughly 26 minutes of talking against a 41-minute slide
window. The slack is for the "questions any time" promise in housekeeping. If the room is
chatty, defend minute 41: the demo block is what flexes, and the cut list decides what goes.

## The demo block (41–55)

Transition line off the last content slide: **"That's the whole argument. Now watch it run."**

Every demo happens *after* its slide, so narrate each beat as a callback, not an
introduction: "this is the 'Same prompt, configured vs not' slide, for real." The room
already has the theory. Don't re-teach it; point at what's on screen.

### Beat 1 — wire it up: `apm install` (~3 min)

1. Show `apm.yml` in the editor. Point at the three dependency kinds (skills, MCP, LSP)
   and say the fourth out loud: hooks are file-discovered from `.apm/hooks/`.
2. Run `apm install` (prewarmed, so it's fast).
3. Show what landed: `ls .claude/skills/` → 14 skills; `.lsp.json`; the hook merged into
   `.claude/settings.json`.

Callback: "One manifest → every agent." A new teammate gets all of this from
`git clone && apm install`.
Fallback: run nothing. Prewarm already put the tree on disk; walk it in the editor.

### Beat 2 — the money shot: same prompt, configured vs not (~7 min) — **protect this**

This is a **sequenced composite of three artifacts**, not one magic prompt. Run them in
this order, narrate "off vs on," and don't imply one keystroke triggers all three.

1. **LSP.** Open `demo/pulumi-ts/index.ts`: the red squiggle on `publicReadAccess`, an
   invented arg on `aws.s3.BucketV2`. Without LSP this only blows up at `pulumi preview`;
   with it, the agent sees the mistake as the code is written.
2. **The skill triggers itself.** In Claude Code, type the plain request:
   *"Start a new payments service — AWS, TypeScript."* Watch `golden-path-service` fire
   from its description alone (nobody said "use the skill"), wire ESC + OIDC, apply
   standard tags, and stop at `pulumi preview`.
3. **The hook holds the line.** Ask the agent to apply. `guard-pulumi.sh` blocks
   `pulumi up` with exit 2, and the reason lands back in the agent's context. Show
   `pulumi preview` still passing right after.

Say the honest line out loud right here: **the hook is a nudge, not a wall.** The
Automation API and the MCP server never touch the Bash tool, and a `make deploy` wrapper
slips past because the command string never says `pulumi`. The real wall is Pulumi Cloud
deployment policy plus OIDC-scoped creds.

Callbacks: the "LSP", "Hooks", "Same prompt, configured vs not", and "Use it" slides.
Fallback: a recording per artifact; at minimum the screenshot of the squiggle.

### Beat 3 — a complex skill under pressure: `incident-triage` (~4 min)

1. Prompt: *"We have a prod incident: the `payments` pods are in CrashLoopBackOff in the
   `demo` namespace. Triage it — gather diagnostics, classify severity, and propose a
   stabilization plan."* (Say it this way. A bare "triage this crashloop" can match the
   narrower community `diagnose-crashloop` skill instead — fine as an aside on skill
   collision, wrong as the planned beat.)
2. Watch the shape of a complex skill do its job: it fires from the description, runs
   `scripts/gather-diagnostics.sh demo payments` (read-only; only the *output* enters
   context), classifies severity from `references/severity-matrix.md`, proposes a fix,
   and stops. A human approves; nothing mutates.

Callback: the "Complex: make it safe and deterministic" slide. Scripts for procedure,
prose for judgement, read-only by default.
Fallback: run the script directly in a terminal, no agent; or the recording.

## The cut list (in order — cut from the top when you're behind)

Slides run first, so running long eats the demo block. Cut demo beats bottom-up:

1. **Beat 3** (`incident-triage` live) → point at chapter 06 + `demo/setup-cluster.sh` as
   homework; show only the skill's file tree.
2. **Beat 1** (`apm install` live) → don't run it; show the already-installed `.claude/`
   tree in 30 seconds and move on.
3. Already behind at minute 30, on the slides? Compress "keep current / remove clean" to
   one sentence + a pointer at chapters 08–09.

**Never cut Beat 2.** It's the only thing that *proves* the thesis ("quality depends on
how you configure it"). If you show one thing live, show that.

## When the wifi dies (it will)

- The slides need no network, and the demos all sit at the end, so a dead network never
  interrupts the argument mid-flight. The demo block just becomes recordings.
- `apm install` stalls → prewarm cached everything; if it didn't, show the recorded run
  and the resulting `.claude/skills/` tree.
- The Pulumi MCP server is **remote** (`https://mcp.ai.pulumi.com/mcp`, OAuth) → you did
  the OAuth dance in pre-flight. If the venue network blocks it, Beat 2 still runs: the
  skill fires locally, and only the MCP-dependent extras (registry lookups, Pulumi Cloud
  access) go quiet. Say so and move on.
- LSP shows nothing → binaries missing from `$PATH` or `npm install` never ran in
  `demo/pulumi-ts`; use the screenshot.
- Keep **screen recordings of all three beats** on disk as the universal fallback.

## Honest scope (say it out loud, don't get caught)

- **opencode**: the abstract names it; today's build is Claude Code only (APM writes LSP
  config for Claude Code + Copilot CLI only). Say so, and that the *method* is the same
  for opencode.
- **Pulumi-centric**: most skills here are Pulumi. The *approach* ports to Terraform/Helm/
  ArgoCD — point at the community runbooks as the non-Pulumi takeaway.
- **The hook is a nudge, not a wall.** Real enforcement is Pulumi Cloud deployment policy +
  OIDC creds. Don't call it a security control.
- **The stat** ("LLMs run >20% of infra deployments") is Pulumi's own figure (Joe Duffy,
  May '26). Attribute it; don't present it as independent.
