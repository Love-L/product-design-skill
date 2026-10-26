#!/usr/bin/env bash
set -euo pipefail

target="${1:-dsh}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="$repo_root/skills/product-design"

if [ ! -d "$src" ]; then
  echo "Skill source not found: $src" >&2
  exit 1
fi

case "$target" in
  dsh)
    dest="$HOME/.dsh/skills/product-design"
    ;;
  claude)
    dest="$HOME/.claude/skills/product-design"
    ;;
  project)
    project="${2:-}"
    if [ -z "$project" ]; then
      echo "usage: $0 project <path>" >&2
      exit 1
    fi
    project="$(cd "$project" && pwd)"
    dest="$project/.dsh/skills/product-design"
    ;;
  *)
    echo "usage: $0 [dsh|claude|project <path>]" >&2
    exit 1
    ;;
esac

case "$dest" in
  */product-design) ;;
  *)
    echo "Refusing to write to unexpected destination: $dest" >&2
    exit 1
    ;;
esac

mkdir -p "$(dirname "$dest")"
rm -rf "$dest"
cp -R "$src" "$dest"

echo ""
echo "Installed product-design -> $dest"
echo "Start a new agent session to load the skill."
