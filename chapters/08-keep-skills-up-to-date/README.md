# 08 · Keeping your skills up to date

> **Lesson goal:** treat skills like the rest of your platform — versioned, reviewed,
> and kept current — instead of stale snippets that rot.

---

## Skills rot like documentation does

A skill that says *"deploy with `pulumi up --yes`"* is wrong the day your team adopts
preview-gated deploys. Because the agent *acts* on skills, a stale skill is worse than
stale docs — it confidently does the wrong thing.

## Keep them current

1. **Version control.** Skills live in git next to the code/runbooks they describe. A
   change to the runbook and a change to the skill go in the **same PR**.
2. **Review them like code.** A bad `description` or an unsafe default is a bug. Put
   skills through the same review as any other change.
3. **Pin and bump deliberately.** When you consume someone else's skills (e.g. the Pulumi
   set), pin a version and bump on purpose — don't silently float.
4. **Re-test on agent/model upgrades.** A new model may trigger or interpret a skill
   differently. Keep a couple of smoke prompts per critical skill.

```bash
apm outdated                 # what has newer versions available
apm update                   # re-resolve dependencies, refresh apm.lock.yaml
apm install --frozen         # CI: install exactly the lockfile (like `npm ci`)
apm audit --ci               # gate: detect drift between lockfile and working tree

# Per-machine (course CLI):
npx skills update            # refresh installed skills / restore from skills-lock.json
```

> `apm update` re-resolves your dependencies; `apm self-update` upgrades the APM CLI
> itself — they're different commands.

## A lightweight "skill health" checklist

- [ ] Does the `description` still match what the skill does?
- [ ] Do the commands still exist and still take those flags?
- [ ] Are the defaults still safe (preview-first, no static creds)?
- [ ] Do the bundled references point at the current schema/version?
- [ ] Has anyone actually used it this quarter? (If not, see chapter 09.)

## ✏️ Exercise

Add a one-line CHANGELOG to a skill you built, and open a PR that bumps a command flag —
notice that the skill change rides along with the workflow change.

➡️ Next: [09 · Removing Agent Skills](../09-remove-skills/)
