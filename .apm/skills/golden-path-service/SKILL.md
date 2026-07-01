---
name: golden-path-service
description: >-
  Scaffold a new service on our golden path — a Pulumi project wired to ESC for
  config, OIDC for cloud auth (no static keys), standard tags, and a
  preview-before-apply workflow. Use when someone asks to start a new service,
  stack, or infrastructure-as-code project, or to "follow the golden path".
metadata:
  owner: platform-team
  version: 0.1.0
---

# Golden path: new service

This skill encodes how **our team** starts a new service. It builds on the Pulumi
agent skills (`pulumi-typescript` / `pulumi-python`, `pulumi-cli`, `pulumi-esc`) —
lean on those for the raw Pulumi mechanics; this skill adds our conventions on top.

## When to use

A teammate says any of: "start a new service", "new Pulumi stack for X", "scaffold
infra for Y", "set this up on the golden path".

## Procedure

1. **Gather the inputs** (ask, don't assume):
   - service name (kebab-case)
   - cloud: `aws` | `gcp` | `azure`
   - language: `typescript` | `python` | `go`
   - environments needed (default: `dev`, `prod`)

2. **Scaffold the project** using the Pulumi CLI skill:
   ```bash
   pulumi new <cloud>-<language> --name <service> --dir <service>-infra
   ```

3. **Move config + secrets into ESC** — never `Pulumi.<stack>.yaml` secrets, never
   `.env` on a laptop. Create one environment per stack and import a shared base:
   ```bash
   pulumi env init <org>/<service>/base
   pulumi env init <org>/<service>/dev   # imports base
   pulumi env init <org>/<service>/prod  # imports base
   ```
   Reference the env from `Pulumi.<stack>.yaml` with `environment:`.

4. **Use OIDC for cloud auth.** Configure the ESC environment to mint short-lived
   credentials via OIDC. Do **not** create a long-lived IAM user / service-account key.

5. **Apply standard tags** to every resource (use a transformation / default tags):
   `team`, `service`, `env`, `managed-by=pulumi`, `cost-center`.

6. **Never run `pulumi up` unprompted.** Always `pulumi preview` first, show the diff,
   and wait for explicit confirmation before applying.

## Safety defaults

- Preview before apply, every time.
- No static credentials anywhere — OIDC + ESC only.
- `prod` requires an explicit, separate confirmation from `dev`.

## What good looks like

A new repo with a Pulumi project, ESC environments wired for config + OIDC, standard
tags applied, and a clean `pulumi preview` for `dev`. Hand off to `pulumi-neo-handoff`
or open a PR for review — don't apply to `prod` without a human.
