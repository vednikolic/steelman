# Steelman

<div align="center">

<img src="https://img.shields.io/badge/LLM--agnostic-works%20with%20any%20model-gray?style=for-the-badge" />
<img src="https://img.shields.io/badge/lenses-6%20analytical-2563EB?style=for-the-badge" />
<img src="https://img.shields.io/badge/eval%20score-96.55%25-10B981?style=for-the-badge" />
<img src="https://img.shields.io/badge/license-MIT-blue?style=for-the-badge" />

</div>

<br />

The blue-team to [Red Team](https://github.com/vednikolic/red-team)'s red-team. Give it a document, and it produces concrete recommendations to reinforce weak points, reframe positioning, and find untapped advantages.

It does not rewrite your document. It offers specific suggestions you can adopt, adapt, or ignore.

```
     Red Team finds the cracks.           Steelman fills them with concrete.

     +------------------+                 +------------------+
     |  BLOCKING (2)    |                 |  Strengthened    |
     |  HIGH (4)        |  ------------>  |  Reframed        |
     |  MEDIUM (3)      |   --from-       |  Evidenced       |
     |  LOW (1)         |   red-team      |  Moat expanded   |
     +------------------+                 +------------------+
```

## What It Does

Steelman analyzes your input through six lenses:

1. **Strengthen the Weakest Argument** -- find soft points and recommend how to reinforce them
2. **Reframe Positioning** -- identify the strongest narrative angle for your audience
3. **Evidence and Precedent** -- find data and case studies that support your approach
4. **Expand the Moat** -- identify what makes this harder to replicate or compete with
5. **Simplify** -- cut what weakens the core, flag overreach
6. **Second-Order Effects** -- map compounding advantages and adjacent opportunities

Each recommendation is rated High / Medium / Low impact so you know where to focus.

## Quick Start

### With Claude Code

```bash
git clone https://github.com/vednikolic/steelman.git
cd steelman
claude
```

Claude Code automatically discovers skills in `.claude/skills/`. Then:

```
/steelman path/to/your-spec.md
```

### With Any LLM

Copy the content of [`.claude/skills/steelman/SKILL.md`](.claude/skills/steelman/SKILL.md) and use it as a system prompt or custom instruction. Then provide your document or idea as the user message.

The skill file is self-contained. It works with any LLM that can follow structured instructions.

### With Other AI Coding Tools

| Tool | Install |
|------|---------|
| ChatGPT | Paste `SKILL.md` content into a Custom GPT's instructions or a project's custom instructions |
| Cursor | Copy `SKILL.md` content into `.cursor/rules/steelman.md` |
| Windsurf | Copy `SKILL.md` content into `.windsurfrules` |
| Cline / Roo | Add `SKILL.md` path to your custom instructions |
| Gemini CLI | Copy `SKILL.md` into `.gemini/instructions/steelman.md` |

### Flags

| Flag | What it does |
|------|-------------|
| `--save` | Save the analysis to a file |
| `--from-red-team` | Use a prior red-team analysis as the weakness map, then target those findings |

### Example

```
/steelman docs/mvp-spec.md --save
```

This reads `docs/mvp-spec.md`, runs all six lenses, and saves the analysis alongside the input file.

## How It Works

For short inputs (under 500 words), the skill runs all lenses sequentially. For longer documents (full specs, strategy docs), it dispatches parallel agents, one per lens, then synthesizes the results and deduplicates overlapping recommendations.

The skill adapts its approach based on input type:
- **Early-stage ideas**: Prioritizes positioning and moat analysis
- **Detailed specs/PRDs**: Prioritizes strengthening weak arguments and adding evidence
- **Strategy docs**: Prioritizes moat expansion and second-order effects

## Output Format

```
## Steelman Analysis: [topic]

### Summary
[Overall assessment and highest-leverage improvements]

### Top Recommendations
[Ranked by impact across all lenses]

### Lens: [Name]
- Recommendation: [specific, actionable change]
  Rationale: [why this strengthens the idea]

### Lenses Skipped
- [Lens]: [reason not applicable]
```

## Pairing with Red-Team

Steelman pairs well with adversarial analysis. If you have a red-team report (from any source), pass it in:

```
/steelman docs/mvp-spec.md --from-red-team
```

The output will include a section mapping each critical red-team finding to the recommendation that addresses it.

## Syncing with a Workspace

If you use this skill inside a larger monorepo alongside other skills:

```bash
# Pull latest from workspace into this repo
./sync.sh pull

# Push changes from this repo back to workspace
./sync.sh push
```

Set `WORKSPACE_ROOT` if your workspace is not at `~/claude`.

## Author

Ved Nikolic ([vednikolic](https://github.com/vednikolic)) -- ved@vednikolic.com

## License

MIT
