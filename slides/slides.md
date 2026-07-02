---
theme: "@pulumi/slidev-theme"
title: "Getting Started with DevOps AI Skills"
info: |
  Getting Started with DevOps AI Skills.
  Engin Diri & Adam Gordon Bell, Pulumi.

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
    Engin Diri · Adam Gordon Bell · Pulumi
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

<div class="absolute inset-0 flex items-center px-24 gap-20">
  <div class="flex-shrink-0">
    <img src="/img/adam-gordon-bell.png" class="w-[28rem] rounded-2xl shadow-xl border-4" style="border-color: rgba(126,107,255,0.45)" alt="Adam Gordon Bell" />
  </div>
  <div class="flex-1">
    <h1 class="!text-[7rem] !leading-[1.02] !font-semibold !tracking-tight !mb-4 !text-[var(--p-primary)]">Adam Gordon Bell</h1>
    <p class="!text-[2.5rem] !leading-relaxed !m-0 opacity-90">
      Community Engineer at <strong class="!text-[var(--p-primary)]">Pulumi</strong>
    </p>
    <div class="!mt-8 flex items-center gap-8 !text-[1.5rem] opacity-70">
      <span class="flex items-center gap-2"><carbon-logo-x /> @adamgordonbell</span>
      <span class="flex items-center gap-2"><carbon-logo-linkedin /> adamgordonbell</span>
      <span class="flex items-center gap-2"><carbon-logo-github /> adamgordonbell</span>
    </div>
    <p class="!mt-10 !text-[1.75rem] !leading-relaxed opacity-70 !m-0">
      Host of the CoRecursive podcast.<br/>
      Telling the stories behind the code.
    </p>
  </div>
</div>

<!--
~20s. And I'm Adam — Community Engineer at Pulumi and host of the CoRecursive podcast,
telling the stories behind the code.
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
  <li>What an Agent Skill is, and why DevOps should use them</li>
  <li>Find &amp; evaluate existing skills</li>
  <li>Connect &amp; configure the agent: skills, MCP, LSP, hooks</li>
  <li>Same prompt, configured vs not</li>
  <li>Building complex skills safely</li>
  <li>Design principles, maintenance &amp; removal</li>
</ul>

</div>

<style scoped>
.zoom-content { zoom: 1.5; }
</style>

<!--
~30s. Six beats. Don't read the sub-text, say the beat and move on. The arc:
orient (what/why) → use what exists → configure → prove it → build safely → operate.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6.5rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)] !max-w-[95%]">What is an Agent Skill?</h1>
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

<div class="grid grid-cols-2 gap-8 mt-2 items-start">
  <div class="big-code">

```markdown
---
name: pulumi-stack-bootstrap
description: >-
  Scaffold a new Pulumi project on our org
  standard: ESC for config, OIDC for auth,
  preview-before-apply. Use when asked to
  start a new stack, service, or IaC project.
---

# Pulumi stack bootstrap

1. Ask cloud (aws|gcp|azure) + language (ts|py|go).
2. `pulumi new <cloud>-<language> --name <name>`
3. Wire config to ESC, not local secret files.
4. Always `pulumi preview` before `pulumi up`.
```

  </div>
  <div>
    <p v-click class="!text-[1.35rem] !leading-relaxed">
      YAML frontmatter (<code>name</code> + <code>description</code>) on top, plain-Markdown
      instructions below. That's the whole format.
    </p>
    <p v-click class="!mt-7 !text-[1.3rem] !leading-relaxed !mb-2">Drop that folder in one of a few places:</p>
    <ul v-click class="!text-[1.2rem] !leading-relaxed space-y-2">
      <li><code>.claude/skills/&lt;name&gt;/</code> this project (commit to share)</li>
      <li><code>~/.claude/skills/&lt;name&gt;/</code> you, across every project</li>
      <li><code>&lt;plugin&gt;/skills/&lt;name&gt;/</code> from a plugin, namespaced</li>
      <li>Enterprise: managed settings, org-wide</li>
    </ul>
  </div>
</div>

<div v-click class="prec-band">
  <span class="prec-label">Same name in two spots? Highest wins:</span>
  <span class="prec-chip"><ph-buildings class="text-[var(--p-primary)]" /> Enterprise</span>
  <ph-caret-right class="prec-arrow" />
  <span class="prec-chip"><ph-user class="text-[var(--p-primary)]" /> Personal</span>
  <ph-caret-right class="prec-arrow" />
  <span class="prec-chip"><ph-folder class="text-[var(--p-primary)]" /> Project</span>
</div>

<style scoped>
.big-code :deep(.slidev-code) {
  font-size: 0.92rem !important;
  line-height: 1.42 !important;
  margin: 0 !important;
  padding: 0.9rem 1.1rem;
  border-radius: 12px;
}
.prec-band {
  margin-top: 2.4rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}
.prec-label {
  font-size: 1.6rem;
  color: var(--p-fg-muted);
  margin-right: 0.4rem;
}
.prec-chip {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.75rem;
  font-weight: 600;
  color: var(--p-fg);
  background: rgba(126, 107, 255, 0.14);
  border: 1px solid rgba(126, 107, 255, 0.35);
  border-radius: 12px;
  padding: 0.45rem 1.05rem;
  white-space: nowrap;
}
.prec-arrow {
  font-size: 1.55rem;
  color: var(--p-fg-muted);
  flex-shrink: 0;
}
</style>

<!--
~70s. Show the format, then WHERE it lives. Frontmatter is the contract; the body is the
procedure. Four homes: project (.claude/skills, commit to share), personal (~/.claude/skills),
plugin (namespaced), and enterprise (managed, org-wide). When names collide, enterprise beats
personal beats project. In this workshop, `apm install` writes them into .claude/skills for you.
-->

---

# Progressive disclosure: why you can have dozens

<div class="pd-row">
  <div v-click class="pd-card">
    <div class="pd-tag"><ph-eye class="text-[var(--p-primary)]" /> Level 1 · always loaded</div>
    <p class="pd-what"><code>name</code> + <code>description</code></p>
    <p class="pd-cost">of <em>every</em> skill · ~100 tokens each</p>
  </div>

  <ph-caret-right v-click="2" class="pd-arrow" />

  <div v-click="2" class="pd-card pd-card--accent">
    <div class="pd-tag pd-tag--accent"><ph-file-text class="text-[var(--p-primary)]" /> Level 2 · on trigger</div>
    <p class="pd-what">the <code>SKILL.md</code> body</p>
    <p class="pd-cost">loads only when the task matches</p>
  </div>

  <ph-caret-right v-click="3" class="pd-arrow" />

  <div v-click="3" class="pd-card">
    <div class="pd-tag"><ph-folders class="text-[var(--p-primary)]" /> Level 3 · on demand</div>
    <p class="pd-what">scripts · references · templates</p>
    <p class="pd-cost">loads only when a step needs it</p>
  </div>
</div>

<p class="pd-takeaway" v-click>
  Install <span class="hl">dozens</span> of skills. Only the one the agent actually uses ever
  reaches the <span class="hl">context window</span>.
</p>

<style scoped>
.pd-row {
  display: flex;
  align-items: stretch;
  justify-content: center;
  gap: 1rem;
  margin-top: 3.2rem;
}
.pd-card {
  flex: 1;
  background: var(--p-bg-elevated);
  border: 1.5px solid var(--p-border);
  border-radius: 16px;
  padding: 1.8rem 1.6rem;
  display: flex;
  flex-direction: column;
  gap: 0.85rem;
}
.pd-card--accent {
  border-color: color-mix(in srgb, var(--p-primary) 60%, var(--p-border));
  background: rgba(126, 107, 255, 0.06);
}
.pd-tag {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-family: var(--slidev-font-mono);
  font-weight: 700;
  font-size: 1.15rem;
  text-transform: uppercase;
  letter-spacing: 0.03em;
  color: var(--p-fg-muted);
}
.pd-tag--accent { color: var(--p-primary); }
.pd-what {
  margin: 0;
  font-size: 1.75rem;
  font-weight: 600;
  color: var(--p-fg);
  line-height: 1.2;
}
.pd-cost { margin: 0; font-size: 1.2rem; color: var(--p-fg-muted); line-height: 1.35; }
.pd-arrow {
  font-size: 2.2rem;
  color: var(--p-fg-muted);
  align-self: center;
  flex-shrink: 0;
}
.pd-takeaway {
  margin: 3rem 0 0;
  max-width: 95%;
  text-align: left;
  font-size: 1.85rem;
  line-height: 1.45;
}
</style>

<!--
~60s. This is the unlock: three levels, cheap to expensive. Level 1 metadata is always in
the prompt (a handful of tokens per skill). Level 2 body loads only when the skill triggers.
Level 3 files load only when a step reaches for them. So dozens of skills cost almost nothing
in context until used. Contrast with CLAUDE.md, which is always-on and bloats every request.
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
      <li v-click><span class="hl">SKILL.md</span> stays short. It's what loads on trigger.</li>
      <li v-click><span class="hl">references/</span> hold the long detail, read only when needed.</li>
      <li v-click><span class="hl">scripts/</span> do the deterministic steps, so the model never re-derives a fragile command.</li>
      <li v-click><span class="hl">templates/</span> are the artifacts it fills in (a postmortem, a PR body).</li>
    </ul>
  </div>
</div>

<p v-click class="!mt-9 !text-[2rem] !leading-relaxed text-left !max-w-[95%]">
  <span class="hl">Match freedom to fragility:</span> judgement calls stay in prose; fragile,
  must-be-exact steps become a <span class="hl">script the agent just runs</span>. Anthropic
  calls this <em>degrees of freedom</em>.
</p>

<!--
~60s. The "makeup of a skill." Reveal each part on click. The body points at the bundled
files ("to classify severity, read references/severity-matrix.md"), lazy-loaded. Land the
last line, which is Anthropic's real "degrees of freedom" principle: match specificity to a
task's fragility. Open field (many paths) = prose/high freedom; narrow bridge (one safe way,
e.g. a db migration) = an exact script/low freedom. Scripts also keep it deterministic and
save tokens (the code never enters context).
-->

---

# Skill ≠ MCP ≠ CLAUDE.md

<div class="grid grid-cols-3 gap-6 mt-6">
  <div v-click class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Agent Skill</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Knowledge + procedure.</strong> "Here's how we do X." Loaded on demand. Portable folder of Markdown + scripts.</p>
  </div>
  <div v-click class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">MCP server</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Tools + live data.</strong> "Here's an API I can call." A running server the agent connects to.</p>
  </div>
  <div v-click class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">CLAUDE.md / AGENTS.md</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Always-on context.</strong> Project rules loaded into <em>every</em> request. No triggering, no scoping.</p>
  </div>
</div>

<p v-click class="!mt-9 !text-[2rem] !leading-relaxed text-left !max-w-[95%]">
  <span class="hl">They compose:</span> a skill tells the agent <span class="hl">how</span> to use
  the Pulumi <span class="hl">MCP</span> server, and your <span class="hl">CLAUDE.md</span> points
  at the skills your repo expects. Best results use all three.
</p>

<!--
~60s. Clear up the confusion before it derails the room. Reveal one card per click:
Skill = how-to (on demand). MCP = tools/live data (a server). CLAUDE.md = always-on rules.
Then the composed payoff: they're complementary; the Pulumi skills literally teach the
agent how to drive the Pulumi MCP server.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)] !max-w-[95%]">Why DevOps should use skills too</h1>
</div>

<!--
Pivot to the DevOps angle, echoing the agenda line. The job is repeatable judgement, the
exact shape of a skill. This is where the room leans in: their runbooks, encoded.
-->

---

# The job is already skill-shaped

<div class="zoom-content">

<p v-click class="!mt-8 !text-[1.4rem] !leading-relaxed">
  <span class="hl">"If you find yourself doing the same type of task with different content
  each time, that's a skill waiting to be built."</span>
</p>

<p v-click class="!mt-6 !text-[1.4rem] !leading-relaxed">
  Pipeline triage. Pulumi drift. <code>CrashLoopBackOff</code>. Cost spikes. The Sev1
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
  <div v-click class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Today</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>Runbook in a wiki, last edited 18 months ago</li>
      <li>Senior engineer re-explains it on every incident</li>
      <li>Agent guesses, reaches for the wrong command</li>
      <li>You re-paste your conventions into every prompt</li>
    </ul>
  </div>
  <div v-click class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">With skills</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>Runbook is a <code>SKILL.md</code> in git, reviewed like code</li>
      <li>Encoded <strong>once</strong>, so every engineer's agent runs it the same way</li>
      <li>Safe by default: read-only, preview before apply</li>
      <li>Triggers itself when the task matches</li>
    </ul>
  </div>
</div>

<p v-click class="!mt-9 !text-[2rem] !leading-relaxed text-left !max-w-[95%]">
  <span class="hl">The stack in 2026:</span> skills carry the <span class="hl">know-how</span>,
  MCP servers / CLIs give <span class="hl">governed access</span> to real systems (Pulumi, Vault,
  Datadog), and the agent <span class="hl">orchestrates</span>.
</p>

<!--
~60s. Left/right before-after, one card per click. The payoff line: senior-engineer
judgement encoded once, distributed to every engineer's agent. Land the "skills + MCP +
agent" division of labor, it frames the whole rest of the workshop.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)] !max-w-[95%]">Find &amp; evaluate skills</h1>
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
      <li v-click><strong>Vendor sets:</strong> Pulumi ships <code>pulumi/agent-skills</code> (Apache-2.0, 4 plugin groups); cloud providers ship theirs</li>
      <li v-click>The skills directory, <code>skills.sh</code>, and Anthropic's <code>anthropics/skills</code></li>
      <li v-click>Community runbooks like <code>bregman-arie/devops-sre-skills</code> and <code>dirien/claude-skills</code></li>
      <li v-click>And your own org repo, full of skills your teammates already wrote</li>
    </ul>
  </div>
  <div class="big-code">

```bash
# The fastest skill is the one
# someone else already ran in prod.

npx skills find pulumi      # search
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

<p class="!mt-6 !text-[1.3rem] !leading-relaxed">A skill <span class="hl">acts on your infrastructure.</span></p>

<div class="grid grid-cols-2 gap-x-12 gap-y-3 !mt-4">
  <p v-click class="!text-[1.2rem] flex items-start gap-3"><ph-identification-card class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 mt-[0.18em]" /><span><strong>Who publishes it?</strong> Unknown author = unknown blast radius.</span></p>
  <p v-click class="!text-[1.2rem] flex items-start gap-3"><ph-gear class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 mt-[0.18em]" /><span><strong>What can it run?</strong> Read the scripts.</span></p>
  <p v-click class="!text-[1.2rem] flex items-start gap-3"><ph-target class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 mt-[0.18em]" /><span><strong>Is the description honest?</strong> It's the trigger.</span></p>
  <p v-click class="!text-[1.2rem] flex items-start gap-3"><ph-shield-check class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 mt-[0.18em]" /><span><strong>Safe by default?</strong> Preview before mutate.</span></p>
  <p v-click class="!text-[1.2rem] flex items-start gap-3"><ph-wrench class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 mt-[0.18em]" /><span><strong>Maintained?</strong> Commits, versions, changelog.</span></p>
  <p v-click class="!text-[1.2rem] flex items-start gap-3"><ph-puzzle-piece class="!text-[1.5rem] text-[var(--p-primary)] shrink-0 mt-[0.18em]" /><span><strong>Fits your stack?</strong> Pulumi ≠ Terraform.</span></p>
</div>

</div>

<aside v-click class="info-card">
  <div class="info-card__label">Rule of thumb</div>
  <p>Read the whole <code>SKILL.md</code> and every script it bundles before you enable it. <strong>If you wouldn't merge it as a PR, don't install it as a skill.</strong></p>
</aside>

<!--
~60s. Six questions. The one that matters most for DevOps: "what can it run", a
write-capable skill is a supply-chain surface. The rule of thumb is the takeaway line.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20 text-center">
  <h1 class="!text-[6rem] !leading-tight !font-semibold !tracking-tight !m-0 !text-[var(--p-primary)] !max-w-[95%]">Connect, configure &amp; use</h1>
</div>

<!--
Section divider. Install a skill, then watch the agent use it inside a real task. This is
where APM enters, the manifest that makes installs reproducible for the whole team.
-->

---

# Connecting a skill: two ways

<div class="grid grid-cols-2 gap-8 mt-4">
  <div v-click class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Universal CLI (skills.sh)</div>

```bash
# Works for Claude Code, Cursor,
# Copilot, Codex, Gemini, …
npx skills add pulumi/agent-skills \
  --skill '*'
```

  <p class="!mt-3 !text-[1.1rem] !leading-relaxed">Lands in <code>.agents/skills/</code>, pinned in <code>skills-lock.json</code>.</p>
  </div>
  <div v-click class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Claude Code marketplace</div>

```bash
/plugin marketplace add \
  pulumi/agent-skills
/plugin install pulumi
```

  <p class="!mt-3 !text-[1.1rem] !leading-relaxed">Lands in your Claude plugins, grouped by plugin.</p>
  </div>
</div>

<p v-click class="!mt-9 !text-[2rem] !leading-relaxed text-left !max-w-[95%]">
  Both are per-machine. What does your <span class="hl">teammate</span> get when they clone
  the repo? <span class="hl">Nothing.</span> Unless there's a manifest.
</p>

<style scoped>
:deep(.slidev-code) {
  font-size: 1.05rem !important;
  line-height: 1.5 !important;
  margin: 0.3rem 0 0 !important;
  padding: 0.8rem 1rem !important;
}
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

<p v-click class="!mt-5 !text-[1.35rem] !leading-relaxed !max-w-[72%]">
  <span class="hl">Reproducible</span> by design. And because these skills run code, <code>apm</code>
  scans every install for <span class="hl-soft">hidden-Unicode attacks</span> and pins their hashes.
  Policy can gate what's allowed across the org.
</p>

</div>

<div class="apm-qr">
  <img src="/img/apm-repo-qr.png" alt="microsoft/apm on GitHub" />
  <div class="apm-qr__label">github.com/microsoft/apm</div>
</div>

<style scoped>
.apm-qr {
  position: absolute;
  bottom: 2.5rem;
  right: 3rem;
  z-index: 20;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}
.apm-qr img {
  width: 9rem;
  height: 9rem;
  background: #fff;
  border-radius: 12px;
  padding: 0.5rem;
  box-shadow: 0 10px 28px rgba(0, 0, 0, 0.35);
}
.apm-qr__label {
  font-family: var(--slidev-font-mono);
  font-size: 1rem;
  font-weight: 600;
  color: var(--p-fg);
}
</style>

<!--
~60s. The thesis of the "build on APM" choice. npx skills = imperative, per-machine. APM =
declarative, reproducible, multi-harness, like going from "curl | sh" to a lockfile.
The security angle (hidden-Unicode scan, pinned hashes) matters for skills that run code.
QR bottom-right goes to github.com/microsoft/apm.
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
    - name: pulumi                        # Pulumi's hosted MCP server (OAuth on first use)
      registry: false
      transport: http
      url: https://mcp.ai.pulumi.com/mcp
  # lsp: language servers (next slide) · hooks live in .apm/hooks/
```

<div class="grid grid-cols-3 gap-5 mt-5">
  <div v-click class="gpu-card gpu-card--muted"><div class="gpu-caption gpu-caption--muted">apm install</div><p class="!mt-2 !text-[1.05rem]">Resolve + scan, then integrate it all into <code>.claude/</code>: skills, hooks, LSP, MCP.</p></div>
  <div v-click class="gpu-card gpu-card--muted"><div class="gpu-caption gpu-caption--muted">commit apm.lock.yaml</div><p class="!mt-2 !text-[1.05rem]">Pins exact versions and content hashes, the same for everyone.</p></div>
  <div v-click class="gpu-card gpu-card--muted"><div class="gpu-caption gpu-caption--muted">git clone &amp;&amp; apm install</div><p class="!mt-2 !text-[1.05rem]">A new teammate is fully configured in one command.</p></div>
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
  <div v-click class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Agent Skills</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Static know-how</strong> in your agent. "How an expert uses Pulumi." Loaded on demand. Free until used.</p>
  </div>
  <div v-click class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Pulumi MCP server</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Live tools.</strong> Query the registry, validate code, reach Pulumi Cloud. Governed access, so the agent never holds creds.</p>
  </div>
  <div v-click class="gpu-card gpu-card--accent">
    <div class="gpu-caption gpu-caption--accent">Pulumi Neo</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed"><strong>Autonomous agent</strong> with RBAC + human-in-the-loop. Hand off with the <code>pulumi-neo-handoff</code> skill.</p>
  </div>
</div>

<p v-click class="!mt-9 !text-[2rem] !leading-relaxed text-left !max-w-[95%]">
  A <span class="hl">skill</span> teaches the agent how to drive the <span class="hl">MCP</span> server;
  when the job gets big, <code>pulumi-neo-handoff</code> packages it into a <span class="hl">Neo</span> task.
</p>

<!--
~60s. The Pulumi-specific stack. Skills = knowledge, MCP = governed live access, Neo =
autonomous execution with governance. The handoff skill is the bridge. Don't oversell Neo:
today we only show the pulumi-neo-handoff skill, not a live Neo run — don't claim
"autonomous incident resolution" from a slide.
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
      <li v-click>The agent sees <span class="hl">real types and live diagnostics</span> as it writes</li>
      <li v-click>So it uses the <span class="hl-soft">real cloud-SDK API</span> (the actual args on <code>aws.s3.Bucket</code>) instead of guessing</li>
      <li v-click><code>apm install</code> writes <code>.lsp.json</code>, not the binaries. You put <code>gopls</code> / <code>pyright</code> / <code>typescript-language-server</code> on <code>$PATH</code> yourself</li>
      <li v-click class="!font-semibold">Mistakes get caught as the code is typed, not at <code>pulumi up</code></li>
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
    "command": "\"$CLAUDE_PROJECT_DIR\"/scripts/guard-pulumi.sh",
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
      <li v-click>A <code>PreToolUse</code> hook on the <span class="hl">Bash</span> tool sees the command first; exit <code>2</code> blocks it and hands the reason back</li>
      <li v-click><code>apm install</code> merges it into <code>.claude/settings.json</code>. Pair it with a <code>permissions</code> deny-list, the "settings" lever</li>
      <li v-click class="!font-semibold">It's a <span class="hl">nudge, not a wall.</span> The agent can still deploy via the Automation API, the MCP server, or a <code>make</code> wrapper, none of which touch Bash</li>
    </ul>
  </div>
</div>

<aside v-click class="info-card">
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

# Same prompt, configured vs not

<div class="grid grid-cols-2 gap-8 mt-3">
  <div v-click class="gpu-card gpu-card--muted">
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
  <div v-click class="gpu-card gpu-card--primary">
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

<style scoped>
:deep(.slidev-code) { font-size: 0.95rem !important; line-height: 1.4 !important; }
</style>

<!--
~90s. THE money shot (PRESENTER.md protects this demo above all). Don't just assert config
helps; show it. Naked: invents `publicReadAccess`, skips preview. Configured: LSP flags the
arg in-editor, the golden-path skill adds standard tags, the hook stops `pulumi up`. This
exact scenario runs LIVE in the demo block at the end (demo/pulumi-ts ships the red squiggle
on publicReadAccess ready to show) — promise it here, don't run it now. If only one demo
survives the clock, it's this one.
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
  <div v-click class="big-code">

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
:deep(.slidev-code) { font-size: 1.1rem !important; line-height: 1.5 !important; }
</style>

<!--
~60s. The magic moment: you didn't say "use the skill." The agent matched your plain
request to the skill's description and ran it, with the safety defaults baked in
(preview, no unprompted up). That's the whole value: your playbook, automatically.
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
      <li v-click><span class="hl">references/</span> hold the heavy detail (severity matrix, escalation), read only when the task needs them</li>
      <li v-click><span class="hl">scripts/</span> do the deterministic part. <code>gather-diagnostics.sh</code> gathers evidence and <span class="hl-soft">mutates nothing</span></li>
      <li v-click><span class="hl">templates/</span> are what it fills in: a postmortem, ready to paste</li>
      <li v-click class="!font-semibold"><span class="hl">read-only</span> by default. It proposes a fix; a human approves.</li>
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
  <p v-click class="!text-[1.25rem]"><strong>1. The description is the trigger.</strong> Say what it does <em>and</em> when. Third person, specific.</p>
  <p v-click class="!text-[1.25rem]"><strong>2. One skill, one job.</strong> Sharp scope beats a mega-skill that competes with itself.</p>
  <p v-click class="!text-[1.25rem]"><strong>3. Keep <code>SKILL.md</code> short.</strong> Under ~500 lines; push detail into <code>references/</code>.</p>
  <p v-click class="!text-[1.25rem]"><strong>4. Scripts for procedure.</strong> If a step is exact commands, ship the script and have the agent run it.</p>
  <p v-click class="!text-[1.25rem]"><strong>5. Name it like your team talks.</strong> Match the words people actually use.</p>
  <p v-click class="!text-[1.25rem]"><strong>6. Safe by default.</strong> Read-only, preview, confirm before mutating. No static creds.</p>
</div>

<aside v-click class="info-card">
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

# Keep them current · remove them clean

<div class="grid grid-cols-2 gap-10 mt-4">
  <div v-click class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Keep up to date</div>
    <ul class="!mt-3 !text-[1.2rem] !leading-relaxed space-y-2">
      <li>Skills live in <strong>git</strong> next to the runbook; change both in one PR</li>
      <li><strong>Review like code</strong>; pin deps and bump deliberately (<code>apm update</code>)</li>
      <li>Re-test on model/agent upgrades, and keep a smoke prompt per critical skill</li>
      <li class="!font-semibold">Stale skill &gt; stale doc: the agent <em>acts</em> on it</li>
    </ul>
  </div>
  <div v-click class="gpu-card gpu-card--muted">
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

# What you've got now

<div class="zoom-content">

<ul class="!mt-6 !text-[1.45rem] !leading-relaxed space-y-4">
  <li v-click>A skill is a <span class="hl">folder + SKILL.md</span>; the description is the trigger; progressive disclosure keeps it cheap</li>
  <li v-click><span class="hl">Adopt before you build</span>, and read the scripts before you trust them</li>
  <li v-click><span class="hl">APM</span> makes installs reproducible for the whole team; <span class="hl">Pulumi skills + MCP + Neo</span> handle the actual Pulumi work</li>
  <li v-click>Your <span class="hl">runbooks</span> are skills waiting to be built. Capture the next one you do twice.</li>
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

# What we didn't cover

<div class="grid grid-cols-2 gap-8 mt-4">
  <div v-click class="gpu-card gpu-card--primary">
    <div class="gpu-caption gpu-caption--accent">Skill evals</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed">Anthropic's <code>skill-creator</code> now <strong>tests skills</strong>: eval cases (a realistic prompt + assertions), benchmarks for pass rate / time / tokens, and blind A/B of skill vs no skill.</p>
  </div>
  <div v-click class="gpu-card gpu-card--muted">
    <div class="gpu-caption gpu-caption--muted">Org-wide governance</div>
    <p class="!mt-3 !text-[1.15rem] !leading-relaxed">Enterprise-managed skills, and APM's <code>apm-policy.yml</code>: tighten-only rules from enterprise → org → repo for what agents may install.</p>
  </div>
</div>

<p v-click class="!mt-9 !text-[2rem] !leading-relaxed text-left !max-w-[95%]">
  And the habit that makes evals matter: <span class="hl">every new model release can change how
  your skills behave.</span> Re-run the evals; a skill that worked yesterday can drift today.
</p>

<!--
~60s. Honest close: two things worth your evenings. (1) Skill EVALS: skill-creator has
Create/Eval/Improve/Benchmark modes; a test case pairs a realistic prompt with assertions;
benchmarks track pass rate, time, tokens; blind A/B compares skill vs no-skill so you know
it actually helps. (2) Governance at org scale. The kicker: models ship constantly, and each
one can change skill behavior. Capability skills go obsolete when the base model catches up;
preference skills drift. Standing rule: new model, re-run your evals.
Sources: anthropics/skills skill-creator; tessl.io "Anthropic brings evals to skill-creator".
-->

---

<div class="absolute inset-0 flex flex-col items-center justify-center px-20 text-center">
  <h1 class="!text-[10rem] !leading-none !font-bold !tracking-[0.08em] !m-0 !text-[var(--p-fg)]">DEMO</h1>
</div>

<!--
The live demo block, at the end where the whole story comes together. Three beats:
(1) apm install wiring everything into .claude/; (2) the money shot — the LSP squiggle in
demo/pulumi-ts, the golden-path skill triggering off a plain request, the hook holding
`pulumi up`; (3) incident-triage on the crashlooping payments pod. Run what time allows;
PRESENTER.md has the beats and the cut order.
-->

---

<div class="absolute inset-0 flex flex-col justify-center items-center px-20">
  <div class="opacity-80 tracking-[0.6em] uppercase !text-[1.6rem] !mb-4 text-[var(--p-fg-muted)]">Thank you</div>
  <h1 class="!text-[4.5rem] !leading-[1.02] !font-semibold !tracking-tight !mb-16 text-center">
    Go make your agent <span class="!text-[var(--p-primary)]">yours.</span>
  </h1>

  <div class="flex gap-12 justify-center items-start">
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
      <img src="/img/adam-gordon-bell.png" class="w-32 h-32 rounded-full mx-auto mb-4 border-4 object-cover" style="border-color: rgba(126,107,255,0.35)" alt="Adam Gordon Bell" />
      <div class="!text-[1.7rem] !font-bold">Adam Gordon Bell</div>
      <div class="opacity-60 !text-[1.2rem]">Pulumi</div>
      <div class="flex items-center justify-center gap-4 mt-2 !text-[1.1rem] opacity-60">
        <span class="flex items-center gap-1"><carbon-logo-github /> adamgordonbell</span>
        <span class="flex items-center gap-1"><carbon-logo-linkedin /> adamgordonbell</span>
      </div>
      <div class="mt-5 bg-white rounded-lg p-2 inline-block shadow-lg">
        <img src="/img/adam-linkedin-qr.png" class="w-32 h-32" alt="Adam Gordon Bell LinkedIn QR" />
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
Thank you. Scan to connect with Engin or Adam on LinkedIn, grab the workshop repo (slides +
chapters + the skills we built), and the Pulumi AI/skills docs. Then go capture your next runbook.
-->

