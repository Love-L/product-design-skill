# Contributing

感谢你愿意改进这个项目。它不是一个「观点集合」，而是一套要被人拿去用的判断工具，所以对内容的要求会比对格式更严格。

## 项目定位

- 只收**可执行**的内容：能指导一个具体取舍，而不是正确的废话。
- 每条规则要有**适用条件**与**失效条件**；只写「应该怎样」而不写「什么时候不成立」，会被要求补充。
- 不神化任何一本书、任何框架；允许写「这条在低频 B 端不成立」。
- 不摘录受版权保护的原文；用自己的话复述机制，并标注思想来源。

## 目录约定

```text
skills/product-design/
├── SKILL.md          # 主入口：只放模式选择、工作流、速查、质量闸门
├── references/       # 深度内容：一个主题一个文件
└── assets/           # 可直接复制的模板
```

- 新增 `references/*.md` 或 `assets/*.md` 后，**必须**在 `SKILL.md` 的「参考文件」表中登记，否则 `npm run validate` 会失败。
- `SKILL.md` 控制在 400 行以内；细节放参考文件，按需加载。
- 文件名用小写英文与连字符；中文标题写在文件内。

## 内容标准

1. **可执行**：给出动作、判断条件或模板，而不只是概念解释。
2. **有边界**：说明适用产品类型、阶段、角色；写清什么时候不要用。
3. **有证据等级**：区分事实、推断、假设；不要用「研究表明」代替来源。
4. **有取舍**：每个建议说明解决了什么、牺牲了什么。
5. **术语克制**：首次出现给英文原文；不要用「赋能/抓手/闭环」替代具体机制。
6. **中文文案**：短句、动词开头、少用形容词；表格优先于长段落。

## 修改流程

1. Fork 仓库，或从 `main` 切一个分支：`feat/xxx`、`fix/xxx`、`docs/xxx`。
2. 修改内容，必要时同步更新 `README.md` / `README.en.md` / `CHANGELOG.md`。
3. 运行校验：

   ```bash
   npm run validate
   ```

4. 提交 PR，说明：
   - 为什么改（遇到的问题/反例）
   - 改了什么（文件与要点）
   - 影响面（是否改变既有建议的适用条件）
5. 至少一位维护者 review；涉及框架性改动的，先在 Issue 里讨论。

## Commit 约定

使用 [Conventional Commits](https://www.conventionalcommits.org/)：

```text
feat: add B2B permission design checklist
fix: correct the mapping example in Norman lens
docs: clarify when not to use the Hook model
chore: bump validation script to Node 20
```

## 翻译

- `README.md` 为中文，`README.en.md` 为英文；两者结构保持同步。
- Skill 正文以中文为准；如需其他语言版本，建议新建 `skills/product-design-<lang>/`，而不是在正文里混排。
- 翻译 PR 请同时更新两份 README 的链接与措辞。

## 内容边界

- 不提交真实客户数据、内部文档、未脱敏案例。
- 不提交歧视性、操纵性或以剥削脆弱人群为目标的设计方法。
- 涉及医疗、金融、未成年人、公共安全的内容，必须标注合规与安全优先。

## 行为准则

对事不对人。批评框架，不批评提出框架的人；用反例和证据说话。维护者有权拒绝不符合项目定位的贡献，并说明理由。
