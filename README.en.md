# Product Design OS

> Turn a vague product idea into something **understandable, actionable, repeatable, transactable, and testable**.

[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Skill](https://img.shields.io/badge/skill-product--design-blue.svg)](skills/product-design/SKILL.md)

[![Product Design OS](docs/assets/hero.png)](docs/assets/hero.png)

<p align="center"><sub>Five lenses · five conditional questions · one judge-first, design-second, verify-last workflow</sub></p>

> The skill body is written in Chinese. Diagrams are Chinese-first. The structure, templates, and frontmatter are language-agnostic, and an agent can answer in the user's language.

---

## What it is

A product-design skill for AI agents.

Install it into DSH, Claude Code, or any host that supports `SKILL.md`, and it works through a fixed order of judgment:

1. **Is it worth building?** (Yu Jun) — who is stuck, what is the current alternative, who pays the switching cost.
2. **Can users understand and act?** (Norman) — conceptual model, signifiers, feedback, exceptions.
3. **Does it feel like anything?** (Kenya Hara) — emptiness, hierarchy, restraint.
4. **Will the behavior happen again?** (Nir Eyal) — trigger, action, variable reward, investment.
5. **Can it land in a real organization?** (Yang Kun) — roles, scenarios, architecture, measurement.

It does not write the PRD for you. It makes you cut what should not be built, mark what is not yet known as an assumption, and define what must be tested.

---

## Why these five books

[![Five lenses](docs/assets/five-lenses.png)](docs/assets/five-lenses.png)

<p align="center"><sub>Figure 1 · What each book answers, its core tools, and when not to use it (click to zoom)</sub></p>

They cover the five chains that most often break in product design: **value, cognition, perception, habit, and system**.

| Book | Question | Core tools | What breaks without it |
|---|---|---|---|
| Yu Jun, *Product Methodology* | Worth building? Who is trading? | User value formula, demand sets, transaction costs | Usable but unwanted |
| Don Norman, *The Design of Everyday Things* | Can users understand and act? | Conceptual models, signifiers, mapping, feedback, seven stages | Valuable but unusable |
| Kenya Hara, *Designing Design* | Can users feel it again? | Emptiness, re-design, information carving, senses | Usable but undesirable |
| Nir Eyal, *Hooked* | Will the behavior repeat? | Trigger, action, variable reward, investment | Used once, then abandoned |
| Yang Kun, *Winning Experience Design* | Can it land and be measured? | Scenario maps, architecture & IA, six swords, measurement | Great demo, broken rollout |

The point is not to apply all five equally. The point is to know **which lens fits, and when it fails**.

---

## How the lenses combine

| Task | Lens order |
|---|---|
| 0→1 consumer product | Yu Jun → Norman → Hara → Eyal |
| Feature iteration | Norman → Yu Jun → Yang Kun |
| Experience diagnosis | Norman → Yang Kun → Hara |
| Retention / habit | Eyal → Yu Jun → ethics review |
| B2B system | Yang Kun → Norman → Yu Jun |
| AI feature | Yang Kun → Norman → Eyal |

**Three tie-breakers**

1. Low-frequency, high-risk, mandatory B2B flows: skip Eyal, use Norman + Yang Kun.
2. High-risk, high-density, time-critical screens: no large-scale emptiness. Restraint must not hurt discoverability.
3. Thin early data: use the value formula as structured assumptions with falsification conditions, not fake precision.

When two lenses conflict, return to the problem statement and the user's situation — not to the more fashionable theory.

---

## Workflow: P0–P7

[![Workflow](docs/assets/workflow.png)](docs/assets/workflow.png)

<p align="center"><sub>Figure 2 · P0–P7 and three trim paths: full, 30-minute, B2B / AI (click to zoom)</sub></p>

| Phase | Must answer | Output | Exit condition |
|---|---|---|---|
| **P0 Frame** | Who hurts most? What if we do nothing? Why now? | Problem statement, non-goals, product type | No feature names in the statement; it can be repeated back |
| **P1 See** | Who uses, buys, blocks? Cost of failure? | Role-scenario-task table, current journey | Every scenario has a person, a moment, a workaround |
| **P2 Value** | What is the delta? Why switch now? Who pays the switching cost? | Value hypothesis, transaction map, falsifiers | One sentence explains why users switch |
| **P3 Model** | What do users think this is? How do they know the next step? How do they recover? | Conceptual model, IA, main/exception flows | A new user can finish the main task on paper |
| **P4 Behavior** | Trigger from emotion or context? Value in 30 seconds? | Interaction flow, feedback matrix, optional Hook | Every step has a next step and a sense of result |
| **P5 Craft** | What do they see first? Does it survive a 50% cut? | 3–5 experience principles, interface intent | Each principle decides a concrete trade-off |
| **P6 Prove** | What evidence would change our mind? When? | Validation plan, metric tree, kill criteria | Every key assumption has a test |
| **P7 Ship** | Which three numbers first? Which layer to fix if missed? | PRD, review record, retrospective | Engineering, design, and ops share one definition of success |

A **30-minute mode** exists for early discussions: P0, P2, the P3 conceptual model, and the top three risks, on one page.

---

## What a session looks like

[![A session](docs/assets/session.png)](docs/assets/session.png)

<p align="center"><sub>Figure 3 · Five convergences in one session: frame, triage, produce, tag, close (click to zoom)</sub></p>

```text
User: I want to build a bookkeeping tool for freelancers.

Skill: First, a judgment — this looks like a low-frequency consumer tool.
Use Norman + Yu Jun; skip Hook for now.

Problem statement draft: freelancers reconciling at month-end want to know
where the money went and what is still unpaid, but income is irregular,
receipts are scattered, and today they reconstruct it manually in Excel.

Three questions:
1. How do you bookkeep today? How often?
2. What hurts most: recording, reconciling, or chasing payments?
3. Would you pay to save time, or to reduce taxes?

Next: after your answers, I will give the value formula and conceptual model.
No feature list yet.
```

**It will not** list twenty features as a substitute for a complete plan, present assumptions as conclusions, or end with "keep optimizing" without a test and a kill criterion.

---

## Architecture

[![Architecture](docs/assets/architecture.png)](docs/assets/architecture.png)

<p align="center"><sub>Figure 4 · Host layer loads, content layer judges, engineering layer validates and distributes (click to zoom)</sub></p>

| Layer | Components | Responsibility |
|---|---|---|
| **Host** | DSH, Claude Code, any `SKILL.md` host | Discover, load the router, read references on demand |
| **Content** | `SKILL.md` + `references/` + `assets/` | Routing, judgment, templates |
| **Engineering** | `scripts/` + `.github/workflows/` + `docs/` | Validation, installation, diagrams, publishing |

The router stays around 250 lines on purpose: context is a budget, not a warehouse. Details live in one-topic reference files, loaded only when the task needs them.

---

## Install

### DSH (DeepSeek Harness)

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1
# project-local:
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Target project -ProjectPath E:\your-project
```

### Claude Code

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Target claude
```

### macOS / Linux

```bash
./scripts/install.sh dsh
./scripts/install.sh claude
./scripts/install.sh project /path/to/project
```

### Manual

Copy `skills/product-design/` into any agent skill root that supports a `SKILL.md` with YAML frontmatter (`name`, `description`).

---

## Usage

```text
Use product-design to design a bookkeeping tool for freelancers.
Use product-design to review this PRD: docs/prd.md.
Use product-design to diagnose our store-inspection system.
Use product-design to design an AI copilot for B2B procurement approvals.
```

It starts with three moves: classify the product type, restate the problem in one sentence, and ask only three high-leverage questions. When information is sufficient, it produces the artifact directly and tags claims as `[fact] / [inference] / [assumption]`.

### Outputs

- One-page **Design Brief**: problem, non-goals, roles, value formula, falsifiers
- **Conceptual model**: objects, states, actions, rules — one diagram
- **Task flows**: main path, exceptions, state machine
- **Hook worksheet** (high-frequency only): trigger, action, variable reward, investment, ethics verdict
- **Review checklist**: seven dimensions, severity-ranked issues, verdict

---

## Principles

1. **Problem > solution, model > interface, scenario > feature.**
2. **Separate fact, inference, and assumption**; every key assumption needs a test.
3. **Do not design manipulation**: transparency, benefit, exitability, vulnerability.
4. **Every recommendation carries a trade-off.**
5. **Stop and flag directional errors** instead of polishing a wrong premise.

---

## Validate

Zero dependencies, Node.js ≥ 18:

```bash
npm run validate
```

Checks frontmatter, referenced resources, local Markdown links and images, and code fences. CI runs on every push and pull request.

---

## Compatibility

| Host | How |
|---|---|
| DSH | Directory bundle: `<root>/product-design/SKILL.md` |
| Claude Code | `skills/product-design/SKILL.md` (user or project level) |
| Other agents | Any `SKILL.md` + frontmatter convention |

---

## FAQ

**How is this different from asking an AI to "design a product"?**

A generic chat jumps to features. This skill forces a product-type judgment, a one-sentence restatement, exactly three questions, evidence tags, and a kill criterion.

**Why is the content in Chinese?**

The five books' primary context and the B2B cases are Chinese-first. The structure is language-agnostic; an English body is on the roadmap.

**What if the five lenses disagree?**

Use the conditions: no Hook for low-frequency B2B, no emptiness for high-risk screens, no fake precision with thin data. Return to the problem statement.

**Does it replace user research?**

No. It requires evidence grading; without data, claims stay assumptions with a test attached.

**Can I use it commercially?**

MIT. Book concepts and cases remain with their authors and publishers; this repository contains no verbatim excerpts.

---

## Scope

- An aid to judgment, not a substitute for research, analytics, engineering feasibility, or compliance review.
- The five books are context-bound; state the conditions when citing them.
- For healthcare, finance, minors, and public safety, compliance and safety come first.
- Independent synthesis; no affiliation with the authors or publishers.

---

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). For diagrams, see [docs/DIAGRAMS.md](docs/DIAGRAMS.md). For publishing, see [docs/PUBLISHING.md](docs/PUBLISHING.md).

## License

[MIT](LICENSE) © 2026 product-design-skill contributors

## Acknowledgements

Donald A. Norman, Kenya Hara, Nir Eyal, Yu Jun, Yang Kun — for turning hard-won experience into discussable frameworks.
