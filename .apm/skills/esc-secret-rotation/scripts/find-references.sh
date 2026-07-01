#!/usr/bin/env bash
# find-references.sh — read-only search for everywhere a secret is referenced.
# Usage: find-references.sh <secret-name>
set -euo pipefail
SECRET="${1:?usage: find-references.sh <secret-name>}"

echo "==== ESC environments referencing '$SECRET' ===="
# List environments, then grep each one's definition for the secret name.
pulumi env ls 2>/dev/null | while read -r env; do
  [ -z "$env" ] && continue
  if pulumi env get "$env" 2>/dev/null | grep -qi -- "$SECRET"; then
    echo "  - $env"
  fi
done || echo "(pulumi esc CLI not available)"

echo "==== Stack configs referencing '$SECRET' (local) ===="
grep -rIl --include='Pulumi.*.yaml' -- "$SECRET" . 2>/dev/null || echo "  (none found locally)"

echo
echo "Read-only search complete. Rotate at the source; let ESC propagate."
