#!/usr/bin/env bash
# Printed on each new shell inside the devcontainer.
cat <<'BANNER'

  ┌────────────────────────────────────────────────────────────────┐
  │  Getting Started with DevOps AI Skills — workshop environment    │
  └────────────────────────────────────────────────────────────────┘

  Agents & tools installed:  Claude Code · Codex · Pulumi · APM
                             Node · Python · Go · kubectl · helm · kind

  1. Authenticate an agent:
       claude          # OAuth (port 19999 is forwarded), or set ANTHROPIC_API_KEY
       codex           # set OPENAI_API_KEY
       pulumi login    # or set PULUMI_ACCESS_TOKEN

  2. Skills/MCP/LSP/hook are already wired via `apm install`. Verify:
       apm list        # or: ls .claude/skills

  3. Run the deck:            cd slides && npm run dev     (port 3030)
     Incident demo cluster:   demo/setup-cluster.sh
     Work the chapters:       chapters/00-introduction/

BANNER
