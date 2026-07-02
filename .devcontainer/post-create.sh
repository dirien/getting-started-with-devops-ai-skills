#!/usr/bin/env bash
# post-create.sh — runs once after the container is built. Sequential (unlike the
# parallel object form of postCreateCommand) because these steps depend on each other:
# install the toolchain, then `apm install` to wire skills + MCP + LSP + hooks.
set -uo pipefail
# Codespaces runs lifecycle scripts with umask 077 — files extracted here (APM's
# libpython, gopls) would land root-owned and unreadable. Force sane perms.
umask 022
export PATH="$HOME/.local/bin:$PATH"
WS="${1:-$PWD}"
cd "$WS"

log() { printf '\n\033[1;35m==> %s\033[0m\n' "$1"; }

log "APM CLI (Agent Package Manager)"
curl -sSL https://aka.ms/apm-unix | sh || echo "  (apm install failed — retry: curl -sSL https://aka.ms/apm-unix | sh)"

log "Language servers for the LSP demo (APM writes config, not the binaries)"
npm install -g prettier typescript typescript-language-server pyright || true

log "gopls (Go language server)"
if command -v go >/dev/null 2>&1; then
  go install golang.org/x/tools/gopls@latest && sudo cp "$(go env GOPATH)/bin/gopls" /usr/local/bin/gopls || true
fi

log "kind (for the incident-triage demo cluster)"
arch=$(uname -m); case "$arch" in aarch64|arm64) arch=arm64 ;; *) arch=amd64 ;; esac
curl -fsSLo /tmp/kind "https://kind.sigs.k8s.io/dl/latest/kind-linux-${arch}" && sudo install /tmp/kind /usr/local/bin/kind || echo "  (kind install skipped)"

log "uv (Python tooling)"
curl -LsSf https://astral.sh/uv/install.sh | sh || true
grep -q '.local/bin' "$HOME/.bashrc" 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"

log "apm install — wiring skills, MCP, LSP config, and the guardrail hook into .claude/"
( export PATH="$HOME/.local/bin:$PATH" && apm install ) || echo "  (run 'apm install' manually once you're in)"

log "Slidev deck dependencies"
( cd "$WS/slides" && npm install ) || true

log "LSP demo project dependencies"
( cd "$WS/demo/pulumi-ts" && npm install ) || true

# Show the welcome banner on each new shell.
if ! grep -q 'banner.sh' "$HOME/.bashrc" 2>/dev/null; then
  echo "[ -f \"$WS/.devcontainer/banner.sh\" ] && bash \"$WS/.devcontainer/banner.sh\"" >> "$HOME/.bashrc"
fi

log "Done. Open a new terminal for the banner, then authenticate your agent (see README)."
