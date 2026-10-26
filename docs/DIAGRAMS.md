# 图示系统

README 里的五张图不是手工拼的截图，而是**可复现的 HTML + CSS**。源文件在 `docs/diagrams/`，导出的 PNG 在 `docs/assets/`，通过无头 Chrome / Edge 渲染。

## 为什么用 HTML 而不是直接画 SVG

- 中文排版、换行、卡片布局用 CSS 更可靠；
- 一套 `base.css` 统一颜色、字号、网格背景；
- 修改文案后重跑一条命令即可，不用手动挪像素；
- 输出 2x PNG，GitHub 在高分屏上依然清晰。

## 目录

```text
docs/
├── diagrams/
│   ├── base.css          # 共用设计变量、页面底色、网格、标题样式
│   ├── hero.html         # 封面：五镜环绕
│   ├── five-lenses.html  # 五本书的定位、工具、边界
│   ├── workflow.html     # P0–P7 工作流与三种裁剪模式
│   ├── architecture.html # 宿主 / 技能包 / 工程层
│   └── session.html      # 一次会话的五次收敛
└── assets/
    ├── hero.png
    ├── five-lenses.png
    ├── workflow.png
    ├── architecture.png
    └── session.png
```

## 重新生成

Windows：

```powershell
.\scripts\render-diagrams.ps1
# 或指定浏览器
.\scripts\render-diagrams.ps1 -Browser "C:\Program Files\Google\Chrome\Application\chrome.exe"
```

macOS / Linux：

```bash
./scripts/render-diagrams.sh
# 或指定浏览器
CHROME=/usr/bin/google-chrome ./scripts/render-diagrams.sh
```

两个脚本都会自动寻找 Chrome 或 Edge，按固定尺寸渲染 2x PNG。尺寸定义在脚本里：

| 图 | 画布 |
|---|---|
| hero | 1200 × 620 |
| five-lenses | 1200 × 1020 |
| workflow | 1200 × 880 |
| architecture | 1200 × 880 |
| session | 1200 × 760 |

## 设计约定

| 项 | 值 |
|---|---|
| 背景 | `#0B1220`，叠加 40px 网格与两处径向光晕 |
| 主文字 | `#E6EDF7` |
| 次文字 | `#93A4BE` / `#7F93AF` |
| 强调色 | 蓝 `#6EA8FF` · 青 `#3DE0C8` · 琥珀 `#F5B65C` · 玫红 `#FF7E9D` · 紫 `#B49CFF` |
| 字体 | Microsoft YaHei / PingFang SC / Segoe UI |
| 圆角 | 卡片 14–18px，小控件 6–9px |
| 输出 | 2x PNG，深色底（浅色/深色主题下都不刺眼） |

**为什么统一深色底**：GitHub 的浅色与深色主题下，深色卡片都成立，不需要维护两套图片。

## 新增一张图

1. 在 `docs/diagrams/` 新建 `<name>.html`，引用 `base.css`；
2. 在 `scripts/render-diagrams.ps1` 的 `$diagrams` 数组里登记名称与尺寸；
3. 运行脚本生成 `docs/assets/<name>.png`；
4. 在 `README.md` 与 `README.en.md` 中引用，并补一句图注；
5. 运行 `npm run validate`，确认图片链接可达。

## 注意

- 图片里的文案要和 `SKILL.md` 的框架一致；改框架时同步改图。
- 不要把大段正文塞进图里；图负责结构和记忆点，细节留在 Markdown。
- 导出后检查边缘是否被裁切，尤其是底部一行。
