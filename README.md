# animejs-claude-skill

A [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) skill that teaches Claude the [Anime.js v4](https://animejs.com) API — timelines, staggers, SVG morphs, scroll triggers, draggables, springs, motion paths, keyframes.

When the skill is installed, Claude Code auto-activates it on prompts like `"animate this with anime.js"`, `"add a stagger timeline"`, `"SVG morph"`, `"scroll-driven animation"`, etc.

## Install

### One-liner (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/charlesdove977/animejs-claude-skill/main/install.sh | bash
```

The script asks where to install:

- **Global** → `~/.claude/skills/animejs` (available in every project)
- **Project** → `$PWD/.claude/skills/animejs` (only the current repo)

### Non-interactive

```bash
# Global install
curl -fsSL https://raw.githubusercontent.com/charlesdove977/animejs-claude-skill/main/install.sh | bash -s -- --global

# Project install (current directory)
curl -fsSL https://raw.githubusercontent.com/charlesdove977/animejs-claude-skill/main/install.sh | bash -s -- --project

# Project install (specific path)
curl -fsSL https://raw.githubusercontent.com/charlesdove977/animejs-claude-skill/main/install.sh | bash -s -- --project /path/to/project
```

### Manual clone

```bash
git clone https://github.com/charlesdove977/animejs-claude-skill.git
cd animejs-claude-skill
./install.sh
```

### Fully manual

Copy `skill/SKILL.md` and `skill/references/` into one of:

- `~/.claude/skills/animejs/` (global)
- `<project>/.claude/skills/animejs/` (project-scoped)

## Uninstall

```bash
# Global
rm -rf ~/.claude/skills/animejs

# Project
rm -rf .claude/skills/animejs
```

## What's in the skill

```
skill/
├── SKILL.md                       # entry point, trigger description, install + quickstart
└── references/
    ├── api-reference.md           # full v4 API surface
    └── examples.md                # copy-paste recipes (timelines, staggers, SVG, etc.)
```

`SKILL.md` loads when triggered. `references/*.md` loads on demand to keep the context window lean.

## Triggers

The skill activates when you say things like:

- "animate elements with anime.js"
- "timeline animation"
- "stagger animation"
- "SVG morphing"
- "motion path"
- "scroll animation"
- "draggable"
- "spring animation"
- "keyframe animation"

## Targets Anime.js v4

The v4 API is a breaking change from v3. Old tutorials referencing `anime({ ... })` as the default export will not work. This skill covers the v4 named exports (`animate`, `createTimeline`, `stagger`, `svg.morphTo`, etc.).

Library: <https://github.com/juliangarnier/anime>

## License

MIT — see [LICENSE](LICENSE).

The Anime.js library itself is MIT-licensed by Julian Garnier. This repo only redistributes a knowledge-skill bundle (markdown), not the library source.
