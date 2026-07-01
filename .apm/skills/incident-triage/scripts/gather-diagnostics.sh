#!/usr/bin/env bash
# gather-diagnostics.sh — read-only Kubernetes incident diagnostics.
# Usage: gather-diagnostics.sh <namespace> <workload>
# Pin the cluster explicitly:  KUBE_CONTEXT=kind-devops-ai-skills gather-diagnostics.sh demo payments
# Collects status, events, restarts, logs, and rollout history. Mutates nothing.
set -euo pipefail

NS="${1:?usage: gather-diagnostics.sh <namespace> <workload>}"
WORKLOAD="${2:?usage: gather-diagnostics.sh <namespace> <workload>}"

# Be explicit about WHICH cluster we're reading. Don't silently inherit a prod context.
KCTX_ARGS=()
if [ -n "${KUBE_CONTEXT:-}" ]; then KCTX_ARGS=(--context "$KUBE_CONTEXT"); fi
kubectl() { command kubectl "${KCTX_ARGS[@]}" "$@"; }

ACTIVE_CTX=$(command kubectl "${KCTX_ARGS[@]}" config current-context 2>/dev/null || echo "?")
echo "==== context check ===="
echo "Reading from context: ${ACTIVE_CTX}   (namespace: ${NS}, workload: ${WORKLOAD})"
echo "Read-only diagnostics. Set KUBE_CONTEXT to pin a cluster and avoid prod by accident."

hr() { printf '\n==== %s ====\n' "$1"; }

hr "Pods in $NS (wide)"
kubectl -n "$NS" get pods -o wide || true

hr "Workload status: $WORKLOAD"
kubectl -n "$NS" get deploy,sts,ds "$WORKLOAD" -o wide 2>/dev/null || true
kubectl -n "$NS" describe deploy "$WORKLOAD" 2>/dev/null | sed -n '1,40p' || true

hr "Recent events (last 30, by time)"
kubectl -n "$NS" get events --sort-by=.lastTimestamp | tail -30 || true

hr "Restart counts"
kubectl -n "$NS" get pods -o \
  'custom-columns=POD:.metadata.name,RESTARTS:.status.containerStatuses[*].restartCount,STATE:.status.phase' \
  2>/dev/null || true

hr "Logs (last 200 lines, current + previous)"
for pod in $(kubectl -n "$NS" get pods -l "app.kubernetes.io/name=$WORKLOAD" -o name 2>/dev/null | head -3); do
  echo "--- $pod (current) ---";  kubectl -n "$NS" logs "$pod" --tail=200 2>/dev/null || true
  echo "--- $pod (previous) ---"; kubectl -n "$NS" logs "$pod" --tail=200 --previous 2>/dev/null || true
done

hr "Rollout history: $WORKLOAD"
kubectl -n "$NS" rollout history deploy/"$WORKLOAD" 2>/dev/null || true

hr "Node pressure"
kubectl top nodes 2>/dev/null || echo "(metrics-server not available)"

echo
echo "Diagnostics complete. This script is READ-ONLY — propose changes for a human to approve."
