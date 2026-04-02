# NetworkTribes Vision Vault

## What This Is

This is the shared knowledge base for the NetworkTribes project — a community building autonomous, horizontally organized communities resilient to nation-state crises. This vault is an Obsidian-compatible collection of markdown files that serves as the single source of truth for the project's vision, tools, practices, and case studies.

This content is rendered as an interactive website by a separate repo (pt32lab.github.io). You don't need to know how the rendering works. Just write good content following the conventions below.

## Vault Structure

```
vision-vault/
├── CLAUDE.md          ← You are here
├── vision/            ← Core vision clusters (from the vision board)
│   ├── _index.md      ← Overview: what is NetworkTribes
│   ├── crisis-and-autonomy/
│   ├── governance/
│   ├── technology-sovereignty/
│   ├── regional-economy/
│   ├── human-potential/
│   └── culture-and-media/
├── tools/             ← Specific technologies, methods, practices
├── case-studies/      ← Real-world examples and analyses
├── references/        ← External resources, reading lists
├── places/            ← Geographic analyses (Bolivia thesis, etc.)
└── failure-museum/    ← What didn't work and why
```

Each cluster folder under `vision/` contains an `_index.md` that serves as the cluster overview (displayed as the 1D landing block for that cluster).

## Frontmatter Schema

Every note MUST have this frontmatter:

```yaml
---
title: "Human-readable title"
description: "One-line summary (used in tooltips, search results, AI context)"
type: concept | tool | practice | case-study | reference | place
cluster: crisis-autonomy | governance | technology-sovereignty | regional-economy | human-potential | culture-media
status: seed | research | tested | deployed
dimensions:
  autonomy: 0.0-1.0      # Independence from state/corporate systems
  tech_complexity: 0.0-1.0 # Technical sophistication required
  governance: 0.0-1.0      # Relevance to governance/decision-making
  economic: 0.0-1.0        # Economic self-sufficiency contribution
  resilience: 0.0-1.0      # Crisis resilience contribution
  scalability: 0.0-1.0     # Works for 10 people? 100? 1000?
tags: [array, of, freeform, tags]
related: [other-note-filename-without-extension]
geographic: global | latin-america | bolivia | southeast-asia | etc.
contributors: [github-handles]
date_created: YYYY-MM-DD
date_updated: YYYY-MM-DD
---
```

### Required fields
- title, description, type, cluster, status

### Optional but encouraged
- dimensions (all six), tags, related, geographic, contributors

### Dimension scoring guide

Score each dimension 0.0 to 1.0:

| Score | Meaning |
|-------|---------|
| 0.0-0.2 | Minimal relevance or capability in this dimension |
| 0.3-0.5 | Moderate relevance |
| 0.6-0.8 | Strong relevance or capability |
| 0.9-1.0 | This is a defining characteristic |

When unsure, leave the dimension out rather than guessing. Better to have no score than a misleading one.

## Content Guidelines

### Tone
- Pragmatic, not utopian. "Total pragmatism" is a core value.
- Evidence-based. Cite sources. Link to references.
- Honest about tradeoffs and limitations. If something doesn't work, say so.
- Accessible but not dumbed down. Write for smart people who may not have domain expertise.

### Structure
- Start with a one-paragraph summary that could stand alone
- Use headers (##) to organize sections
- Include a "Limitations" or "Tradeoffs" section where relevant
- End with "Related" links to other vault notes (using [[wikilinks]])
- Keep notes focused — one concept per note. If it's getting long, split it.

### Links
- Use Obsidian [[wikilinks]] for internal connections
- Use standard markdown [text](url) for external links
- Also list related notes in the `related:` frontmatter (this powers the graph)

### Language
- Write in English for all content
- Discussions and brainstorming may happen in Russian but published notes are English
- If translating a concept from another language, include the original term

## Content Types

### Concepts (vision/)
Big ideas, frameworks, theories. "What is the ayllu governance system?" "Why power acts as a memetic virus." These are the nodes that define the intellectual landscape.

### Tools (tools/)
Specific, actionable things a community can use. "LoRa mesh networking." "Sociocracy 3.0 decision process." "Composting toilet systems." Practical, with enough detail to evaluate and implement.

### Case Studies (case-studies/)
Real-world examples. "Mondragon cooperatives — 70 years of worker ownership." "Why commune X failed after 3 years." Factual, analytical, lessons-focused.

### References (references/)
Curated external resources. Books, papers, websites, organizations. Brief annotation of why each matters.

### Places (places/)
Geographic analyses. The Bolivia thesis. Southeast Asia options. Climate data, legal frameworks, cost analysis. Data-heavy, honest about downsides.

### Failure Museum (failure-museum/)
What didn't work and why. This is one of the most valuable sections. Analyzing failed intentional communities, collapsed cooperatives, governance experiments that imploded. Every failure note must have a "Lessons" section.

## How to Contribute

### If you're a core team member
- Clone this repo, open in Obsidian, edit, push
- Use Obsidian Git plugin for sync
- Exclude `.obsidian/workspace.json` from commits (add to .gitignore)

### If you're a community contributor
- Fork → edit → PR
- Or use the browser-based editor (if Decap CMS is set up)

### If you're an AI agent
- Follow the frontmatter schema exactly
- Read existing notes in the same cluster before writing new ones (avoid duplication)
- Set `status: seed` for new notes — humans will review and upgrade
- Include your agent identifier in `contributors:`
- Don't modify other contributors' notes without explicit instruction
- When in doubt, create a new note rather than editing an existing one

## Quality Checklist

Before committing a new note:
- [ ] Frontmatter has all required fields
- [ ] Dimensions are scored (or deliberately omitted)
- [ ] Description is a real one-liner (not just repeating the title)
- [ ] At least one [[wikilink]] to another vault note
- [ ] Status is appropriate (seed for new, research for well-sourced)
- [ ] No broken links
- [ ] Spell-checked

## Current State

The vault is being seeded. Priority content:
1. Vision cluster overviews (_index.md for each cluster)
2. Bolivia thesis (places/bolivia/)
3. Key governance models (ayllu, sociocracy, Mondragon)
4. Technology sovereignty basics (mesh networking, local AI, off-grid compute)
5. First failure museum entries
