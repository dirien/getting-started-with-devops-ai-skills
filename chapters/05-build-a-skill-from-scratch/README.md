# 05 · Building Agent Skills from scratch

> **Lesson goal:** author your first DevOps skill — a single `SKILL.md` — and have your
> agent use it.

We'll build **`golden-path-service`**: the skill that scaffolds a new service the way
your team wants it done. The finished version lives at
[`.apm/skills/golden-path-service/`](../../.apm/skills/golden-path-service/SKILL.md).

---

## Step 1 — make the folder

In an APM package, skills are authored under `.apm/skills/<name>/`. The folder name
**must match** the skill's `name`.

```bash
mkdir -p .apm/skills/golden-path-service
```

## Step 2 — write `SKILL.md`

Two required frontmatter fields, then the procedure:

```markdown
---
name: golden-path-service           # lowercase + hyphens, matches the folder, ASCII
description: >-                       # THE TRIGGER — what it does AND when to use it
  Scaffold a new service on our golden path — a Pulumi project wired to ESC for
  config, OIDC for cloud auth (no static keys), standard tags, and a
  preview-before-apply workflow. Use when someone asks to start a new service,
  stack, or infrastructure-as-code project.
---

# Golden path: new service

1. Ask for cloud (aws|gcp|azure) and language (ts|python|go).
2. `pulumi new <cloud>-<language> --name <service>`
3. Wire config + secrets into ESC (never local secret files); use OIDC, not static keys.
4. Apply standard tags: team, service, env, managed-by=pulumi, cost-center.
5. Always `pulumi preview` first — never run `pulumi up` unprompted.
```

### The rules that matter

| Field | Rule |
|---|---|
| `name` | ≤ 64 chars, lowercase/numbers/hyphens, matches the folder, no "anthropic"/"claude" |
| `description` | ≤ 1024 chars, **third person**, says *what it does* **and** *when to use it* |

The `description` is the only line you must get right — it's how the agent decides to
load the skill at all (see [chapter 07](../07-skill-design-principles/)).

## Step 3 — compile and use it

```bash
apm install                    # integrates it into .claude/skills/golden-path-service/
```

Then ask your agent: *"Start a new orders service, GCP, Python."* It should trigger the
skill and stop at `pulumi preview`.

> Prefer the course's tool? `npx skills init golden-path-service` scaffolds a `SKILL.md`
> too — APM just adds the manifest + lockfile around it.

## ✏️ Exercise

Write a second single-file skill for a task **you** do — e.g. `pr-preview-env` ("stand up
an ephemeral stack for this PR"). Get the `description` sharp enough that the agent fires
it from a natural request.

➡️ Next: [06 · Building complex Agent Skills](../06-build-complex-skills/)
