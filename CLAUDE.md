# Steelman Skill

Claude Code skill for strengthening ideas, specs, and strategies. Produces concrete recommendations to reinforce weak points, reframe positioning, and find untapped advantages.

## Usage

Invoke with `/steelman` in Claude Code. The skill is auto-discovered from `.claude/skills/steelman/SKILL.md`.

```
/steelman path/to/spec.md
/steelman path/to/spec.md --from-red-team
/steelman path/to/spec.md --save
```

## Syncing with Workspace

If you also use this skill inside a larger claude-workspace monorepo:

```bash
./sync.sh pull   # Copy FROM workspace INTO this repo
./sync.sh push   # Copy FROM this repo INTO workspace
```

Set `WORKSPACE_ROOT` if your workspace is not at `~/claude`.
