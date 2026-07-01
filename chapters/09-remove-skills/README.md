# 09 · Removing Agent Skills

> **Lesson goal:** remove a skill cleanly so it stops triggering — without leaving
> dangling references or breaking the agent.

---

## Why removal matters

Every installed skill costs a little context (its `name` + `description` are always
loaded) and adds a chance of **mis-triggering**. Skills you don't use are not free — prune
them.

Reasons to remove a skill:

- It's been **superseded** (a better skill, or a native agent capability now covers it).
- It's **wrong/unsafe** and can't be fixed quickly — pull it *now*, fix later.
- It's **unused** — nobody's triggered it in months.
- It **collides** with another skill and confuses the agent's matching.

## Remove it cleanly

1. **Delete the skill directory** from where it's installed (personal, project, or plugin).
2. **Remove it from the manifest** if it was installed via a package manager (so it doesn't
   come back on the next sync).
3. **Grep for references** — other skills or docs that point at it.
4. **Restart / re-scan** so the agent drops it from its available list.

```bash
# Remove a dependency via APM (also drops it from apm.yml + apm.lock.yaml)
apm uninstall pulumi/agent-skills/pulumi

# Remove a skill you authored: delete the source, then re-integrate
rm -rf .apm/skills/<skill-name> && apm install

# Per-machine (course CLI):
npx skills remove <skill-name>

# Hand-authored skills (no manifest) live at:
rm -rf ~/.claude/skills/<skill-name>     # personal scope
rm -rf .claude/skills/<skill-name>       # project scope
```

> **Tip:** disabling beats deleting when you're unsure. Move it out of the skills path (or
> mark it disabled) so you can restore it without digging through git history.

## ✅ Verify

Ask the agent to list its skills — the removed one should be gone, and a prompt that used
to trigger it no longer does.

➡️ Next: [10 · Turn everyday workflows into skills](../10-turn-workflows-into-skills/)
