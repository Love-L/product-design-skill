# Product Design OS

> Turn a vague product idea into something **understandable, actionable, repeatable, transactable, and testable**.

[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Skill](https://img.shields.io/badge/skill-product--design-blue.svg)](skills/product-design/SKILL.md)

A product-design skill for AI agents. It is not a book summary. It is a **judge-first, design-second, verify-last** workflow distilled from five classics of product and design.

> The skill content is written in Chinese. The structure, templates, and workflow are language-agnostic; an agent can answer in the user's language.

---

## Why these five books

Each book answers a different question, and together they cover the full path from "should we build it" to "does it work in a real organization".

| Book | Question it answers | Core tools | When not to use it |
|---|---|---|---|
| Yu Jun, *Product Methodology* | Is it worth building? Who is trading with whom? | User value formula, demand sets, transaction costs | Don't turn the formula into fake precision when data is thin |
| Don Norman, *The Design of Everyday Things* | Can users understand it and act? | Conceptual models, signifiers, mapping, feedback, seven stages of action | Solves "usable", not "desirable" |
| Kenya Hara, *Designing Design* | Can users feel it again? | Emptiness, re-design, information carving, senses | High-risk, high-density, time-critical B2B operations |
| Nir Eyal, *Hooked* | Will the behavior happen again? | Trigger → action → variable reward → investment | Low-frequency, one-off, mandatory B2B flows, vulnerable users |
| Yang Kun, *Winning Experience Design* | Can it land and be measured in a real organization? | Scenario maps, architecture & IA, feedback/activation/messaging, six swords | Very light consumer features; easy to over-engineer |

The point is not to apply all five. The point is to know **which lens fits, and when it fails**.

---

## Workflow: P0–P7

```mermaid
flowchart LR
  P0[P0 Frame] --> P1[P1 See] --> P2[P2 Value] --> P3[P3 Model]
  P3 --> P4[P4 Behavior] --> P5[P5 Craft] --> P6[P6 Prove] --> P7[P7 Ship]
```

| Phase | Question | Output |
|---|---|---|
| **P0 Frame** | Who is stuck, in what situation? | Problem statement, non-goals, product type |
| **P1 See** | Who exactly, in which scenario, doing what? | Role-scenario-task table, current journey |
| **P2 Value** | Worth building? Why switch? | Value hypothesis, transaction map, falsification conditions |
| **P3 Model** | How do users understand and act? | Conceptual model, IA, main/exception flows |
| **P4 Behavior** | Smooth first time? Reason to return? | Interaction flow, feedback matrix, optional Hook |
| **P5 Craft** | Remembered and trusted? | 3–5 experience principles, key interface intent |
| **P6 Prove** | What evidence would change our mind? | Validation plan, metric tree, kill criteria |
| **P7 Ship** | How to build and learn? | PRD, review record, retrospective |

A **30-minute mode** is included: P0, P2, the P3 conceptual model, and top-3 risks, on one page.

---

## Repository layout

```text
product-design-skill/
├── skills/product-design/
│   ├── SKILL.md
│   ├── references/
│   │   ├── 01-five-lenses.md
│   │   ├── 02-workflow.md
│   │   ├── 03-heuristics.md
│   │   └── 04-b-end-and-ai.md
│   └── assets/
│       ├── design-brief.md
│       └── review-checklist.md
├── scripts/            # validate + install (PowerShell / Bash)
├── .github/workflows/  # CI validation
├── CONTRIBUTING.md
├── CHANGELOG.md
├── LICENSE
├── README.md           # Chinese
└── README.en.md        # English
```

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

The skill starts with three moves: classify the product type, restate the problem in one sentence, and ask only three high-leverage questions. When information is sufficient, it produces the artifact directly and tags claims as `[fact] / [inference] / [assumption]`.

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

Checks frontmatter, referenced resources, local Markdown links, and code fences. CI runs on every push and pull request.

---

## Scope

- An aid to judgment, not a substitute for research, analytics, engineering feasibility, or compliance review.
- The five books are context-bound; state the conditions when citing them.
- For healthcare, finance, minors, and public safety, compliance and safety come first.
- This is an independent synthesis; it contains **no verbatim excerpts** and is not affiliated with the authors or publishers.

---

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). Minimum bar: actionable, bounded, no copyrighted excerpts, `npm run validate` passes.

## License

[MIT](LICENSE) © 2026 product-design-skill contributors

## Acknowledgements

Donald A. Norman, Kenya Hara, Nir Eyal, Yu Jun, Yang Kun — for turning hard-won experience into discussable frameworks.
