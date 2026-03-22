---
name: steelman
description: "Strengthen an idea, spec, or strategy by reinforcing weak points, reframing positioning, and finding untapped advantages. Can work standalone or against red-team output. Produces recommendations, not revisions."
argument-hint: [file path or topic] [--save] [--from-red-team]
---

# Steelman -- Strengthen and Fortify

Analyze an idea, spec, or strategy and produce concrete recommendations to make it stronger. Does not revise the original. Recommendations are offered for the user to adopt or discard.

Works standalone. Does not require any other tool or skill. The optional `--from-red-team` flag pairs with a prior adversarial analysis (from any source) but is not needed.

## Input Resolution

Determine the input from what the user provides:

1. If the user provides a file path, read that file as the primary input
2. If the user provides `--from-red-team`, look for the most recent red-team or adversarial analysis in conversation context and use its findings as the weakness map. If a red-team report file path is provided, read that instead
3. If the user provides a topic or keyword (not a path), use it to focus the analysis
4. If no input is specified, analyze the most recent idea or spec discussed in conversation

When `--from-red-team` is active, the steelman lenses specifically target the critical findings and weaknesses identified in the red-team output. Any structured adversarial analysis works here, regardless of the tool that produced it.

## Analytical Lenses

Apply all lenses by default. Drop any that are clearly not applicable. State which lenses you are skipping and why.

### 1. Strengthen the Weakest Argument
- Identify the softest points in the idea
- For each, recommend how to reinforce it with better logic, evidence, or design
- If a weakness cannot be fixed, recommend how to contain or acknowledge it
- Example: "The retention claim lacks supporting data. Recommend adding cohort analysis from the beta: 68% of week-1 users returned in week 4, compared to 45% industry average for similar tools."

### 2. Reframe Positioning
- Identify the strongest narrative angle for this idea
- Recommend a framing that makes the value proposition clearer to each audience (users, investors, engineers)
- Example: "Reframe from 'photo backup app' to 'family memory infrastructure' to differentiate from iCloud/Google Photos commodity storage and justify the premium tier."

### 3. Evidence and Precedent
- Find data, research, or case studies that support this approach
- Identify successful precedents for similar ideas and extract the relevant lessons
- Recommend where intuition-based claims can be replaced with cited numbers
- Example: "The 'users want privacy' claim is unsupported. Recommend citing the 2024 Pew Research survey showing 79% of US adults are concerned about how companies use their data, directly backing the E2E encryption decision."

### 4. Expand the Moat
- Identify what makes this harder to replicate or compete with
- Recommend specific network effects, data advantages, or switching costs to build in
- Specify what would make someone choose this over alternatives in 2 years

### 5. Simplify
- Identify what can be cut to make the core stronger
- Flag where the idea is trying to do too much
- Recommend the minimum version that still captures the key value

### 6. Second-Order Effects
- Identify positive outcomes the author has not articulated
- Map compounding advantages that emerge over time
- List adjacent opportunities this unlocks

## Execution

**Complexity assessment:** Before starting analysis, assess input complexity:
- **Short** (conversational idea, < 500 words): Run lenses sequentially
- **Long** (full spec, design doc, strategy, or paired with red-team output): If your environment supports parallel execution (subagents, threads, or multiple calls), run one task per applicable lens, then synthesize. Otherwise, run sequentially.

**For parallel execution:**
- **Per-lens input**: Each task receives: (1) the full input document, (2) red-team findings if `--from-red-team` is active, (3) the instructions for its assigned lens only, and (4) the Impact Calibration criteria.
- **Per-lens output**: Each task returns a list of 1-3 recommendations in this format: `Recommendation: [text] | Impact: [H/M/L] | Rationale: [text]`.
- **Synthesis**: After all tasks complete, merge their recommendations into the output format below. Deduplicate overlapping recommendations (keep the stronger version). Rank all recommendations by impact (High first) to produce the Top Recommendations list. Flag any contradictions between lenses (see Anti-Pattern #3).

**Input type adaptation:**
- **Early-stage idea** (no spec, just a concept): Prioritize Lens 2 (Reframe Positioning) and Lens 4 (Expand the Moat). Skip Lens 3 (Evidence) if there is no existing data to evaluate. Focus recommendations on sharpening the core value proposition before details exist.
- **Detailed spec or PRD** (sections, metrics, timelines): Apply all 6 lenses. Prioritize Lens 1 (Strengthen Weakest Argument) and Lens 3 (Evidence). Recommendations should reference specific sections of the document.
- **Strategy doc** (vision, pillars, roadmap): Prioritize Lens 4 (Expand the Moat) and Lens 6 (Second-Order Effects). Focus on long-term compounding advantages and competitive defensibility.

## Impact Calibration

Rate each recommendation using these criteria:

- **High**: Changes core positioning, architecture, or value proposition. Failing to adopt this recommendation leaves a critical gap. Example: repositioning the product category.
- **Medium**: Strengthens a specific area or supporting argument. Improves quality but the idea survives without it. Example: adding data to back a retention claim.
- **Low**: Polish, wording, or minor clarification. Improves presentation without changing substance. Example: tightening a tagline.

## Output Format

```
## Steelman Analysis: [topic/title]

### Summary
[2-3 sentences: overall assessment of the idea's core strength and highest-leverage improvements]

### Top Recommendations
[Ranked list of the highest-impact recommendations across all lenses]

### Lens: [Name]
**Impact: [High/Medium/Low]**
- **Recommendation:** [specific, actionable recommendation]
  **Rationale:** [why this strengthens the idea]

[Repeat for each applicable lens]

### Lenses Skipped
- [Lens name]: [reason not applicable]

### Addressing Red-Team Findings
[Only if --from-red-team was used. Maps each critical red-team finding to the recommendation that addresses it, or flags findings that remain unresolved.]
```

## Saving Output

If `--save` is specified:
- Determine the appropriate location based on context:
  - If analyzing a project file, save alongside it or in the project's docs folder
  - If paired with a saved red-team report, save in the same directory
  - Default fallback: `./YYYY-MM-DD-steelman-<topic>.md` (current directory)
- State where the file was saved

## Principles

- Recommendations, not revisions. Never rewrite the original. Offer specific suggestions the user can adopt, adapt, or ignore.
- Be concrete. "Make the positioning stronger" is useless. "Reframe from 'photo backup' to 'family memory infrastructure' to differentiate from iCloud/Google Photos" is useful.
- Do not invent strengths. If an area is genuinely weak and you cannot find a way to strengthen it, say so.
- When working from red-team output, prioritize addressing critical and high-severity findings first.
- Calibrate impact honestly. Not every recommendation is high-impact.

## Edge Cases

- **Input is too vague to analyze** (e.g., "make my app better"): Ask the user one clarifying question to identify the specific idea, feature, or decision to steelman. Do not proceed with a generic analysis.
- **The idea has no obvious weaknesses**: Focus lenses 2 (Reframe Positioning), 4 (Expand the Moat), and 6 (Second-Order Effects). A strong idea still benefits from better framing, deeper moats, and articulation of compounding advantages.
- **The idea is genuinely flawed beyond repair**: State this directly in the Summary. Focus on Lens 1 (Strengthen the Weakest Argument) to recommend the smallest set of changes that would make the core viable. If no fix exists within the current scope, say so and recommend pivoting or scoping down.

## Anti-Patterns

Avoid these common steelman mistakes:

1. **Inventing strengths that do not exist.** If the idea has a genuine fatal flaw, do not fabricate advantages to paper over it. Acknowledge the flaw and recommend the smallest change that would neutralize it, or state that it cannot be fixed.
2. **Generic encouragement without specifics.** "This has a lot of potential" or "The team should lean into the vision" is not a recommendation. Every recommendation must name a specific change with enough detail that someone could act on it without further clarification.
3. **Contradictory recommendations across lenses.** If Lens 5 (Simplify) recommends cutting to a single core feature while Lens 4 (Expand the Moat) recommends adding three capabilities, the synthesis must resolve the tension. Flag contradictions in the Top Recommendations section and state which direction to prioritize.
4. **Ignoring the audience.** A steelman for an investor pitch differs from one for an engineering spec. Tailor recommendations to what the target audience values. If the audience is unclear, state your assumption explicitly.
