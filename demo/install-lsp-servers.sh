#!/usr/bin/env bash
# install-lsp-servers.sh — APM writes .lsp.json but does NOT install the language-server
# binaries. This puts them on your $PATH so the LSP demo actually shows diagnostics.
set -euo pipefail

echo "==> TypeScript + Python language servers (npm)"
npm i -g typescript typescript-language-server pyright

echo "==> Go language server (gopls)"
if command -v go >/dev/null 2>&1; then
  go install golang.org/x/tools/gopls@latest
  echo "    gopls -> $(go env GOPATH)/bin/gopls  (make sure that's on \$PATH)"
else
  echo "    go not found — skipping gopls. Install Go if you demo a Go Pulumi program."
fi

echo
echo "==> verify they resolve on \$PATH:"
for b in typescript-language-server pyright-langserver gopls; do
  if command -v "$b" >/dev/null 2>&1; then echo "    ok   $b"; else echo "    MISSING $b"; fi
done
echo "These names must match the 'command' fields in apm.yml -> dependencies.lsp."
