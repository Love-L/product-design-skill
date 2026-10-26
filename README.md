# Product Design OS · 产品设计操作系统

> 把模糊的产品想法，推进到**可理解、可行动、可重复、可交易、可验证**的方案。

[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Skill](https://img.shields.io/badge/skill-product--design-blue.svg)](skills/product-design/SKILL.md)
[![Docs](https://img.shields.io/badge/docs-%E4%B8%AD%E6%96%87-red.svg)](README.md)
[![Validate](https://img.shields.io/badge/validate-node%20scripts%2Fvalidate.mjs-brightgreen.svg)](scripts/validate.mjs)

一个给 AI agent 用的产品设计 skill。

它不是五本书的读书笔记，而是一套**先判断、再设计、最后验证**的工作流：先判断值不值得做，再判断用户能不能懂、会不会再来，最后判断在真实组织和业务链路里能不能落地。

---

## 为什么是这五本书

五本书各自回答一个不同的问题，合起来覆盖产品设计从「要不要做」到「怎么落地」的全链路：

| 书 | 回答的问题 | 核心工具 | 什么时候别用 |
|---|---|---|---|
| 俞军《产品方法论》 | 值不值得做？和谁交易？ | 用户价值公式、需求的集合、交易成本 | 早期数据不足时，别把公式算成自欺欺人的精确数字 |
| 诺曼《设计心理学》 | 用户能不能看懂、能不能做成？ | 概念模型、意符、映射、反馈、七阶段行动 | 只解决「能用」，解决不了「想要」 |
| 原研哉《设计中的设计》 | 用户能不能重新「感觉到」？ | 空白、再设计、信息雕刻、感官 | 高风险、高密度、强时效的 B 端操作场景 |
| 埃亚尔《上瘾》 | 行为会不会再次发生？ | 触发 → 行动 → 可变奖励 → 投入 | 低频、一次性、B 端强制流程、脆弱人群 |
| 杨堃《决胜体验设计》 | 在真实组织里能不能落地、能不能度量？ | 场景地图、架构与 IA、反馈/促活/消息、六脉神剑 | 极轻量的 C 端小功能，容易过度工程化 |

**关键不是把五本书都塞进去，而是划清各自的适用边界。** 比如：

- 低频、强制的 B 端流程，**不做** Hook；
- 对账、巡检、急救类场景，**不用**大面积留白；
- 早期没有数据时，价值公式只做「结构化假设 + 反证条件」；
- 「让用户上瘾」先区分「有价值的使用习惯」与「剥削性操纵」。

---

## 工作流：P0–P7

```mermaid
flowchart LR
  P0[P0 立题] --> P1[P1 见人] --> P2[P2 算账] --> P3[P3 建模]
  P3 --> P4[P4 行为] --> P5[P5 感知] --> P6[P6 验证] --> P7[P7 交付]
```

| 阶段 | 要解决的问题 | 主要产出 |
|---|---|---|
| **P0 立题** | 谁在什么处境、被什么卡住 | 问题陈述 + 非目标 + 产品类型 |
| **P1 见人** | 用户到底是谁、在什么场景做什么 | 角色-场景-任务表 + 现状旅程 |
| **P2 算账** | 值不值得做、用户为什么换 | 价值假设 + 交易图 + 反证条件 |
| **P3 建模** | 用户怎么理解、怎么行动 | 概念模型 + IA + 主/异常任务流 |
| **P4 行为** | 第一次是否顺、下一次是否来 | 交互流程 + 反馈矩阵 + 可选 Hook |
| **P5 感知** | 是否被记住、是否可信 | 3–5 条体验原则 + 界面意图 |
| **P6 验证** | 什么证据会推翻我们 | 验证计划 + 指标树 + 放弃条件 |
| **P7 交付** | 怎么实现、怎么复盘 | PRD + 评审记录 + 复盘结论 |

也提供 **30 分钟快速模式**：只走 P0、P2、P3 的概念模型、Top 3 风险，输出一页纸，适合早期讨论。

---

## 里面有什么

```text
product-design-skill/
├── skills/product-design/
│   ├── SKILL.md                    # 主文件：模式选择、五镜速查、P0–P7、质量闸门
│   ├── references/
│   │   ├── 01-five-lenses.md       # 五本书的模型、概念词典、诊断问题、局限
│   │   ├── 02-workflow.md          # 八步详细操作 + 提问脚本 + 完整案例
│   │   ├── 03-heuristics.md        # 决策树、25 条 if-then、反模式、伦理、指标库
│   │   └── 04-b-end-and-ai.md      # B 端框架 + AI 六脉神剑 + 度量选型
│   └── assets/
│       ├── design-brief.md         # 一页纸设计简报模板
│       └── review-checklist.md     # 七维评审清单 + 评分与结论规则
├── scripts/
│   ├── validate.mjs                # 结构 / frontmatter / 链接校验（零依赖）
│   ├── install.ps1                 # Windows 安装
│   └── install.sh                  # macOS / Linux 安装
├── .github/workflows/validate.yml  # CI：每次 push / PR 自动校验
├── CONTRIBUTING.md
├── CHANGELOG.md
├── LICENSE
├── README.md                       # 中文
└── README.en.md                    # English
```

主文件只保留「什么时候用哪一招」，细节放在按需加载的参考文件里，避免每次对话都灌进 2500 行。

---

## 安装

### DSH（DeepSeek Harness）

```powershell
# 安装到用户级：~/.dsh/skills/product-design
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1

# 或安装到某个项目：<project>/.dsh/skills/product-design
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Target project -ProjectPath E:\your-project
```

安装后新开会话即可在 skill 目录里看到 `product-design`，无需重启宿主。

### Claude Code

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Target claude
```

对应目录：`~/.claude/skills/product-design/SKILL.md`。

### macOS / Linux

```bash
./scripts/install.sh dsh          # ~/.dsh/skills/product-design
./scripts/install.sh claude       # ~/.claude/skills/product-design
./scripts/install.sh project /path/to/project
```

### 任意 agent / 手动

把 `skills/product-design/` 整个目录复制到该 agent 的 skill 根目录即可。只要它支持「目录 + `SKILL.md` + YAML frontmatter（`name` / `description`）」这一约定，就能加载。

---

## 使用

直接用自然语言提出任务即可，skill 会根据任务类型选择镜头：

```text
用 product-design 帮我设计一个面向自由职业者的记账工具。

用 product-design 评审这份 PRD：docs/prd.md。

我们用 product-design 诊断一下门店巡检系统的体验问题。

用 product-design 设计一个 B 端采购审批的 AI Copilot。
```

**它会先做三件事**：判断产品类型、用一句话复述问题、只问 3 个高杠杆问题。信息足够时直接产出，并标注 `[事实] / [推断] / [假设]`。

### 典型产出

- 一页纸 **Design Brief**：问题、非目标、角色场景、价值公式、反证条件
- **概念模型**：对象 / 状态 / 动作 / 规则，一张图讲清
- **任务流**：主流程 + 异常流 + 状态机
- **Hook 工作表**（仅高频产品）：触发、行动、可变奖励、投入、伦理结论
- **评审清单**：七维评分 + CRITICAL / HIGH / MEDIUM / LOW 问题清单 + 结论

---

## 设计原则

1. **问题 > 方案，模型 > 界面，场景 > 功能。**
2. **区分事实、推断、假设**；关键假设必须带验证方式。
3. **不设计操纵**：透明性、受益性、可退出性、脆弱性，四问不过就不做。
4. **每个建议带取舍**：解决了什么、牺牲了什么、什么情况下不成立。
5. **发现方向性错误时先停下来指出**，不要顺着错误前提做漂亮方案。

---

## 质量校验

零依赖，Node.js ≥ 18：

```bash
npm run validate
# 或
node scripts/validate.mjs
```

校验内容：

- `SKILL.md` 是否存在、frontmatter 是否合法（`name` kebab-case、`description` 非空）
- `references/` 与 `assets/` 是否被 `SKILL.md` 引用
- 全仓库 Markdown 本地链接是否可达
- 代码块围栏是否成对

CI 在 `.github/workflows/validate.yml`，push / PR 自动运行。

---

## 兼容性

| 宿主 | 支持方式 |
|---|---|
| DSH（DeepSeek Harness） | 目录 bundle：`<root>/product-design/SKILL.md` |
| Claude Code | 用户级/项目级 `skills/product-design/SKILL.md` |
| 其他 agent | 只要支持 `SKILL.md` + frontmatter 约定即可 |

> 不同宿主对 `description` 长度、可用工具名、资源引用方式的支持不同；本 skill 只依赖 Markdown 与相对路径，不绑定任何专有工具。

---

## 边界与免责声明

- 这是**判断辅助**，不替代用户研究、数据分析、工程可行性验证与合规审查。
- 五本书的结论各有时代与语境；引用时请说明适用条件，不要当普适真理。
- 涉及医疗、金融、未成年人、公共安全等高风险领域，优先合规与安全，其次才是体验与增长。
- 本项目是独立的思想提炼与再组织，**不包含五本书的原文摘录**，与作者、出版方无隶属或背书关系。

---

## 贡献

欢迎补充案例、修订框架、增加翻译。请先读 [CONTRIBUTING.md](CONTRIBUTING.md)。

最低要求：

1. 内容可执行，能指导一个具体取舍；
2. 标注适用边界与失效条件；
3. 不摘录受版权保护的原文；
4. `npm run validate` 通过。

---

## License

[MIT](LICENSE) © 2026 product-design-skill contributors

## 致谢

- Donald A. Norman, *The Design of Everyday Things*
- 原研哉，《设计中的设计》
- Nir Eyal, *Hooked: How to Build Habit-Forming Products*
- 俞军，《俞军产品方法论》
- 杨堃，《决胜体验设计：AI 时代的 B 端用户体验设计指南》

感谢五位作者把经验写成可讨论的框架。本书名与作者名仅用于说明思想来源。

---

## 发布到 GitHub

仓库已初始化并完成首次提交。创建远程仓库并推送：

```bash
# 方式一：GitHub CLI（推荐）
gh repo create product-design-skill --public --source=. --remote=origin --push

# 方式二：手动
git remote add origin git@github.com:<your-name>/product-design-skill.git
git push -u origin main
```

建议的仓库描述：

> A product design operating system for AI agents, distilled from five classic product and design books.

建议 topics：

`product-design` `product-manager` `ai-agent` `skill` `design-thinking` `ux` `b2b` `ai-product`
