#!/usr/bin/env bash
# guard-pulumi.sh — a PreToolUse guardrail for the Bash tool.
#
# WHAT THIS IS: a fast, local *nudge*. It catches the obvious case — the agent about
# to run `pulumi up`/`update`/`destroy` directly in the shell — and blocks it so a human
# previews and approves first.
#
# WHAT THIS IS NOT: real enforcement. A client-side Bash hook CANNOT stop every path:
#   - the agent can deploy via the Pulumi Automation API skill or the Pulumi MCP server
#     (those never touch the Bash tool, so this hook never sees them);
#   - a wrapper like `make deploy` hides the string entirely;
#   - the agent has the Write/Edit tool and could rewrite this script or settings.json.
# The REAL guardrail is server-side: Pulumi Cloud deployment policies + OIDC-scoped,
# short-lived credentials. Use this hook as defense-in-depth, not as the wall.
#
# Contract (Claude Code): the tool call arrives as JSON on stdin —
#   { "tool_input": { "command": "pulumi up --yes" }, ... }
# Exit 2 = BLOCK and feed stderr back to the agent. Any other exit = allow.
# We FAIL CLOSED: if we can't read the command, we block rather than wave it through.
set -uo pipefail

input=$(cat)

extract_command() {
  if command -v python3 >/dev/null 2>&1; then
    printf '%s' "$1" | python3 -c \
'import sys,json
try:
    print(json.load(sys.stdin).get("tool_input",{}).get("command",""))
except Exception:
    sys.exit(3)' && return 0
    return 3
  fi
  # No python3: crude but dependency-free fallback.
  local c
  c=$(printf '%s' "$1" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
  [ -n "$c" ] && { printf '%s' "$c"; return 0; }
  return 3
}

cmd=$(extract_command "$input") || {
  echo "block-pulumi-mutations: could not parse the tool input — failing closed. Have a human review before re-running." >&2
  exit 2
}

# Block any pulumi invocation that reaches `up`/`update`/`destroy`, even with flags in between
# (e.g. `pulumi --stack prod update`, `pulumi -C infra destroy`). Over-blocking is fine; a
# false positive just asks for a human, which is the safe default.
if printf '%s' "$cmd" | grep -Eq 'pulumi' \
   && printf '%s' "$cmd" | grep -Eq '(^|[^[:alnum:]_])(up|update|destroy)([^[:alnum:]_]|$)'; then
  echo "BLOCKED by block-pulumi-mutations: this looks like 'pulumi up' / 'update' / 'destroy'." >&2
  echo "Run 'pulumi preview', show the plan, and get explicit human approval before applying." >&2
  echo "(This hook is a local nudge over the Bash tool only — real enforcement is Pulumi Cloud policy + OIDC creds.)" >&2
  exit 2
fi

exit 0
