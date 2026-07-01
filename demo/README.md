# Demo fixtures

Everything the live demos need so they don't depend on luck.

| File | For which demo |
|------|----------------|
| `install-lsp-servers.sh` | Puts `typescript-language-server` / `pyright` / `gopls` on `$PATH` (APM doesn't install binaries). |
| `pulumi-ts/` | A real Pulumi TS program with a deliberate type error (`publicReadAccess`) so the **LSP demo** shows a live diagnostic. `npm install` it first. |
| `k8s/crashloop.yaml` | A `payments` Deployment that CrashLoopBackOffs, for the **incident-triage demo**. |
| `setup-cluster.sh` | `kind` cluster + applies the crashloop workload. |
| `prewarm.sh` | Run **before the talk**: pre-pulls `apm install`, the MCP server, npm + LSP deps, and checks each demo is green. |

See [`../PRESENTER.md`](../PRESENTER.md) for the run-of-show, the cut list, and the
wifi-dies fallback.

```bash
# typical pre-flight
demo/install-lsp-servers.sh
demo/prewarm.sh
demo/setup-cluster.sh
# teardown
kind delete cluster --name devops-ai-skills
```
