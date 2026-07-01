#!/usr/bin/env bash
# prewarm.sh — run this BEFORE you walk on stage, on the conference wifi if you can.
# It pulls every network-dependent thing so the live demo doesn't do a cold fetch in
# front of the room. Nothing here mutates cloud infra.
set -uo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"

ok=0; warn=0
step(){ printf '\n==> %s\n' "$1"; }
note(){ printf '    %s\n' "$1"; }

step "APM CLI present?"
if command -v apm >/dev/null 2>&1; then note "ok  $(apm --version 2>/dev/null)"; ok=$((ok+1)); else note "MISSING — curl -sSL https://aka.ms/apm-unix | sh"; warn=$((warn+1)); fi

step "apm install (resolves Pulumi skills, community runbooks, MCP, LSP into .claude/)"
( cd "$ROOT" && apm install ) && { note "ok"; ok=$((ok+1)); } || { note "FAILED — fix before the talk"; warn=$((warn+1)); }

step "pre-pull the Pulumi MCP server (npx cold-fetch is the #1 stage stall)"
npx -y @pulumi/mcp-server@latest --help >/dev/null 2>&1 && { note "ok"; ok=$((ok+1)); } || { note "WARN — could not pre-pull @pulumi/mcp-server"; warn=$((warn+1)); }

step "LSP server binaries on \$PATH?"
for b in typescript-language-server pyright-langserver gopls; do
  if command -v "$b" >/dev/null 2>&1; then note "ok  $b"; else note "MISSING $b — run demo/install-lsp-servers.sh"; warn=$((warn+1)); fi
done

step "LSP demo project deps (so types resolve live)"
( cd "$HERE/pulumi-ts" && npm install --silent ) && { note "ok"; ok=$((ok+1)); } || { note "WARN — npm install in demo/pulumi-ts failed"; warn=$((warn+1)); }

step "kind available for the incident-triage demo?"
command -v kind >/dev/null 2>&1 && note "ok — run demo/setup-cluster.sh" || note "WARN — kind missing; skip the live cluster or use a recording"

printf '\n=== prewarm summary: %s ok, %s warnings ===\n' "$ok" "$warn"
[ "$warn" -gt 0 ] && echo "Resolve warnings or have a recorded fallback for those demos." || echo "All warm. Break a leg."
exit 0
