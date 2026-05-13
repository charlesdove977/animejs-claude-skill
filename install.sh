#!/usr/bin/env bash
# Install animejs Claude Code skill (global or project scope).
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/charlesdove977/animejs-claude-skill/main/install.sh | bash
#   ./install.sh                   # interactive
#   ./install.sh --global          # non-interactive, install to ~/.claude/skills
#   ./install.sh --project [path]  # non-interactive, install to <path>/.claude/skills (default: cwd)

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/charlesdove977/animejs-claude-skill/main"
SKILL_NAME="animejs"
FILES=(
  "skill/SKILL.md"
  "skill/references/api-reference.md"
  "skill/references/examples.md"
)

SCOPE=""
TARGET_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global)  SCOPE="global"; shift ;;
    --project) SCOPE="project"; shift; [[ $# -gt 0 && "$1" != --* ]] && TARGET_DIR="$1" && shift || TARGET_DIR="$(pwd)" ;;
    -h|--help)
      sed -n '2,8p' "$0" 2>/dev/null || echo "See https://github.com/charlesdove977/animejs-claude-skill"
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

if [[ -z "$SCOPE" ]]; then
  # Interactive: read from /dev/tty so it works under `curl | bash`.
  if [[ ! -t 0 && ! -r /dev/tty ]]; then
    echo "No TTY available for prompt. Re-run with --global or --project [path]." >&2
    exit 1
  fi
  echo ""
  echo "Where do you want to install the animejs skill?"
  echo "  1) Global    → ~/.claude/skills/${SKILL_NAME}   (available in every project)"
  echo "  2) Project   → \$PWD/.claude/skills/${SKILL_NAME} (only this repo)"
  echo ""
  printf "Choose [1/2]: "
  if [[ -r /dev/tty ]]; then read -r choice < /dev/tty; else read -r choice; fi
  case "$choice" in
    1) SCOPE="global" ;;
    2) SCOPE="project"; TARGET_DIR="$(pwd)" ;;
    *) echo "Invalid choice." >&2; exit 1 ;;
  esac
fi

case "$SCOPE" in
  global)  DEST="$HOME/.claude/skills/${SKILL_NAME}" ;;
  project) DEST="${TARGET_DIR:-$(pwd)}/.claude/skills/${SKILL_NAME}" ;;
esac

echo "Installing to: $DEST"
mkdir -p "$DEST/references"

# If running from a clone, copy local files. Otherwise curl from GitHub raw.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || true)"
if [[ -n "$SCRIPT_DIR" && -f "$SCRIPT_DIR/skill/SKILL.md" ]]; then
  cp "$SCRIPT_DIR/skill/SKILL.md" "$DEST/SKILL.md"
  cp "$SCRIPT_DIR/skill/references/api-reference.md" "$DEST/references/api-reference.md"
  cp "$SCRIPT_DIR/skill/references/examples.md"      "$DEST/references/examples.md"
else
  for f in "${FILES[@]}"; do
    REL="${f#skill/}"
    curl -fsSL "$REPO_RAW/$f" -o "$DEST/$REL"
  done
fi

echo ""
echo "Installed animejs skill at: $DEST"
echo "Restart Claude Code (or open a new session) to pick up the skill."
echo "Trigger it by mentioning anime.js, timeline animation, stagger, SVG morphing, etc."
