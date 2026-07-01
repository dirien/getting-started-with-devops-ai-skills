---
name: esc-secret-rotation
description: >-
  Rotate a leaked or expiring secret using Pulumi ESC — find every environment that
  references it, rotate it at the source, and verify consumers pick up the new value.
  Use when someone reports a leaked credential, a key that needs rotating, or asks to
  "rotate", "revoke", or "roll" a secret/token/API key.
metadata:
  owner: platform-team
  version: 0.1.0
  # This runbook MUTATES (rotate, set, revoke). It is gated by human approval, which is a
  # convention the agent follows — these metadata fields are NOT enforced by the runtime.
---

# ESC secret rotation

Builds on the `pulumi-esc` agent skill for the raw ESC mechanics. This skill adds the
**rotation runbook**: do it in the right order so nothing breaks and nothing static
is left to leak.

## When to use

"We leaked a key", "rotate the <X> credential", "this token is expiring", "revoke and
re-issue the API key for <service>".

## Procedure

1. **Find every reference (read-only).** Don't assume one place. Search ESC environments
   and stack configs for the secret name:
   ```bash
   scripts/find-references.sh <secret-name>
   ```
   List every environment and stack that imports or reads it.

2. **Prefer dynamic over static.** If this secret is a long-lived cloud credential, the
   real fix is to replace it with an ESC **dynamic login (OIDC)** so there's nothing to
   rotate next time. Flag that as the recommended follow-up.

3. **Rotate at the source.** Rotate in the upstream provider (the cloud IAM, 1Password,
   Vault, the SaaS) — ESC resolves providers live, so a single upstream rotation
   propagates to every environment that imports it.

4. **Update static values only where unavoidable.** For a genuinely static secret:
   ```bash
   pulumi env set <org>/<project>/<env> --secret <path> <new-value>
   ```

5. **Verify propagation.** Open each affected environment and confirm the new value
   resolves. Note: `pulumi env open` **decrypts secrets to your terminal** — only run it
   where that's safe, and never paste the output anywhere.
   ```bash
   pulumi env open <org>/<project>/<env>
   ```

6. **Revoke the old credential.** Only after consumers are confirmed healthy. Then the
   leaked value is dead.

7. **Confirm nothing static is left.** Grep history / state for the old value's shape;
   make sure it isn't pasted into a `.env`, a `tfvars`, or a CI variable.

## Safety rules

> Honesty: this runbook **changes things**. "Approval-gated" is a convention the agent
> follows, not a runtime sandbox. The deterministic backstops are Claude Code permissions,
> the block-pulumi hook, and Pulumi Cloud policy — not this file's metadata.

- **Discovery is read-only** (step 1). Every mutating step (3, 4, 6) needs explicit human
  approval before it runs.
- **Rotate at the source**, let ESC propagate; don't hand-edit ten environments.
- **Revoke last**, after consumers are verified, to avoid an outage.
- The end state should have **no static long-lived credential**; push toward OIDC.
