#!/bin/bash
# Sync between standalone steelman repo and the claude-workspace monorepo.
#
# Usage:
#   ./sync.sh pull   # Copy FROM workspace INTO this repo
#   ./sync.sh push   # Copy FROM this repo INTO workspace
#
# Set WORKSPACE_ROOT if your workspace is not at ~/claude:
#   WORKSPACE_ROOT=~/my-workspace ./sync.sh pull

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE_ROOT="${WORKSPACE_ROOT:-$HOME/claude}"
WORKSPACE_SKILL="$WORKSPACE_ROOT/.claude/skills/steelman/SKILL.md"

if [ ! -d "$WORKSPACE_ROOT" ]; then
    echo "ERROR: Workspace not found at $WORKSPACE_ROOT"
    echo "Set WORKSPACE_ROOT to your claude-workspace location."
    exit 1
fi

case "${1:-}" in
    pull)
        echo "Pulling from workspace -> standalone repo"
        cp "$WORKSPACE_SKILL" "$SCRIPT_DIR/.claude/skills/steelman/SKILL.md"
        echo "Done. Review changes with: git diff"
        ;;
    push)
        echo "Pushing from standalone repo -> workspace"
        cp "$SCRIPT_DIR/.claude/skills/steelman/SKILL.md" "$WORKSPACE_SKILL"
        echo "Done. Review changes in workspace with: cd $WORKSPACE_ROOT && git diff"
        ;;
    *)
        echo "Usage: ./sync.sh [pull|push]"
        echo "  pull  Copy from workspace into this repo"
        echo "  push  Copy from this repo into workspace"
        exit 1
        ;;
esac
