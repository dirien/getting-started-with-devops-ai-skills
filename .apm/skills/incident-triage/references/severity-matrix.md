# Severity matrix

Read this when classifying an incident. Pick the **highest** row that applies.

| Sev | Definition | Examples | Response |
|-----|------------|----------|----------|
| **Sev1** | Critical: full outage or data loss; revenue/safety impact | Prod API down org-wide; data corruption; security breach in progress | Page on-call immediately; assign IC; status page; all-hands |
| **Sev2** | Major: significant degradation; key feature unusable for many users | Checkout failing for a region; p99 latency 10×; one cluster down | Page on-call; assign IC; status update within 15 min |
| **Sev3** | Minor: limited impact; workaround exists | Single non-critical service degraded; elevated error rate, contained | Handle in business hours; ticket; no paging |
| **Sev4** | Low: cosmetic or internal-only; no user impact | Noisy alert; flaky dashboard; non-prod issue | Backlog; fix opportunistically |

## How to decide

1. Start from user impact, not from the alert. "How many users, how badly?"
2. If a recent deploy correlates, severity may drop once you roll back — but classify on
   **current** impact.
3. When in doubt between two levels, pick the **higher** one and downgrade later.

## What to state out loud

> "Classifying this **Sev2**: checkout is failing for ~all EU users since 14:05 UTC,
> started right after the `payments` rollout. Proposing a rollback."
