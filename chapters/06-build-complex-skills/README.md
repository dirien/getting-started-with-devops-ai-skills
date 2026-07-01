# 06 · Building complex Agent Skills

> **Lesson goal:** go beyond one file — bundle **scripts**, **references**, and
> **templates** so the agent does the deterministic parts reliably and reads detail only
> when it needs it.

We'll look at **`incident-triage`**, a safe-by-default Kubernetes incident runbook. The
finished skill is at [`.apm/skills/incident-triage/`](../../.apm/skills/incident-triage/SKILL.md).

---

## The layout

```text
.apm/skills/incident-triage/
├── SKILL.md                  # the procedure — kept short
├── references/
│   ├── severity-matrix.md    # read only when classifying severity
│   └── escalation.md         # read only when escalating
├── scripts/
│   └── gather-diagnostics.sh # runs; only its OUTPUT enters context
└── templates/
    └── postmortem.md         # the artifact it fills in
```

This is the same shape as Anthropic's `skill-creator` and the community
[`devops-sre-skills`](https://github.com/bregman-arie/devops-sre-skills) runbooks.

## Why bundle files instead of one big `SKILL.md`?

**Progressive disclosure.** The agent loads:

1. `name` + `description` — always (cheap)
2. the `SKILL.md` body — when the skill triggers
3. `references/severity-matrix.md` — *only* if it actually classifies severity
4. runs `scripts/gather-diagnostics.sh` — the **script code never enters context**, only
   its output does

So a 5-line `SKILL.md` can sit on top of a lot of detail without paying for it every time.

## Scripts for procedure, prose for judgement

The deterministic part — "collect pod status, events, restart counts, logs, rollout
history" — is a script. You don't want the model re-deriving a fragile `kubectl`
incantation under incident pressure:

```bash
scripts/gather-diagnostics.sh <namespace> <workload>   # read-only, mutates nothing
```

The judgement part — "is this a bad rollout or a capacity problem?" — stays as prose in
`SKILL.md`, where the model is actually useful.

## Safe by default

`incident-triage` declares `default-mode: read-only`. It **gathers and proposes**; a
human approves any change. Rollback beats hotfix; one change at a time, each with its
rollback stated. This is the platform-engineering "paved road" applied to an agent.

## ✏️ Exercise

Add a `references/runbook-links.md` and a second script (e.g. `propose-rollback.sh` that
only *prints* the rollback command). Notice the agent reads the reference only when the
incident needs it.

➡️ Next: [07 · Following skill design principles](../07-skill-design-principles/)
