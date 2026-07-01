# 10 · Turn everyday workflows into skills

> **Lesson goal:** leave with a repeatable habit — every time you do a fiddly DevOps task
> twice, capture it as a skill the third time pays for itself.

---

## The habit

You already have the source material: the commands in your shell history, the steps in
your wiki, the tribal knowledge in your head. A skill is just that, written down in a way
the agent can act on.

```mermaid {scale: 1.0, theme: 'base', themeVariables: { 'background': 'transparent', 'primaryColor': '#1f1d3a', 'primaryTextColor': '#e9e7ff', 'primaryBorderColor': '#7e6bff', 'lineColor': '#9b8cff', 'fontFamily': 'Inter, ui-sans-serif, system-ui' } }
flowchart LR
  a["You do a task<br/>(twice)"] --> b["Write down<br/>the steps"]
  b --> c["Wrap as SKILL.md<br/>+ scripts"]
  c --> d["Agent runs it<br/>every time after"]
  d --> e["Refine when<br/>it misfires"]
  e --> c
```

## A recipe

1. **Pick a real, repeated workflow.** Good candidates: "rotate a leaked credential,"
   "spin up a preview environment for a PR," "triage a CrashLoopBackOff," "open a new
   service from the golden path."
2. **Narrate it once.** Do the task and capture every command and decision.
3. **Split judgement from procedure.** Decisions → prose in `SKILL.md`. Exact commands →
   a script in `scripts/`.
4. **Write the `description` for the trigger** (see [chapter 07](../07-skill-design-principles/)).
5. **Make it safe by default.** Preview/dry-run, confirm before mutating, no static creds.
6. **Try it, watch it misfire, refine.** The first version is a draft; usage finds the gaps.

## Five DevOps workflows worth capturing

| Everyday workflow | Becomes a skill that… |
|---|---|
| "Start a new service" | scaffolds the Pulumi project on the golden path |
| "We leaked a key" | walks the ESC/secrets rotation runbook |
| "Preview env for this PR" | stands up + tears down an ephemeral stack |
| "Pod won't start" | gathers diagnostics and proposes a fix |
| "Is prod tagged right?" | audits tags/regions against policy |

## ✏️ Capstone exercise

Take one workflow you personally did this week, and turn it into a skill end-to-end —
frontmatter, body, one script, one reference file. That's the whole point of the workshop:
your runbooks, running themselves.

---

🎉 **That's the workshop.** Everything you saw is in this repo — go make your agent yours.
