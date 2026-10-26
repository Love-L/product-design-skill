#!/usr/bin/env node
/**
 * Zero-dependency validation for the product-design skill.
 *
 * Checks:
 *  1. Required files exist.
 *  2. SKILL.md has valid YAML frontmatter (kebab-case name, non-empty description).
 *  3. Every file under references/ and assets/ is referenced from SKILL.md.
 *  4. Every local Markdown link in the repository resolves.
 *  5. Code fences are balanced.
 *
 * Usage: node scripts/validate.mjs
 */

import { existsSync, readFileSync, readdirSync } from "node:fs";
import { dirname, join, relative, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const skillRoot = join(repoRoot, "skills", "product-design");
const errors = [];
const warnings = [];

const toPosix = (value) => value.split(sep).join("/");
const label = (value) => toPosix(relative(repoRoot, value));

function walk(dir) {
  const files = [];
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    if (entry.name === ".git" || entry.name === "node_modules") continue;
    const full = join(dir, entry.name);
    if (entry.isDirectory()) files.push(...walk(full));
    else files.push(full);
  }
  return files;
}

function readScalar(frontmatter, key) {
  const match = frontmatter.match(new RegExp(`^${key}:\\s*(.*)$`, "m"));
  if (!match) return undefined;
  let value = match[1].trim();
  if (
    (value.startsWith('"') && value.endsWith('"')) ||
    (value.startsWith("'") && value.endsWith("'"))
  ) {
    value = value.slice(1, -1);
  }
  return value;
}

// 1. Required files
const required = [
  "SKILL.md",
  "references/01-five-lenses.md",
  "references/02-workflow.md",
  "references/03-heuristics.md",
  "references/04-b-end-and-ai.md",
  "assets/design-brief.md",
  "assets/review-checklist.md",
];

for (const file of required) {
  if (!existsSync(join(skillRoot, file))) {
    errors.push(`missing required file: skills/product-design/${file}`);
  }
}

// 2. Frontmatter
const skillFile = join(skillRoot, "SKILL.md");
let skillText = "";

if (existsSync(skillFile)) {
  skillText = readFileSync(skillFile, "utf8");
  const frontmatter = skillText.match(/^---\r?\n([\s\S]*?)\r?\n---(?:\r?\n|$)/);

  if (!frontmatter) {
    errors.push("SKILL.md: missing YAML frontmatter");
  } else {
    const name = readScalar(frontmatter[1], "name");
    const description = readScalar(frontmatter[1], "description");

    if (!name) {
      errors.push("SKILL.md: frontmatter is missing `name`");
    } else {
      if (!/^[a-z0-9]+(-[a-z0-9]+)*$/.test(name)) {
        errors.push(`SKILL.md: name must be kebab-case (found "${name}")`);
      }
      if (name !== "product-design") {
        errors.push(`SKILL.md: name must be "product-design" (found "${name}")`);
      }
    }

    if (!description) {
      errors.push("SKILL.md: frontmatter is missing `description`");
    } else if (description.length < 20) {
      warnings.push("SKILL.md: description is unusually short");
    }
  }

  const lineCount = skillText.split(/\r?\n/).length;
  if (lineCount > 400) {
    warnings.push(`SKILL.md is ${lineCount} lines; consider moving detail into references/`);
  }
}

// 3. Resources referenced from SKILL.md
if (skillText) {
  const resources = walk(skillRoot).filter((file) =>
    /\/(references|assets)\//.test(toPosix(file)),
  );

  for (const file of resources) {
    const relPath = toPosix(relative(skillRoot, file));
    if (!skillText.includes(relPath)) {
      errors.push(`resource not referenced from SKILL.md: ${relPath}`);
    }
  }
}

// 4 & 5. Local links and code fences across every Markdown file
const markdownFiles = walk(repoRoot).filter((file) => file.toLowerCase().endsWith(".md"));

for (const file of markdownFiles) {
  const text = readFileSync(file, "utf8");
  const fileName = label(file);

  const fenceLines = text.split(/\r?\n/).filter((line) => /^\s*```/.test(line));
  if (fenceLines.length % 2 !== 0) {
    errors.push(`${fileName}: unbalanced code fences (${fenceLines.length})`);
  }

  // Ignore fenced code blocks so example paths are not treated as links.
  const prose = text.replace(/```[\s\S]*?```/g, "");
  const linkPattern = /\[[^\]]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g;

  for (const match of prose.matchAll(linkPattern)) {
    let target = match[1].trim();

    if (/^(https?:|mailto:|tel:|#)/i.test(target)) continue;

    if (target.startsWith("<") && target.endsWith(">")) {
      target = target.slice(1, -1);
    }

    target = target.split("#")[0];
    if (!target) continue;

    let decoded = target;
    try {
      decoded = decodeURIComponent(target);
    } catch {
      warnings.push(`${fileName}: could not decode link target "${target}"`);
    }

    const resolved = resolve(dirname(file), decoded);
    if (!existsSync(resolved)) {
      errors.push(`${fileName}: broken local link -> ${match[1]}`);
    }
  }
}

// Report
for (const warning of warnings) {
  console.log(`  warning  ${warning}`);
}

if (errors.length > 0) {
  for (const error of errors) {
    console.error(`  error    ${error}`);
  }
  console.error(`\n✖ validation failed with ${errors.length} error(s)`);
  process.exit(1);
}

const skillFiles = walk(skillRoot).length;
console.log(
  `✔ product-design skill is valid (${skillFiles} skill files, ${markdownFiles.length} markdown files checked)`,
);
