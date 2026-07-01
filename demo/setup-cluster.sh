#!/usr/bin/env bash
# setup-cluster.sh — stand up a throwaway kind cluster with a CrashLoopBackOff workload
# so the incident-triage demo has a real broken pod to triage.
#   Prereqs: docker (or podman), kind, kubectl.
#   Teardown: kind delete cluster --name devops-ai-skills
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLUSTER="${CLUSTER:-devops-ai-skills}"

if ! command -v kind >/dev/null 2>&1; then
  echo "kind is not installed. See https://kind.sigs.k8s.io/ (brew install kind)." >&2
  exit 1
fi

if ! kind get clusters 2>/dev/null | grep -qx "$CLUSTER"; then
  echo "==> creating kind cluster '$CLUSTER'"
  kind create cluster --name "$CLUSTER"
else
  echo "==> kind cluster '$CLUSTER' already exists"
fi

echo "==> applying the crashlooping 'payments' workload"
kubectl apply -f "$HERE/k8s/crashloop.yaml"

echo "==> waiting a few seconds for it to crashloop..."
sleep 8
kubectl -n demo get pods -o wide || true

cat <<EOF

Ready. Now drive the skill, e.g. in Claude Code:
  "Triage this — the payments pods are CrashLoopBackOff in the demo namespace."
or run the bundled script directly:
  .apm/skills/incident-triage/scripts/gather-diagnostics.sh demo payments

Teardown when done:  kind delete cluster --name $CLUSTER
EOF
