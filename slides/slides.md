---
theme: "@pulumi/slidev-theme"
title: "Getting Started with DevOps AI Skills"
info: |
  Getting Started with DevOps AI Skills.
  Engin Diri, Pulumi.

  Build, share, and run Agent Skills for DevOps with Microsoft APM and Pulumi.
transition: slide-left
mdc: true
canvasWidth: 1920
aspectRatio: 16/9
highlighter: shiki
lineNumbers: false
layout: cover
defaults:
  layout: default
---

<div class="absolute inset-0 flex flex-col justify-center items-start px-20">
  <h1 class="!text-[5.4rem] !leading-[1.04] !font-semibold !tracking-tight !mb-6 !max-w-[95%]">
    Getting Started with DevOps AI Skills
  </h1>
  <p class="!mt-2 !text-[2.1rem] text-[var(--p-fg-muted)] !m-0 !leading-relaxed">
    Teach your agent your runbooks, using Agent Skills, APM, and Pulumi
  </p>
  <p class="!mt-6 !text-[1.8rem] text-[var(--p-fg-muted)] !m-0 !leading-relaxed">
    Engin Diri · Pulumi
  </p>
</div>

<!--
30s hook. Read the title, then the promise: your agent is smart but generic. It
doesn't know your golden paths, your runbooks, your infra conventions. Agent Skills
are how you teach it, small folders of instructions + scripts. Today we build a
handful for DevOps, the way you'd build them at work. You leave able to turn any
runbook into a skill.
-->

---

<div class="absolute inset-0 flex items-center px-24 gap-20">
  <div class="flex-shrink-0">
    <img src="/img/engin-diri.jpg" class="w-[28rem] rounded-2xl shadow-xl border-4" style="border-color: rgba(126,107,255,0.45)" alt="Engin Diri" />
  </div>
  <div class="flex-1">
    <h1 class="!text-[7rem] !leading-[1.02] !font-semibold !tracking-tight !mb-4 !text-[var(--p-primary)]">Engin Diri</h1>
    <p class="!text-[2.5rem] !leading-relaxed !m-0 opacity-90">
      Senior Solutions Architect at <strong class="!text-[var(--p-primary)]">Pulumi</strong>
    </p>
    <div class="!mt-8 flex items-center gap-8 !text-[1.5rem] opacity-70">
      <span class="flex items-center gap-2"><carbon-logo-x /> @_ediri</span>
      <span class="flex items-center gap-2"><carbon-logo-linkedin /> engin-diri</span>
      <span class="flex items-center gap-2"><carbon-logo-github /> dirien</span>
    </div>
    <p class="!mt-10 !text-[1.75rem] !leading-relaxed opacity-70 !m-0">
      Building platform tooling and infrastructure-as-code.<br/>
      Helping teams ship cloud infrastructure faster. With and without agents.
    </p>
  </div>
</div>

<!--
I'm Engin, Senior Solutions Architect at Pulumi. I build platform tooling and help
teams ship faster. I spend my days with both humans and AI agents writing infra. Today
is about making those agents actually useful for DevOps work.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !max-w-[95%]">Housekeeping & Agenda</h1>
</div>

<!--
~20s. Two beats: housekeeping (how to follow along, where the code is) and the
agenda (the arc of the workshop).
-->

---

# Housekeeping

<div class="zoom-content">

<ul class="!mt-8 !text-[1.6rem] !leading-relaxed space-y-5">
  <li>I'll <strong>present and demo</strong>, so you don't need to code along live</li>
  <li>Ask questions <strong>any time</strong>; treat this as a conversation</li>
  <li>Slides, chapters, and the finished skills go home in the <strong>repo</strong> (QR at the end)</li>
  <li>Everything I show, you can run yourself later. One chapter at a time.</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.7; }
</style>

<!--
~45s. Show-and-tell, not a lab. I drive; they watch and ask. Make the point that the
repo is the takeaway, every demo is a folder they can work through at home.
-->


---

# Today's Agenda

<div class="zoom-content">

<ul class="!mt-8 !text-[1.55rem] !leading-relaxed space-y-4">
  <li>What an Agent Skill is, and why DevOps needs them</li>
  <li>Find &amp; evaluate existing skills</li>
  <li>Connect &amp; configure the agent: skills, MCP, LSP, hooks</li>
  <li>The anatomy of a skill</li>
  <li>Build skills: from scratch, then complex</li>
  <li>Design principles, maintenance &amp; removal</li>
  <li>Turn an everyday runbook into a skill</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.5; }
</style>

<!--
~30s. Seven beats. Don't read the sub-text, say the beat and move on. The arc:
orient (what/why) → use what exists → understand → build → operate → make it yours.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6.5rem] !leading-tight !font-semibold !tracking-tight !m-0 text-[var(--p-primary)] !max-w-[95%]">What is an Agent Skill?</h1>
</div>

<!--
Section opener. ~3s. Then: the problem (generic agent), the fix (skills), the anatomy.
-->

---

# Your agent is smart. And generic.

<div class="zoom-content">

<p v-click class="!mt-8 !text-[1.4rem] !leading-relaxed">
  It writes great code. It does <span class="hl">not</span> know your
  <span class="hl-soft">golden paths</span>, your <span class="hl-soft">runbooks</span>, or your
  <span class="hl-soft">tagging and region conventions.</span>
</p>

<p v-click class="!mt-6 !text-[1.4rem] !leading-relaxed">
  So you paste the same context into every prompt. Again. And again. And it still
  reaches for the wrong component or forgets to <code>pulumi preview</code> first.
</p>

<p v-click class="!mt-6 !text-[1.4rem] !leading-relaxed">
  A <span class="hl">skill</span> packages that context <span class="hl">once</span>, and the
  agent loads it <span class="hl-soft">automatically</span> when the task calls for it.
</p>

</div>

<!--
~45s. The pain everyone in the room feels: the agent is generic, you re-paste your
conventions every time. DevOps work is full of repeatable, high-stakes procedures.
Skills turn "the thing in the wiki nobody reads" into something the agent executes.
-->

---

# A skill is a folder with a `SKILL.md`

```markdown
---
name: pulumi-stack-bootstrap
description: >-
  Scaffold a new Pulumi project on our org standard: ESC for config,
  OIDC for cloud auth, preview-before-apply. Use when someone asks to
  start a new stack, service, or IaC project.
---

# Pulumi stack bootstrap

1. Ask for cloud (aws|gcp|azure) and language (ts|python|go).
2. `pulumi new <cloud>-<language> --name <name>`
3. Wire config to ESC, not local secret files.
4. Always `pulumi preview` before suggesting `pulumi up`.
```

<p v-click class="!mt-7 !text-[1.5rem] !leading-relaxed">
  YAML frontmatter (<code>name</code> + <code>description</code>) on top, plain-Markdown
  instructions below. That's the whole format.
</p>

<style scoped>
:deep(.slidev-code) {
  font-size: 1.15rem !important;
  line-height: 1.5 !important;
  max-width: 92%;
  margin: 0.5rem 0 0;
  padding: 1rem 1.4rem;
  border-radius: 12px;
}
</style>

<!--
~60s. Show the format. The frontmatter is the contract; the body is the procedure.
This is a real DevOps skill, note the "preview before up" safety default. Don't read
the code; point at name/description and the numbered steps.
-->

---

# Progressive disclosure: why you can have dozens

<div class="grid grid-cols-2 gap-10 mt-4">
  <div class="wi-mermaid">

```mermaid {scale: 0.95, theme: 'base', themeVariables: { 'background': 'transparent', 'primaryColor': '#1f1d3a', 'primaryTextColor': '#e9e7ff', 'primaryBorderColor': '#7e6bff', 'lineColor': '#9b8cff', 'fontFamily': 'Inter, ui-sans-serif, system-ui', 'fontSize': '15px' } }
flowchart TB
  l1["<b>Level 1 · always loaded</b><br/>name + description<br/>(~tens of tokens)"]
  l2["<b>Level 2 · on trigger</b><br/>the SKILL.md body"]
  l3["<b>Level 3 · on demand</b><br/>scripts · references · templates"]
  l1 -->|"task looks relevant"| l2 -->|"step needs it"| l3
```

  </div>
  <div>
    <ul class="!mt-2 !text-[1.4rem] !leading-relaxed space-y-4">
      <li v-click>The agent reads every skill's <span class="hl">name + description</span> cheaply, on <em>every</em> prompt.</li>
      <li v-click>Only the <span class="hl">relevant</span> skill's body loads into context.</li>
      <li v-click>Bundled files load <span class="hl">only when a step needs them.</span></li>
      <li v-click class="!font-semibold"><span class="hl-soft">Result:</span> install 50 skills, pay for the one you're using.</li>
    </ul>
  </div>
</div>

<!--
~60s. This is the unlock. Three levels. The description is the trigger, it's the most
important line you write (we come back to this in design principles). Contrast with
stuffing everything into CLAUDE.md, which is always-on and bloats every request.
-->

---

# Anatomy of a *complex* skill

<div class="grid grid-cols-2 gap-10 mt-4">
  <div class="big-code">

```text
incident-triage/
├── SKILL.md            # the procedure, concise
├── references/
│   ├── severity-matrix.md
│   └── escalation.md
├── scripts/
│   └── gather-diagnostics.sh
└── templates/
    └── postmortem.md
```

  </div>
  <div>
    <ul class="!mt-2 !text-[1.4rem] !leading-relaxed space-y-4">
      <li><span class="hl">SKILL.md</span> stays short. It's what loads on trigger.</li>
      <li><span class="hl">references/</span> hold the long detail, read only when needed.</li>
      <li><span class="hl">scripts/</span> do the deterministic steps, so the model never re-derives a fragile command.</li>
      <li><span class="hl">templates/</span> are the artifacts it fills in (a postmortem, a PR body).</li>
    </ul>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">Prose for judgement · scripts for procedure</div>
  <p>If a step is "run these exact commands," ship a script and tell the agent to run it.</p>
</aside>

<!--
~60s. The "makeup of a skill." The body points at the bundled files: "to classify
severity, read references/severity-matrix.md." Lazy-loaded. The scripts vs prose line
is the one to land, deterministic steps belong in scripts.
-->

---

# Skill ≠ MCP ≠ CLAUDE.md

<div class="grid grid-cols-3 gap-6 mt-6">
  <div class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Agent Skill</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Knowledge + procedure.</strong> "Here's how we do X." Loaded on demand. Portable folder of Markdown + scripts.</p>
  </div>
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">MCP server</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Tools + live data.</strong> "Here's an API I can call." A running server the agent connects to.</p>
  </div>
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">CLAUDE.md / AGENTS.md</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Always-on context.</strong> Project rules loaded into <em>every</em> request. No triggering, no scoping.</p>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">They compose</div>
  <p>A skill tells the agent <strong>how</strong> to use the Pulumi <strong>MCP</strong> server. Your <strong>CLAUDE.md</strong> can point at the skills your repo expects. Best results use all three.</p>
</aside>

<!--
~60s. Clear up the confusion before it derails the room. Skill = how-to (on demand).
MCP = tools/live data (a server). CLAUDE.md = always-on rules. They're complementary;
the Pulumi skills literally teach the agent how to drive the Pulumi MCP server.
-->

---

<div class="absolute inset-0 flex flex-col items-center justify-center px-20 text-center">
  <h1 class="!text-[6rem] !font-semibold !tracking-tight !leading-tight !m-0 !text-[var(--p-primary)] flex items-center gap-6">
    Why DevOps
    <span>=</span>
    <span class="!text-[7rem]">❤️</span>
    skills
  </h1>
</div>

<!--
Pivot to the DevOps angle. The job is repeatable judgement, the exact shape of a skill.
This is where the room leans in: their runbooks, encoded.
-->

---

# The job is already skill-shaped

<div class="zoom-content">

<p v-click class="!mt-8 !text-[1.4rem] !leading-relaxed">
  <span class="hl">"If you find yourself doing the same type of task with different content
  each time, that's a skill waiting to be built."</span>
</p>

<p v-click class="!mt-6 !text-[1.4rem] !leading-relaxed">
  Pipeline triage. Terraform drift. <code>CrashLoopBackOff</code>. Cost spikes. The Sev1
  at 2am. That's <span class="hl-soft">repeatable judgement</span>. Not novel code.
</p>

<p v-click class="!mt-6 !text-[1.4rem] !leading-relaxed">
  Pulumi's own number: <span class="hl">LLMs now run over 20% of infrastructure
  deployments</span>, heading past 50% this year. The agent is already in your infra.
  The only question is whether it follows <span class="hl-soft">your</span> playbook.
</p>

</div>

<!--
~50s. The Pulumi quote is the thesis. Then the list, every one is a runbook that exists
in someone's head or a stale wiki. The Joe Duffy stat (May '26 release; a vendor forecast,
attribute it if challenged) lands the urgency:
the agent is already deploying infra; skills decide whether it does it your way.
-->

---

# Turn the wiki nobody reads into something the agent runs

<div class="grid grid-cols-2 gap-10 mt-6">
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Today</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>Runbook in a wiki, last edited 18 months ago</li>
      <li>Senior engineer re-explains it on every incident</li>
      <li>Agent guesses, reaches for the wrong command</li>
      <li>You re-paste your conventions into every prompt</li>
    </ul>
  </div>
  <div class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">With skills</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>Runbook is a <code>SKILL.md</code> in git, reviewed like code</li>
      <li>Encoded <strong>once</strong>, so every engineer's agent runs it the same way</li>
      <li>Safe by default: read-only, preview before apply</li>
      <li>Triggers itself when the task matches</li>
    </ul>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">The stack in 2026</div>
  <p><strong>Skills</strong> = the know-how · <strong>MCP servers</strong> = governed access to real systems (Pulumi, Terraform, Vault, Datadog) · <strong>the agent</strong> = orchestration. We use all three today.</p>
</aside>

<!--
~60s. Left/right before-after. The payoff line: senior-engineer judgement encoded once,
distributed to every engineer's agent. Land the "skills + MCP + agent" division of labor,
it frames the whole rest of the workshop.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6rem] !leading-tight !font-semibold !tracking-tight !m-0 text-[var(--p-primary)] !max-w-[95%]">Find &amp; evaluate skills</h1>
</div>

<!--
Section divider. Don't write what you can adopt. Then: where to look, and how to vet a
skill that's going to touch your infrastructure. (APM + Pulumi catalogue slides follow.)
-->


---

# Don't write what you can adopt

<div class="grid grid-cols-2 gap-10 mt-4">
  <div>
    <ul class="!mt-2 !text-[1.35rem] !leading-relaxed space-y-3">
      <li><strong>Vendor sets:</strong> Pulumi ships <code>pulumi/agent-skills</code> (Apache-2.0, 4 plugin groups); cloud providers ship theirs</li>
      <li>The open hub, <code>agentskills.io</code>, and Anthropic's <code>anthropics/skills</code></li>
      <li>Community runbooks like <code>bregman-arie/devops-sre-skills</code> and <code>dirien/claude-skills</code></li>
      <li>And your own org repo, full of skills your teammates already wrote</li>
    </ul>
  </div>
  <div class="big-code">

```bash
# The fastest skill is the one
# someone else already ran in prod.

npx skills find terraform   # search
npx skills find kubernetes
```

  </div>
</div>

<!--
~60s. Start by NOT writing. Point at the four sources. The fastest skill is one that's
already debugged in someone else's prod. Aside if asked: there is NO get.pulumi.com/skills.sh
(it 403s); the real install is the npx skills CLI / the Claude Code marketplace, and APM on top.
-->

---

# Evaluate before you trust

<div class="zoom-content">

<p class="!mt-6 !text-[1.3rem] !leading-relaxed">A skill <span class="hl">acts on your infrastructure.</span> Vet it like a GitHub Action you hand cloud creds to.</p>

<div class="grid grid-cols-2 gap-x-12 gap-y-3 !mt-4">
  <p class="!text-[1.2rem] flex items-baseline gap-3"><ph-identification-card class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 self-center" /><span><strong>Who publishes it?</strong> Unknown author = unknown blast radius.</span></p>
  <p class="!text-[1.2rem] flex items-baseline gap-3"><ph-gear class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 self-center" /><span><strong>What can it run?</strong> Read the scripts.</span></p>
  <p class="!text-[1.2rem] flex items-baseline gap-3"><ph-target class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 self-center" /><span><strong>Is the description honest?</strong> It's the trigger.</span></p>
  <p class="!text-[1.2rem] flex items-baseline gap-3"><ph-shield-check class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 self-center" /><span><strong>Safe by default?</strong> Preview before mutate.</span></p>
  <p class="!text-[1.2rem] flex items-baseline gap-3"><ph-wrench class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 self-center" /><span><strong>Maintained?</strong> Commits, versions, changelog.</span></p>
  <p class="!text-[1.2rem] flex items-baseline gap-3"><ph-puzzle-piece class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 self-center" /><span><strong>Fits your stack?</strong> Pulumi ≠ Terraform.</span></p>
</div>

</div>

<aside class="info-card">
  <div class="info-card__label">Rule of thumb</div>
  <p>Read the whole <code>SKILL.md</code> and every script it bundles before you enable it. <strong>If you wouldn't merge it as a PR, don't install it as a skill.</strong></p>
</aside>

<!--
~60s. Six questions. The one that matters most for DevOps: "what can it run", a
write-capable skill is a supply-chain surface. The rule of thumb is the takeaway line.
-->

---

<div class="absolute inset-0 flex flex-col items-center justify-center px-20 text-center">
  <h1 class="!text-[10rem] !leading-none !font-bold !tracking-[0.08em] !m-0 !text-[var(--p-fg)]">DEMO</h1>
</div>

<!--
Live demo, discover & evaluate. `npx skills find`, browse pulumi/agent-skills on GitHub,
open a SKILL.md, read its description + a script, and decide adopt vs build. Keep it 2 min.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6rem] !leading-tight !font-semibold !tracking-tight !m-0 text-[var(--p-primary)] !max-w-[95%]">Connect, configure &amp; use</h1>
</div>

<!--
Section divider. Install a skill, then watch the agent use it inside a real task. This is
where APM enters, the manifest that makes installs reproducible for the whole team.
-->

---

# Connecting a skill: two ways

<div class="grid grid-cols-2 gap-8 mt-4">
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Universal CLI (agentskills.io)</div>

```bash
# Works for Claude Code, Cursor,
# Copilot, Codex, Gemini, …
npx skills add pulumi/agent-skills \
  --skill '*'
```

  <p class="!mt-3 !text-[1.1rem] !leading-relaxed">Lands in <code>.agents/skills/</code>, pinned in <code>skills-lock.json</code>.</p>
  </div>
  <div class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Claude Code marketplace</div>

```bash
/plugin marketplace add \
  pulumi/agent-skills
/plugin install pulumi
```

  <p class="!mt-3 !text-[1.1rem] !leading-relaxed">Lands in your Claude plugins, grouped by plugin.</p>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">Both are per-machine</div>
  <p>Great for you. But what does your <strong>teammate</strong> get when they clone the repo? Nothing. Unless there's a manifest.</p>
</aside>

<style scoped>
:deep(.slidev-code) { font-size: 1.05rem !important; margin: 0.3rem 0 0 !important; }
</style>

<!--
~60s. Two real install paths. Both work, both are per-machine. The info-card sets up the
gap APM fills: there's no shared manifest, so nothing is reproducible across the team.
-->

---

# APM: package.json for your agent

<div class="zoom-content">

<p v-click class="!mt-6 !text-[1.35rem] !leading-relaxed">
  The course uses <code>npx skills</code>. Perfect for one laptop. <span class="hl">Microsoft APM</span>
  takes the next step: a <span class="hl-soft">manifest</span> your whole team shares.
</p>

<p v-click class="!mt-5 !text-[1.35rem] !leading-relaxed">
  Declare skills, MCP servers, and LSP servers in <code>apm.yml</code>; drop hooks and your own
  skills under <code>.apm/</code>. Run <span class="hl-soft">apm install</span>. Every teammate's agent
  (Claude, Copilot, Cursor, Codex, Gemini) gets the <span class="hl">same setup</span>.
</p>

<p v-click class="!mt-5 !text-[1.35rem] !leading-relaxed">
  <span class="hl">Reproducible</span> by design. And because these skills run code, <code>apm</code>
  scans every install for <span class="hl-soft">hidden-Unicode attacks</span> and pins their hashes.
  Policy can gate what's allowed across the org.
</p>

</div>

<!--
~60s. The thesis of the "build on APM" choice. npx skills = imperative, per-machine. APM =
declarative, reproducible, multi-harness, like going from "curl | sh" to a lockfile.
The security angle (hidden-Unicode scan, pinned hashes) matters for skills that run code.
-->

---

# One manifest → every agent

```yaml
# apm.yml: committed to the repo, the same for everyone
name: getting-started-with-devops-ai-skills
targets: [claude]            # also: copilot, cursor, codex, gemini, …
dependencies:
  apm:
    - pulumi/agent-skills/pulumi          # Pulumi's core skill set (7 skills)
    - pulumi/agent-skills/delegation      # pulumi-neo-handoff
    # a community runbook (path resolves to a SKILL.md):
    - bregman-arie/devops-sre-skills/skills/kubernetes/diagnose-crashloop
  mcp:
    - name: pulumi
      registry: false                     # self-defined server (use the command below)
      transport: stdio
      command: npx
      args: ["-y", "@pulumi/mcp-server@latest", "stdio"]
  # lsp: language servers (next slide) · hooks live in .apm/hooks/
```

<div class="grid grid-cols-3 gap-5 mt-5">
  <div class="gpu-card gpu-card--muted"><div class="gpu-caption gpu-caption--muted">apm install</div><p class="!mt-2 !text-[1.05rem]">Resolve + scan, then integrate it all into <code>.claude/</code>: skills, hooks, LSP, MCP.</p></div>
  <div class="gpu-card gpu-card--muted"><div class="gpu-caption gpu-caption--muted">commit apm.lock.yaml</div><p class="!mt-2 !text-[1.05rem]">Pins exact versions and content hashes, the same for everyone.</p></div>
  <div class="gpu-card gpu-card--muted"><div class="gpu-caption gpu-caption--muted">git clone &amp;&amp; apm install</div><p class="!mt-2 !text-[1.05rem]">A new teammate is fully configured in one command.</p></div>
</div>

<style scoped>
:deep(.slidev-code) { font-size: 1.05rem !important; line-height: 1.5 !important; max-width: 96%; margin: 0.3rem 0 0; padding: 0.9rem 1.3rem; border-radius: 12px; }
</style>

<!--
~75s. This is OUR apm.yml. Walk the deps: Pulumi skills, community runbooks, the Pulumi MCP
server (and LSP servers, next slides). The key command is `apm install`: it does everything,
integrating skills, hooks, LSP, and MCP into .claude/ and writing apm.lock.yaml. Commit the
lockfile; a teammate just clones and runs apm install. (`apm compile` is a separate thing:
it turns .apm/ instructions into AGENTS.md/CLAUDE.md, which this workshop doesn't use.)
-->

---

# Skills, MCP, Neo: three layers

<div class="grid grid-cols-3 gap-6 mt-8">
  <div class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Agent Skills</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Static know-how</strong> in your agent. "How an expert uses Pulumi." Loaded on demand. Free until used.</p>
  </div>
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Pulumi MCP server</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Live tools.</strong> Query the registry, validate code, reach Pulumi Cloud. Governed access, so the agent never holds creds.</p>
  </div>
  <div class="gpu-card gpu-card--accent">
    <div class="gpu-caption gpu-caption--accent">Pulumi Neo</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Autonomous agent</strong> with RBAC + human-in-the-loop. Hand off with the <code>pulumi-neo-handoff</code> skill.</p>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">They compose</div>
  <p>A <strong>skill</strong> teaches the agent how to drive the <strong>MCP</strong> server; when the job gets big, the <code>pulumi-neo-handoff</code> skill packages it into a <strong>Neo</strong> task. Static → live → autonomous.</p>
</aside>

<!--
~60s. The Pulumi-specific stack. Skills = knowledge, MCP = governed live access, Neo =
autonomous execution with governance. The handoff skill is the bridge. Don't oversell Neo,
demo it live rather than claim "autonomous incident resolution" from a slide.
-->

---

# Quality depends on how you configure it

<div class="zoom-content">

<p v-click class="!mt-8 !text-[1.4rem] !leading-relaxed">
  That stack is only as good as its <span class="hl-soft">configuration.</span> A coding agent can
  write Pulumi for you, but <span class="hl">how well depends almost entirely on how you've set it up.</span>
</p>

<p v-click class="!mt-6 !text-[1.4rem] !leading-relaxed">
  Skills and the MCP server are two levers. Two more keep it from
  <span class="hl-soft">drifting off your patterns:</span>
</p>

<p v-click class="!mt-6 !text-[1.4rem] !leading-relaxed">
  <span class="hl">LSP</span> lets it <span class="hl-soft">see real types</span> as it writes.
  <span class="hl">Hooks</span> and <span class="hl">permissions</span> are <span class="hl-soft">local guardrails</span>
  on the dangerous commands. <code>apm install</code> wires the hook; you add a permissions deny-list.
</p>

</div>

<!--
~45s. The teaser thesis, said plainly: the agent is only as good as its config. Skills +
MCP were levers one and two. Now the two that guard against drift: LSP (it sees real types)
and hooks/permissions (local guardrails). Both are wired by the same `apm install`: LSP from
apm.yml (dependencies.lsp), hooks file-discovered from .apm/hooks/. Be honest that hooks are
a nudge, not a wall; real enforcement is server-side (Pulumi Cloud policy), covered next.
-->

---

# LSP: let the agent see real types

<div class="grid grid-cols-2 gap-10 mt-4">
  <div class="big-code">

```yaml
# apm.yml: a language server per Pulumi language
dependencies:
  lsp:
    - name: typescript-language-server
      command: typescript-language-server
      args: ["--stdio"]
      extensionToLanguage: { ".ts": typescript }
    - name: pyright                       # Python
      command: pyright-langserver
      args: ["--stdio"]
      extensionToLanguage: { ".py": python }
    - name: gopls                         # Go
      command: gopls
      args: ["serve"]
      extensionToLanguage: { ".go": go }
```

  </div>
  <div>
    <ul class="!mt-2 !text-[1.3rem] !leading-relaxed space-y-3">
      <li>The agent sees <span class="hl">real types and live diagnostics</span> as it writes</li>
      <li>So it uses the <span class="hl-soft">real cloud-SDK API</span> (the actual args on <code>aws.s3.Bucket</code>) instead of guessing</li>
      <li><code>apm install</code> writes <code>.lsp.json</code>, not the binaries. You put <code>gopls</code> / <code>pyright</code> / <code>typescript-language-server</code> on <code>$PATH</code> yourself</li>
      <li class="!font-semibold">Mistakes get caught as the code is typed, not at <code>pulumi up</code></li>
    </ul>
  </div>
</div>

<style scoped>
:deep(.slidev-code) { font-size: 1.0rem !important; line-height: 1.45 !important; }
</style>

<!--
~75s. The "see real types" win. Without LSP the agent guesses cloud-SDK signatures and
hallucinates. With it, it gets the same red squiggles you do. APM only writes the config
(.lsp.json); you still install the server binaries yourself. Tracked in apm.lock.yaml.
-->

---

# Hooks: a fast local guardrail (not a wall)

<div class="grid grid-cols-2 gap-10 mt-4">
  <div class="big-code">

<div class="gpu-caption gpu-caption--muted !mb-1">.apm/hooks/block-pulumi-mutations.json</div>

```json
{ "PreToolUse": [{
  "matcher": "Bash",
  "hooks": [{
    "type": "command",
    "command": "${CLAUDE_PLUGIN_ROOT}/scripts/guard-pulumi.sh",
    "timeout": 10
  }]
}]}
```

```bash
# guard-pulumi.sh blocks (exit 2) pulumi up/update/
# destroy, flags and all; fails CLOSED if it can't parse.
```

  </div>
  <div>
    <ul class="!mt-2 !text-[1.3rem] !leading-relaxed space-y-3">
      <li>A <code>PreToolUse</code> hook on the <span class="hl">Bash</span> tool sees the command first; exit <code>2</code> blocks it and hands the reason back</li>
      <li><code>apm install</code> merges it into <code>.claude/settings.json</code>. Pair it with a <code>permissions</code> deny-list, the "settings" lever</li>
      <li class="!font-semibold">It's a <span class="hl">nudge, not a wall.</span> The agent can still deploy via the Automation API, the MCP server, or a <code>make</code> wrapper, none of which touch Bash</li>
    </ul>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">So where's the real wall?</div>
  <p>Server-side: <strong>Pulumi Cloud deployment policies + OIDC-scoped, short-lived creds.</strong> The hook catches the obvious local mistake fast; the Cloud policy is what actually stops a bad apply.</p>
</aside>

<style scoped>
:deep(.slidev-code) { font-size: 1.0rem !important; line-height: 1.45 !important; }
</style>

<!--
~75s. Be honest here or a sharp attendee will catch you. The hook is real and useful: it
catches `pulumi up`/`destroy` on the Bash tool (flags and all) and fails closed. But it's a
NUDGE: the agent can deploy through the Automation API skill or the MCP server (no Bash),
wrap it in `make deploy`, or edit settings.json with the Write tool. Say that out loud, then
point at the real enforcement: Pulumi Cloud deployment policy + OIDC creds, server-side.
-->

---

# Show the delta: same prompt, off vs on

<div class="grid grid-cols-2 gap-8 mt-3">
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Naked agent</div>

```ts
// "make an S3 bucket for our data"
new aws.s3.BucketV2("data", {
  publicReadAccess: true,  // ❌ invented arg
});
// then runs `pulumi up`, no preview
```

  <p class="!mt-2 !text-[1.05rem] text-[var(--p-fg-muted)]">Hallucinated API, no tags, deploys unprompted.</p>
  </div>
  <div class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Configured agent</div>

```ts
// same prompt; skills + LSP + hooks on
new aws.s3.BucketV2("data", {
  tags: { team: "platform", env: "dev" },
});
// `pulumi preview` ✅ (hook held `up`)
```

  <p class="!mt-2 !text-[1.05rem] text-[var(--p-fg-muted)]">LSP killed the bad arg; skill added tags; it stopped at preview.</p>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">This is the proof, not a promise</div>
  <p>Same prompt, two configs. That delta <em>is</em> the thesis. Run it live: <code>demo/pulumi-ts</code> ships the red squiggle on <code>publicReadAccess</code> ready to show.</p>
</aside>

<style scoped>
:deep(.slidev-code) { font-size: 0.95rem !important; line-height: 1.4 !important; }
</style>

<!--
~90s. THE money shot (PRESENTER.md protects this demo above all). Don't just assert config
helps; show it. Naked: invents `publicReadAccess`, skips preview. Configured: LSP flags the
arg in-editor, the golden-path skill adds standard tags, the hook stops `pulumi up`. If you
only get one demo through, it's this one.
-->

---

# Use it: the agent triggers the skill itself

<div class="grid grid-cols-2 gap-8 mt-4">
  <div>
    <p class="!text-[1.3rem] !leading-relaxed !mb-3">You type a normal request:</p>
    <div class="pr-card"><div class="pr-card__body">"Start a new <strong>payments</strong> service, AWS, TypeScript."</div></div>
    <ul class="!mt-5 !text-[1.2rem] !leading-relaxed space-y-2">
      <li v-click>Agent matches it to <code>golden-path-service</code> from its <span class="hl">description</span></li>
      <li v-click>Loads the body, follows the steps, runs the bundled script</li>
      <li v-click><span class="hl-soft">previews</span>, waits for your OK, and never runs <code>pulumi up</code> unprompted</li>
    </ul>
  </div>
  <div class="big-code">

```text
🛠  golden-path-service triggered
→ pulumi new aws-typescript …
→ wired config to ESC (OIDC, no keys)
→ applied standard tags
→ pulumi preview  ✅  (awaiting approval)
```

  </div>
</div>

<style scoped>
.pr-card { max-width: 100%; margin: 0; border: 1px solid rgba(126,107,255,0.4); border-radius: 12px; background: rgba(126,107,255,0.06); }
.pr-card__body { padding: 0.9rem 1.2rem; font-size: 1.3rem; }
:deep(.slidev-code) { font-size: 1.1rem !important; }
</style>

<!--
~60s. The magic moment: you didn't say "use the skill." The agent matched your plain
request to the skill's description and ran it, with the safety defaults baked in
(preview, no unprompted up). That's the whole value: your playbook, automatically.
-->

---

<div class="absolute inset-0 flex flex-col items-center justify-center px-20 text-center">
  <h1 class="!text-[10rem] !leading-none !font-bold !tracking-[0.08em] !m-0 !text-[var(--p-fg)]">DEMO</h1>
</div>

<!--
Live demo, apm install + compile, then drive golden-path-service inside Claude Code:
"start a new service" → the skill triggers → preview. Show .claude/skills/ got populated.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6rem] !leading-tight !font-semibold !tracking-tight !m-0 text-[var(--p-primary)] !max-w-[95%]">Build your own</h1>
</div>

<!--
Section divider. Now author. Simple first (one file), then complex (scripts + references).
The whole point: your runbooks become skills.
-->

---

# From scratch: one file, two required fields

```markdown
---
name: golden-path-service          # lowercase-hyphens, matches the folder
description: >-                      # THE TRIGGER: what it does AND when
  Scaffold a new service on our golden path: Pulumi + ESC + OIDC,
  preview-before-apply. Use when someone asks to start a new stack,
  service, or IaC project.
---

# Golden path: new service
1. Ask for cloud (aws|gcp|azure) and language (ts|python|go).
2. pulumi new <cloud>-<language> …
3. Wire config to ESC, not local secret files.
4. Always `pulumi preview` before suggesting `pulumi up`.
```

<aside class="info-card">
  <div class="info-card__label">That's a complete skill</div>
  <p>Drop it at <code>.apm/skills/golden-path-service/SKILL.md</code>, run <code>apm install</code>, and the agent can use it. The <code>description</code> is the only line you must get right.</p>
</aside>

<style scoped>
:deep(.slidev-code) { font-size: 1.1rem !important; line-height: 1.5 !important; max-width: 94%; margin: 0.2rem 0 0; padding: 0.9rem 1.3rem; border-radius: 12px; }
</style>

<!--
~75s. Author a real skill live-ish. The frontmatter is the contract; name matches the
folder, description is the trigger. Body is just numbered steps with safety baked in.
This is the simple/instructions-only skill, the course's recursive-code-review analog.
-->

---

# Complex: make it safe and deterministic

<div class="grid grid-cols-2 gap-10 mt-4">
  <div class="big-code">

```yaml
# incident-triage/SKILL.md frontmatter
name: incident-triage
description: >-
  Triage a prod incident on K8s. Use for
  an outage, CrashLoopBackOff, or a pod
  that won't schedule.
metadata:
  default-mode: read-only      # ← a hint for humans, not enforced
```

```bash
# the exact commands live in a script the agent runs
scripts/gather-diagnostics.sh <ns> <workload>
# pods · events · restarts · logs · rollout
```

  </div>
  <div>
    <ul class="!mt-2 !text-[1.3rem] !leading-relaxed space-y-3">
      <li><span class="hl">references/</span> hold the heavy detail (severity matrix, escalation), read only when the task needs them</li>
      <li><span class="hl">scripts/</span> do the deterministic part. <code>gather-diagnostics.sh</code> gathers evidence and <span class="hl-soft">mutates nothing</span></li>
      <li><span class="hl">templates/</span> are what it fills in: a postmortem, ready to paste</li>
      <li class="!font-semibold"><span class="hl">read-only</span> by default. It proposes a fix; a human approves.</li>
    </ul>
  </div>
</div>

<!--
~75s. Builds on the anatomy slide, now the FOCUS is safety + determinism. Land two things:
the read-only frontmatter guardrail, and "the deterministic step is a script, not prose." Same
pattern as Anthropic's skill-creator and the community devops-sre-skills runbooks.
-->


---

# Six principles that make a skill reliable

<div class="grid grid-cols-2 gap-x-12 gap-y-3 mt-6 zoom-90">
  <p class="!text-[1.25rem]"><strong>1. The description is the trigger.</strong> Say what it does <em>and</em> when. Third person, specific.</p>
  <p class="!text-[1.25rem]"><strong>2. One skill, one job.</strong> Sharp scope beats a mega-skill that competes with itself.</p>
  <p class="!text-[1.25rem]"><strong>3. Keep <code>SKILL.md</code> short.</strong> Under ~500 lines; push detail into <code>references/</code>.</p>
  <p class="!text-[1.25rem]"><strong>4. Scripts for procedure.</strong> If a step is exact commands, ship the script and have the agent run it.</p>
  <p class="!text-[1.25rem]"><strong>5. Name it like your team talks.</strong> Match the words people actually use.</p>
  <p class="!text-[1.25rem]"><strong>6. Safe by default.</strong> Read-only, preview, confirm before mutating. No static creds.</p>
</div>

<aside class="info-card">
  <div class="info-card__label">If you remember one thing</div>
  <p>The <code>description</code> is the most important line you write. It's how the agent decides to load the skill at all.</p>
</aside>

<style scoped>
.zoom-90 { zoom: 1.0; }
</style>

<!--
~75s. The design-principles lesson. Don't read all six, land #1 (description = trigger)
and #6 (safe by default), the two that matter most for DevOps. The rest are on the slide.
-->

---

<div class="absolute inset-0 flex flex-col items-center justify-center px-20 text-center">
  <h1 class="!text-[10rem] !leading-none !font-bold !tracking-[0.08em] !m-0 !text-[var(--p-fg)]">DEMO</h1>
</div>

<!--
Live demo, author golden-path-service from scratch, apm install, run it. Then show
incident-triage's tree and run gather-diagnostics.sh against a broken pod. Read-only proof.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6rem] !leading-tight !font-semibold !tracking-tight !m-0 text-[var(--p-primary)] !max-w-[95%]">Operate them</h1>
</div>

<!--
Section divider. Skills are software, version, update, remove. Two short lessons.
-->

---

# Keep them current · remove them clean

<div class="grid grid-cols-2 gap-10 mt-4">
  <div class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Keep up to date</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>Skills live in <strong>git</strong> next to the runbook; change both in one PR</li>
      <li><strong>Review like code</strong>; pin deps and bump deliberately (<code>apm update</code>)</li>
      <li>Re-test on model/agent upgrades, and keep a smoke prompt per critical skill</li>
      <li class="!font-semibold">Stale skill &gt; stale doc: the agent <em>acts</em> on it</li>
    </ul>
  </div>
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Remove cleanly</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>Every skill costs context and a chance to mis-trigger, so prune the unused</li>
      <li><code>apm uninstall &lt;pkg&gt;</code>, or delete <code>.apm/skills/&lt;name&gt;/</code> and recompile</li>
      <li>Drop the manifest entry so it doesn't come back on the next sync</li>
      <li>Unsure? <strong>Disable</strong> beats delete (<code>skillOverrides</code>)</li>
    </ul>
  </div>
</div>

<!--
~75s. Two lessons in one. Left: maintenance, the killer line is "stale skill is worse than
a stale doc because the agent acts on it." Right: removal, prune for context + mis-trigger
hygiene; disable when unsure. The course's 01_09e branch literally ends empty.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[5.4rem] !leading-tight !font-semibold !tracking-tight !m-0 text-[var(--p-primary)] !max-w-[95%]">Turn your workflows into skills</h1>
</div>

<!--
The close-the-loop section. The habit: do it twice, capture it the third time. Their
runbooks, running themselves.
-->

---

# The habit: do it twice, capture it

<div class="grid grid-cols-2 gap-10 mt-2">
  <div class="wi-mermaid">

```mermaid {scale: 0.95, theme: 'base', themeVariables: { 'background': 'transparent', 'primaryColor': '#1f1d3a', 'primaryTextColor': '#e9e7ff', 'primaryBorderColor': '#7e6bff', 'lineColor': '#9b8cff', 'fontFamily': 'Inter, ui-sans-serif, system-ui', 'fontSize': '15px' } }
flowchart TB
  a["Do a task<br/>(twice)"] --> b["Write the<br/>steps down"]
  b --> c["Wrap as SKILL.md<br/>+ a script"]
  c --> d["Agent runs it<br/>every time after"]
  d --> e["Refine when<br/>it misfires"] --> c
```

  </div>
  <div>
    <p class="!text-[1.25rem] !leading-relaxed !mb-3 text-[var(--p-fg-muted)]">Five everyday workflows worth capturing:</p>
    <ul class="!text-[1.2rem] !leading-relaxed space-y-2">
      <li>"Start a new service" → <span class="chip">golden-path-service</span></li>
      <li>"We leaked a key" → <span class="chip">esc-secret-rotation</span></li>
      <li>"Preview env for this PR" → ephemeral stack up/down</li>
      <li>"Pod won't start" → <span class="chip">incident-triage</span></li>
      <li>"Is prod tagged right?" → tag/region audit</li>
    </ul>
  </div>
</div>

<!--
~60s. The takeaway habit. The loop diagram, then five concrete DevOps workflows, three
of which are the skills we built today. The message: this isn't exotic; it's your Tuesday,
written down once.
-->

---

# Honest about scope

<div class="grid grid-cols-2 gap-10 mt-4">
  <div class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Pulumi-specific today</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>The Pulumi skills, the MCP server, ESC, Neo, the <code>pulumi up</code> hook</li>
      <li>Most of today's 14 skills assume Pulumi</li>
    </ul>
  </div>
  <div class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Ports anywhere</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>The <span class="hl">method</span>: skills + LSP + hooks via APM, on the open <code>agentskills.io</code> standard</li>
      <li>Swap in Terraform / Helm / ArgoCD skills; the community runbooks are your starting point</li>
    </ul>
  </div>
</div>

<aside class="info-card">
  <div class="info-card__label">Two things I'll say out loud</div>
  <p><strong>opencode</strong> is in the abstract; today's build is Claude Code (APM writes LSP for Claude + Copilot CLI only), and the method is identical for opencode. The "20%+ of deployments" figure is Pulumi's own (Joe Duffy, '26), a forecast, not an independent benchmark.</p>
</aside>

<!--
~45s. Pre-empt the two heckles: "this is a Pulumi ad" and "where's opencode / your stat."
Own it. The Pulumi-specific stuff is the example; the method (skills+LSP+hooks via APM on
an open standard) is the takeaway, and it ports to Terraform/Helm/ArgoCD. opencode: same
method, Claude Code today. The stat: vendor forecast, attribute it.
-->

---

# What you've got now

<div class="zoom-content">

<ul class="!mt-6 !text-[1.45rem] !leading-relaxed space-y-4">
  <li>A skill is a <span class="hl">folder + SKILL.md</span>; the description is the trigger; progressive disclosure keeps it cheap</li>
  <li><span class="hl">Adopt before you build</span>, and read the scripts before you trust them</li>
  <li><span class="hl">APM</span> makes installs reproducible for the whole team; <span class="hl">Pulumi skills + MCP + Neo</span> handle the actual Pulumi work</li>
  <li>Your <span class="hl">runbooks</span> are skills waiting to be built. Capture the next one you do twice.</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.25; }
</style>

<!--
~45s. Four takeaways = the spine of the workshop. End on the call to action: the next
runbook you do twice, make it a skill. Everything's in the repo.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20">
  <div class="opacity-80 tracking-[0.6em] uppercase !text-[1.6rem] !mb-4 text-[var(--p-fg-muted)]">Thank you</div>
  <h1 class="!text-[4.5rem] !leading-[1.02] !font-semibold !tracking-tight !mb-16 text-center">
    Go make your agent <span class="!text-[var(--p-primary)]">yours.</span>
  </h1>

  <div class="flex gap-16 justify-center items-start">
    <div class="text-center">
      <img src="/img/engin-diri.jpg" class="w-32 h-32 rounded-full mx-auto mb-4 border-4 object-cover" style="border-color: rgba(126,107,255,0.35)" alt="Engin Diri" />
      <div class="!text-[1.7rem] !font-bold">Engin Diri</div>
      <div class="opacity-60 !text-[1.2rem]">Pulumi</div>
      <div class="flex items-center justify-center gap-4 mt-2 !text-[1.1rem] opacity-60">
        <span class="flex items-center gap-1"><carbon-logo-github /> dirien</span>
        <span class="flex items-center gap-1"><carbon-logo-linkedin /> engin-diri</span>
      </div>
      <div class="mt-5 bg-white rounded-lg p-2 inline-block shadow-lg">
        <img src="/img/linkedin-qr.png" class="w-32 h-32" alt="LinkedIn QR" />
      </div>
    </div>
    <div class="text-center">
      <div class="w-32 h-32 rounded-full mx-auto mb-1 border-4 overflow-hidden flex items-center justify-center" style="border-color: rgba(126,107,255,0.35)">
        <carbon-logo-github class="!text-[6rem] leading-none" />
      </div>
      <div class="!text-[1.7rem] !font-bold">Workshop repo</div>
      <div class="opacity-60 !text-[1.2rem]">slides · chapters · skills</div>
      <div class="mt-2 !text-[1.1rem] opacity-0">&nbsp;</div>
      <div class="mt-5 bg-white rounded-lg p-2 inline-block shadow-lg">
        <img src="/img/repo-qr.png" class="w-32 h-32" alt="Workshop repo QR" />
      </div>
    </div>
    <div class="text-center">
      <div class="w-32 h-32 rounded-full mx-auto mb-4 border-4 bg-white flex items-center justify-center" style="border-color: rgba(126,107,255,0.35)">
        <img src="/logos/pulumi-logo-mark-color-light.svg" class="w-20 h-20" alt="Pulumi" />
      </div>
      <div class="!text-[1.7rem] !font-bold">Pulumi Skills</div>
      <div class="opacity-60 !text-[1.2rem]">pulumi.com/docs/ai</div>
      <div class="mt-2 !text-[1.1rem] opacity-0">&nbsp;</div>
      <div class="mt-5 bg-white rounded-lg p-2 inline-block shadow-lg">
        <img src="/img/pulumi-qr.png" class="w-32 h-32" alt="Pulumi website QR" />
      </div>
    </div>
  </div>
</div>

<!--
Thank you. Scan to connect on LinkedIn, grab the workshop repo (slides + chapters + the
skills we built), and the Pulumi AI/skills docs. Then go capture your next runbook.
NOTE: repo-qr.png still points at the old demo repo, regenerate it for this repo's URL.
-->
