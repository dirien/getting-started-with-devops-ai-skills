# 01 · Discover and evaluate existing skills

> **Lesson goal:** before you write a skill, find out whether a good one already exists —
> and learn to judge whether it's safe to trust with your infrastructure.

---

## Don't write what you can adopt

The fastest skill is the one someone already built and battle-tested. For DevOps that
increasingly means **vendor-published** skills (Pulumi, cloud providers) and community
collections.

Where to look:

- **Vendor skill sets** — e.g. the **Pulumi** Agent Skills (we install these in chapter 02)
- **Your agent's marketplace / plugins** — Claude Code skills & plugins, etc.
- **Package registries for agent primitives** — e.g. **APM** (chapter 02)
- **Your own org repo** — the skills your teammates already wrote

```bash
# Search across skills (agentskills.io CLI)
npx skills find kubernetes
npx skills find terraform

# Browse Pulumi's catalogue — 14 skills in 4 plugin groups
#   github.com/pulumi/agent-skills  →  migration · pulumi · delegation · package-maintenance
npx skills add pulumi/agent-skills/pulumi --skill '*'   # (you'll install in ch. 02)

# With APM, search the marketplaces you've added
apm search pulumi
```

## Evaluate before you trust

A skill *acts on your infrastructure*. Vet it like you'd vet a GitHub Action you give
cloud credentials to. Score each candidate:

| Question | Why it matters |
|---|---|
| **Who publishes it?** | Vendor/maintained ≠ random gist. Provenance is risk. |
| **What can it run?** | Does it shell out? Touch creds? `pulumi up`? Read the scripts. |
| **Is the `description` honest?** | If it over-claims its trigger, it'll fire on the wrong tasks. |
| **Is it safe by default?** | Preview-first? Confirmations before mutation? |
| **Is it maintained?** | Recent commits, versioning, a changelog. |
| **Does it fit your stack?** | A Terraform skill won't help a Pulumi shop, and vice-versa. |

> **Rule of thumb:** read the whole `SKILL.md` and every script it bundles *before* you
> enable it. If you wouldn't merge it as a PR, don't install it as a skill.

### What `apm install` actually puts on disk

Know your supply chain. When you depend on a community repo, `apm install` **clones the
whole repo** into `apm_modules/` (gitignored) — not just the one `SKILL.md` you referenced.
For `bregman-arie/devops-sre-skills` that means its Terraform/AWS skills, `.github/workflows`,
and `validate_skills.py` land on the laptop too; only the referenced skill is *integrated*
into `.claude/`. APM's "security scan" is a **hidden-Unicode** check (tag chars, bidi
overrides) on installed primitives — it is **not** a review of what the scripts do. That's
still your job. Pin deps with `#<tag>`/`#<sha>` so a repo can't change under you.

## 🔍 Exercise

Pick two skills from the Pulumi set (or any catalogue) and fill in the table above for
each. Decide: adopt, adapt, or write your own?

➡️ Next: [02 · Connect skills to your agent](../02-connect-skills-to-your-agent/)
