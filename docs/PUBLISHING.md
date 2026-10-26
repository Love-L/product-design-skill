# 发布到 GitHub

这份文档写给维护者：如何把本地仓库发布成一个可被搜索、可被安装、可被引用的开源项目。

## 前置检查

```powershell
cd E:\orca\product-design-skill
npm run validate
git status
```

- `npm run validate` 必须通过；
- 工作区必须干净，或确认未提交的改动是故意的；
- `README.md`、`README.en.md`、`CHANGELOG.md` 已同步本次改动。

## 创建远程仓库

### 方式一：GitHub CLI（推荐）

```powershell
gh auth status
gh repo create <owner>/product-design-skill --public --source=. --remote=origin --push
```

把 `<owner>` 换成你的 GitHub 用户名。仓库已初始化并完成首次提交时，这条命令会直接推送 `main`。

### 方式二：手动

```powershell
git remote add origin git@github.com:<owner>/product-design-skill.git
git push -u origin main
```

## 仓库设置

**Description**

> A product design operating system for AI agents, distilled from five classic product and design books.

**Topics**

```text
product-design product-manager ai-agent skill design-thinking ux b2b ai-product
```

**About**

- 勾选 Releases、Packages 不需要；
- 不需要 GitHub Pages，README 直接渲染；
- 建议开启 Discussions，收集案例与反例。

## 发一个版本

```powershell
git tag -a v1.1.0 -m "v1.1.0: diagram system and README rebuild"
git push origin v1.1.0
gh release create v1.1.0 --title "v1.1.0" --notes "图示系统：封面、五镜、工作流、架构、会话；README 重构。"
```

版本号遵循 Semantic Versioning：

- **major**：框架结构变化，旧用法不兼容；
- **minor**：新增参考、图示、模板；
- **patch**：修正错别字、坏链、案例数据。

## 发布前清单

- [ ] `npm run validate` 通过
- [ ] 干净 clone 后仍通过
- [ ] 五张图没有裁切、没有错字
- [ ] README 的安装命令与实际脚本一致
- [ ] `CHANGELOG.md` 已记录本次变更
- [ ] License、致谢、免责声明齐全
- [ ] 没有提交真实客户数据或未脱敏案例
- [ ] 没有摘录受版权保护的原文

## 后续维护

- 每次改 `SKILL.md` 的框架，同步检查 `docs/diagrams/` 里的图是否需要重画；
- 改图后运行 `scripts/render-diagrams.ps1`，提交新的 PNG；
- 新增 `references/` 或 `assets/` 时，先在 `SKILL.md` 的参考表里登记，否则校验失败；
- 安装脚本只复制 `skills/product-design/`，不会把 README、CI 等工程文件带进宿主。
