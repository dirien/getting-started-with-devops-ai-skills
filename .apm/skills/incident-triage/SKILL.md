---
name: incident-triage
description: >-
  Triage a production incident on Kubernetes or cloud infra — gather diagnostics,
  classify severity, propose a stabilization plan, and draft the comms/postmortem.
  Use when someone reports an outage, a degraded service, a CrashLoopBackOff, a
  pending/unschedulable pod, or asks to "triage" or "investigate" a prod issue.
metadata:
  owner: platform-team
  version: 0.1.0
  # default-mode is a hint for humans, not enforced by the agent runtime (see below).
  default-mode: read-only
---

# Incident triage

A safe-by-default runbook. The gathering step is genuinely read-only; you **propose** fixes
and a human approves before anything mutates production.

> Honesty: "read-only until approved" is a convention the agent follows, not a sandbox.
> `metadata.default-mode` is not enforced by Claude Code. The deterministic backstops are
> the bundled `gather-diagnostics.sh` (which only reads), Claude Code permissions, the
> block-pulumi hook, and your cluster's RBAC — not this frontmatter.

## When to use

Someone says: "X is down", "the cluster is degraded", "pods are CrashLoopBackOff",
"why won't this pod schedule", "we're paging on Y", "triage this incident".

## Procedure

1. **Establish scope.** Which service, which cluster/namespace, since when, what's the
   symptom and the blast radius? Don't guess — ask if it's unclear.

2. **Gather diagnostics (read-only).** Run the bundled script and read its output:
   ```bash
   scripts/gather-diagnostics.sh <namespace> <workload>
   ```
   It collects pod status, recent events, restart counts, logs (last 200 lines),
   resource pressure, and recent rollout history — nothing mutating.

3. **Classify severity.** Read `references/severity-matrix.md` and assign Sev1–Sev4.
   State the user impact in one sentence.

4. **Form a hypothesis.** Map the symptom to a likely cause (see the table below) and
   say what evidence supports it.

5. **Propose a stabilization plan — do NOT execute it yet.** Prefer the smallest safe
   action (rollback over hotfix). Spell out the exact commands and the rollback for
   each. Wait for a human to approve before running anything that changes state.

6. **Communicate.** If Sev1/Sev2, read `references/escalation.md`, draft the status
   update and assign incident roles.

7. **Capture the postmortem.** Fill `templates/postmortem.md` with the timeline and the
   follow-up actions.

## Symptom → likely cause

| Symptom | Look at first | Common cause |
|---|---|---|
| `CrashLoopBackOff` | logs + last exit code | bad config/env, failing migration, OOMKilled |
| `ImagePullBackOff` | events | wrong tag, missing registry creds |
| `Pending` pods | events + node capacity | no schedulable node, resource requests too high, taints |
| 5xx spike after deploy | rollout history | regression in the new revision → roll back |
| latency regression | resource pressure + HPA | throttling, under-provisioned, downstream dependency |

## Safety rules

- **Default to read-only.** Diagnostics never mutate.
- **Rollback beats hotfix** when a recent deploy correlates with the incident.
- **One change at a time**, each with its rollback stated up front.
- **Never** exfiltrate secrets or logs to anywhere outside the cluster.
