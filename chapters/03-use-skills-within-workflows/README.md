# 03 · Use skills within agent workflows

> **Lesson goal:** see a skill do real work — the agent triggers it *itself* from a plain
> request, inside an actual DevOps task.

---

## You don't "call" a skill — the agent picks it

This is the part that surprises people. You never type "use the golden-path skill."
You make a normal request, and the agent matches it to a skill's **`description`** (the
trigger) and loads the skill on its own.

```text
You:  "Start a new payments service — AWS, TypeScript."

Agent:  → matches golden-path-service (description mentions "start a new service")
        → loads the SKILL.md body
        → pulumi new aws-typescript …
        → wires config to ESC (OIDC, no static keys)
        → applies standard tags
        → pulumi preview  ✅  (waits for your approval — no `up` unprompted)
```

That's the payoff of a good `description`: the right skill fires at the right moment.

## Skills + MCP, together

In this workflow two things are happening:

- the **skill** supplies the *know-how* (our golden-path procedure), and
- the **Pulumi MCP server** supplies *live access* (registry lookups, validating the
  code, reaching Pulumi Cloud).

The skill teaches the agent *how* to drive the MCP server. Static knowledge + live
tools. When the job outgrows your session, the `pulumi-neo-handoff` skill packages it
into a Pulumi Neo task.

## Try it

With the skills installed (chapter 02), ask your agent:

1. *"Triage this — the `payments` pods are in CrashLoopBackOff in `prod`."* → watch
   `incident-triage` fire, run `gather-diagnostics.sh`, and propose a fix (read-only).
2. *"We think the Stripe key leaked — rotate it."* → watch `esc-secret-rotation` walk
   the runbook and **revoke last**.

## ✅ What good looks like

The agent reached for the right skill **without being told which one**, followed its
steps, and respected the safety defaults (preview/read-only). If it grabbed the wrong
skill, the `description` is the thing to fix (chapter 07).

➡️ Next: [04 · Anatomy of a skill](../04-anatomy-of-a-skill/)
