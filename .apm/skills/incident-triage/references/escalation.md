# Escalation & comms

Read this for Sev1/Sev2 incidents.

## Roles (assign these first)

- **Incident Commander (IC)** — owns the response, makes the calls. Not the person
  with hands on the keyboard.
- **Ops / hands-on-keyboard** — runs the approved commands.
- **Comms** — owns status updates (internal + external), keeps the timeline.

## First status update (template)

> **[Sev2] <service> degraded** — since <time UTC>. Impact: <one sentence>. We're
> investigating; next update in 30 min. IC: <name>.

## Cadence

- Sev1: update every 15 minutes, even if "no change".
- Sev2: update every 30 minutes.
- Always post when severity changes or the incident resolves.

## Who to pull in

| Area | Escalate to |
|---|---|
| Cloud account / IAM | platform on-call |
| Data / migrations | the owning service team + DBA |
| Security / suspected breach | security on-call (do NOT touch evidence) |
| Customer-facing | support lead + comms |

> If it's a suspected secret exposure or breach, switch to the security runbook and
> **preserve evidence** — don't restart or delete the affected workloads.
