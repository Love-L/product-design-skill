#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
out="$root/docs/assets"
mkdir -p "$out"

chrome="${CHROME:-}"
if [ -z "$chrome" ]; then
  candidates=(
    "google-chrome"
    "google-chrome-stable"
    "chromium"
    "chromium-browser"
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
  )
  for candidate in "${candidates[@]}"; do
    if command -v "$candidate" >/dev/null 2>&1; then
      chrome="$(command -v "$candidate")"
      break
    fi
    if [ -x "$candidate" ]; then
      chrome="$candidate"
      break
    fi
  done
fi

if [ -z "$chrome" ]; then
  echo "Chrome, Chromium, or Edge not found. Set CHROME=/path/to/browser." >&2
  exit 1
fi

render() {
  local name="$1"
  local width="$2"
  local height="$3"

  "$chrome" \
    --headless=new \
    --disable-gpu \
    --hide-scrollbars \
    --force-device-scale-factor=2 \
    --window-size="${width},${height}" \
    --screenshot="$out/$name.png" \
    "file://$root/docs/diagrams/$name.html" >/dev/null 2>&1

  if [ ! -f "$out/$name.png" ]; then
    echo "Failed to render $name" >&2
    exit 1
  fi

  echo "Rendered docs/assets/$name.png"
}

render hero 1200 620
render five-lenses 1200 1020
render workflow 1200 880
render architecture 1200 880
render session 1200 760

echo ""
echo "Done. Commit docs/assets/*.png if the diagrams changed."
