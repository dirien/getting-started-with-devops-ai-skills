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
  # A devcontainer rebuild keeps the inner-docker volume (so kind sees the cluster)
  # but wipes ~/.kube/config. Re-export it; if the cluster is still unreachable,
  # it's stale — recreate it.
  kind export kubeconfig --name "$CLUSTER" 2>/dev/null || true
  if ! kubectl cluster-info >/dev/null 2>&1; then
    echo "==> cluster unreachable (stale after a rebuild?) — recreating"
    kind delete cluster --name "$CLUSTER"
    kind create cluster --name "$CLUSTER"
  fi
fi

echo "==> applying the crashlooping 'payments' workload"
kubectl apply -f "$HERE/k8s/crashloop.yaml"

echo "==> waiting a few seconds for it to crashloop..."
sleep 8
kubectl -n demo get pods -o wide || true

cat <<EOF

Ready. Now drive the skill, e.g. in Claude Code:
  "We have a prod incident: the payments pods are in CrashLoopBackOff in the demo
   namespace. Triage it — gather diagnostics, classify severity, and propose a
   stabilization plan."
(That wording targets incident-triage; a bare "triage this crashloop" may match the
 narrower community diagnose-crashloop runbook instead.)
or run the bundled script directly:
  .apm/skills/incident-triage/scripts/gather-diagnostics.sh demo payments

Teardown when done:  kind delete cluster --name $CLUSTER
EOF
