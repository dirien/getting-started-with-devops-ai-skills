# 07 · Following skill design principles

> **Lesson goal:** learn the handful of principles that separate a skill the agent
> *actually uses correctly* from one it ignores or misfires.

---

## The principles

### 1. The description is the trigger — write it for discovery
The agent decides whether to load a skill from its **`description`** alone. Make it say
*what the skill does* **and** *when to use it*, in concrete terms.

```yaml
# weak — vague, won't trigger reliably
description: Helps with Pulumi.

# strong — names the task and the trigger conditions
description: >-
  Bootstrap a new Pulumi project with our org's standard layout, ESC
  environment, and CI. Use when someone asks to start a new stack/service
  or scaffold infrastructure-as-code.
```

### 2. One skill, one job
A skill that "does everything Kubernetes" competes with itself. Prefer small, sharply
scoped skills (`k8s-triage-crashloop`, `helm-release-bump`) over a mega-skill.

### 3. Keep `SKILL.md` short; push detail into bundled files
`SKILL.md` is loaded into context when triggered — keep it lean. Move long references,
schemas, and examples into separate files the agent reads **only if needed**.

```
incident-triage/
├── SKILL.md            # the procedure, concise
├── references/
│   └── severity-matrix.md
└── scripts/
    └── gather-diagnostics.sh
```

### 4. Prefer deterministic scripts over prose for deterministic steps
If a step is "run these exact commands," ship a **script** and tell the agent to run it.
Don't make the model re-derive a fragile command each time. Prose for judgement, scripts
for procedure.

### 5. Name things the way your team talks
Skill names and trigger words should match how engineers actually phrase the request, so
the agent's matching lines up with reality.

### 6. Make it safe by default
DevOps skills touch real infrastructure. Bias toward **plan/preview/dry-run first**,
require explicit confirmation before mutating, and never bake in long-lived credentials.

---

## DevOps anti-patterns to avoid

| Anti-pattern | Fix |
|---|---|
| Skill that hard-codes secrets/keys | Reference ESC / a secrets manager; nothing static |
| Skill that runs `pulumi up` unprompted | Preview first, confirm, then apply |
| 600-line `SKILL.md` | Split into `references/` files, keep the procedure tight |
| Description that just repeats the name | Describe the *task* and the *trigger* |
| One skill that wraps your entire platform | Decompose into focused skills |

## ✏️ Exercise

Take the skill you built in [chapter 05](../05-build-a-skill-from-scratch/) and run it
through the six principles. Rewrite its `description` for discovery and split out at least
one bundled reference file.

➡️ Next: [08 · Keep skills up to date](../08-keep-skills-up-to-date/)
