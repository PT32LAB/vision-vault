# NetworkTribes Vision Vault

## What This Is

The single source of truth for all content in the NetworkTribes project. This is an Obsidian-compatible collection of markdown files with structured frontmatter. It renders as a website at https://pt32lab.github.io via the `pt32lab.github.io` repo (which mounts this vault as a git submodule).

**You don't need to know how the rendering works.** Write good content following the conventions below, push to `main`, and the website rebuilds automatically.

**Content repo:** https://github.com/PT32LAB/vision-vault (this folder)
**Website repo:** https://github.com/PT32LAB/PT32LAB.github.io (likely available in `../pt32lab.github.io` folder)
**Live site:** https://pt32lab.github.io

## Vault Structure

```
vision-vault/
├── places/                ← Geographic analyses
│   └── bolivia/           ← BARK project content (main site)
│       ├── _index.en.md   ← Bolivia overview
│       ├── coroico-overview/   (4 notes)
│       ├── five-pillars/       (6 notes)
│       ├── economy-local/      (2 notes)
│       ├── communities/        (2 notes)
│       ├── resilience-assessment/ (4 notes)
│       ├── how-to-join/        (4 notes)
│       ├── reference/          (5 notes)
│       └── landing/            (4 notes)
├── vision/                ← Core cosmos concepts
│   ├── crisis-and-autonomy/
│   ├── governance/
│   ├── technology-sovereignty/
│   ├── regional-economy/
│   ├── human-potential/
│   └── culture-and-media/
├── tools/                 ← Specific technologies, methods
├── case-studies/          ← Real-world examples
├── references/            ← External resources
└── failure-museum/        ← What didn't work and why
```

**BARK content** lives under `places/bolivia/`. Conceptual frameworks that apply universally (not Bolivia-specific) go in `vision/`.

## How Changes Get Published

1. Edit markdown files in this repo (locally in Obsidian, or via GitHub)
2. Push to `main`
3. GitHub Actions triggers a rebuild of the website repo via `repository_dispatch`
4. The website rebuilds with latest vault content and deploys to GitHub Pages

**Requirement:** The vision-vault repo needs a `SITE_REBUILD_TOKEN` secret — a GitHub PAT with `repo` scope that can trigger the website repo's workflow.

## Filename Convention — i18n

Every content file uses a **locale suffix**:

```
welcome.en.md    ← English (primary)
welcome.es.md    ← Spanish
welcome.ru.md    ← Future language
```

- English (`.en.md`) is always written first
- Create `.es.md` / other locale files for translations
- If a locale file is missing, the website falls back to `.en.md`
- Wikilinks (`[[note-name]]`) resolve within the same locale context
- In Obsidian, both files appear side-by-side in the explorer — easy to see what's translated

**Adding a new language:** Create `.{lang}.md` files in the vault + add the locale to `astro.config.mjs` in the website repo.

## Frontmatter Schema

Every note MUST have this frontmatter:

```yaml
---
title: "Human-readable title"
slug: "url-path"                    # maps to /{lang}/{slug} on the website
layout: "prose"                     # prose | home | landing
description: "One-line summary"
type: concept | tool | practice | case-study | reference | place
cluster: crisis-autonomy | governance | technology-sovereignty | regional-economy | human-potential | culture-media
status: seed | research | tested | deployed
dimensions:                         # optional, for future visualization
  autonomy: 0.0-1.0
  tech_complexity: 0.0-1.0
  governance: 0.0-1.0
  economic: 0.0-1.0
  resilience: 0.0-1.0
  scalability: 0.0-1.0
tags: [array, of, freeform, tags]
related: [other-note-filename-without-locale-suffix]
geographic: global | latin-america | bolivia | southeast-asia | etc.
contributors: [github-handles]
date_created: YYYY-MM-DD
date_updated: YYYY-MM-DD
---
```

### Required fields
- title, slug, layout, description, type, cluster, status

### Optional but encouraged
- dimensions (all six), tags, related, geographic, contributors, hero

### The `slug` field

The `slug` determines the URL path on the website. Examples:

| File path | slug | Website URL |
|-----------|------|-------------|
| `places/bolivia/coroico-overview/welcome.en.md` | `""` (empty) | `/en/` |
| `places/bolivia/coroico-overview/the-vision.en.md` | `"vision"` | `/en/vision` |
| `places/bolivia/five-pillars/technopark.en.md` | `"pillars/technopark"` | `/en/pillars/technopark` |
| `places/bolivia/landing/invest.en.md` | `"landing/invest"` | `/landing/invest` |
| `vision/governance/comparative-models.en.md` | `"governance"` | `/en/governance` |

The vault folder structure and the URL structure are independent — `slug` is the bridge.

### The `hero` field (optional)

Adds a photo hero section at the top of the page:

```yaml
hero:
  image: /images/yungas/valley.jpg    # path in website's public/ folder
  label: "SHORT LABEL"               # green label above title
  headline: "Subtitle or tagline"    # body text below title in hero
  body: "Longer body text with <strong>HTML</strong> allowed"
  cta:                                # optional call-to-action buttons
    - text: "Write to Us"
      href: "mailto:contact@pt32lab.org"
      style: primary                  # primary (green) | secondary (text link)
```

When `hero` is present, the page title renders as the big headline in the hero. `headline` or `body` renders as subtitle text below it. Without `hero`, pages get a plain accent-band header.

**The `home` layout** is special: it uses `hero.headline` as the display-size text (e.g., "Soil and voltage.") instead of the page title.

### Dimension scoring guide

| Score | Meaning |
|-------|---------|
| 0.0-0.2 | Minimal relevance |
| 0.3-0.5 | Moderate relevance |
| 0.6-0.8 | Strong relevance |
| 0.9-1.0 | Defining characteristic |

When unsure, leave the dimension out rather than guessing.

## Content Guidelines

### Tone
- Pragmatic, not utopian. "Total pragmatism" is a core value.
- Evidence-based. Cite sources. Link to references.
- Honest about tradeoffs and limitations.
- Accessible but not dumbed down. Write for smart people without domain expertise.
- **No AI-sounding patterns:** no "Whether you," "Here's how," "Looking for," "Ready to?"

### Terminology
- **"Semi-autonomous"** not "off-grid" (we maintain grid connection as backup)
- **"Components"** not "pillars" (pillars reserved for values/principles)
- **"Initial spark"** for Drow, not "founder" or "co-founder"

### Structure
- Start with a one-paragraph summary that could stand alone
- Use `##` headings to organize sections — these become the TOC sidebar on the website
- Use `---` (horizontal rules) for visual section breaks — these render as green accent lines
- Include a "Limitations" or "Tradeoffs" section where relevant
- End with "Related" links using [[wikilinks]]
- Keep notes focused — one concept per note. If it's getting long, split it.

### Links
- **Internal:** Use Obsidian `[[wikilinks]]` — the build converts them to proper HTML links using the slug map
- **With display text:** `[[note-name|Display Text]]`
- **External:** Use standard markdown `[text](url)`
- **Also list** related notes in the `related:` frontmatter (this powers the knowledge graph)

### Images
- Reference images from the website's `public/` folder: `![alt](/images/yungas/valley.jpg)`
- Available photos: `valley.jpg`, `coroico-clouds.jpg`, `yungas-landscape.jpg`, `death-road.jpg`, `tocana-landscape.jpg`, `road-panorama.jpg`, `market.jpg`
- Images in markdown body render with rounded corners and margin

## Content Types

### Places (places/)
Geographic analyses. The Bolivia thesis. Data-heavy, honest about downsides. **BARK content lives here.**

### Concepts (vision/)
Big ideas and frameworks that apply universally — not tied to one place. "Why power acts as a memetic virus." "Comparative governance models."

### Tools (tools/)
Specific, actionable things. "LoRa mesh networking." "Sociocracy 3.0 process." Practical, with enough detail to evaluate and implement.

### Case Studies (case-studies/)
Real-world examples. Factual, analytical, lessons-focused.

### References (references/)
Curated external resources. Brief annotation of why each matters.

### Failure Museum (failure-museum/)
What didn't work and why. Every failure note must have a "Lessons" section.

## Content Ingestion Workflow

This is the primary job of agents in this repo. A human may drop a raw URL, a video link, a photo of a business card, a screenshot of an article, or a description of something they encountered. The agent's job is to evaluate it, route it, and either create a vault note or ask the minimum questions needed to do so.

### Step 1 — Create a board task first

Before writing any content, create a task file in `.polyphony/board/todo/` so other agents and humans see the work is claimed.

Task filename convention: `{CLUSTER-ABBR}-{NNN}.md` (e.g., `TOOL-003.md`, `REF-007.md`, `BARK-012.md`).

```yaml
---
id: BARK-012
title: Evaluate: [brief description of raw input]
priority: 2
labels: [ingestion, {content-type}]
created_at: YYYY-MM-DDTHH:MM:SSZ
updated_at: YYYY-MM-DDTHH:MM:SSZ
---

Source: [URL or description of raw input]
Action: Evaluate and route to vault
```

Then move it to `in-progress/` and commit — follow the full board protocol from the board-management-skill.

### Step 2 — Evaluate the input

Ask yourself these questions in order:

**Is it relevant to this project?**
The project clusters are: crisis-autonomy, governance, technology-sovereignty, regional-economy, human-potential, culture-media. If the content doesn't map to any cluster even loosely, flag it to the human and close the task as `cancelled/`.

**What type of content is it?**

| If the input is... | It likely belongs in... |
|--------------------|------------------------|
| A tool, technology, method, or product (URL, demo, business card for a tech company) | `tools/` |
| A real-world project or community doing something relevant | `case-studies/` |
| An article, paper, book, or dataset | `references/` |
| A geographic location or region worth analyzing | `places/` |
| A conceptual framework, philosophy, or governance model | `vision/` |
| Something that failed with lessons to draw | `failure-museum/` |
| Bolivia/BARK-specific content | `places/bolivia/` |

**Is it specific enough to write a note?**
A business card gives a name and maybe a URL — fetch the URL before writing. A video link needs a summary of what it shows. A photo of a tool needs identification. Gather what you need before drafting.

### Step 3 — Disambiguation protocol

**Proceed without asking** when:
- The content type and cluster are clear
- The target section is unambiguous
- You have enough information to write a `status: seed` note

**Ask exactly one focused question** when:
- The geographic scope is unclear (Bolivia-specific vs. universal?)
- The content could fit two clusters with equal weight
- A business card / contact represents a potential partner — is this a reference or a relationship to track?
- The human's intent is ambiguous (are they contributing this content, or just sharing for awareness?)

**Never ask multiple questions at once.** Ask the most blocking question, act on the answer, then ask the next if needed.

### Step 4 — Write the vault note

Follow the standard frontmatter schema. For ingested content:
- Always set `status: seed`
- Include the source URL in the note body under a `## Source` heading
- Add your agent identifier to `contributors:`
- For business cards / contacts: create a note in `references/` with the person's name, organization, relevance to the project, and contact details in the body

For video content, include a `## Summary` section with key points extracted from the video before any editorial content.

### Step 5 — Complete the board task

1. Append a completion report to the task file
2. Move it to `review/`
3. Commit with `board: {TASK-ID} in-progress -> review`

The human reviews, upgrades `status` from `seed` to `research` or higher when validated, and moves the task to `done/`.

### Ingestion ID prefixes

| Prefix | Use for |
|--------|---------|
| `BARK-` | Bolivia/BARK-specific content |
| `TOOL-` | New tool or technology |
| `REF-` | External reference or contact |
| `CASE-` | Case study |
| `VIS-` | Vision/concept content |
| `FAIL-` | Failure museum entries |

---

## How to Contribute

### Core team (Obsidian workflow)
1. Clone this repo, open in Obsidian
2. Edit markdown files, preview in Obsidian
3. Push to `main` — website rebuilds automatically
4. Use Obsidian Git plugin for sync

### Community contributors
1. Fork → edit → PR
2. Follow the frontmatter schema exactly
3. Set `status: seed` for new notes

### AI agents
- Follow the frontmatter schema exactly — the build will fail on invalid frontmatter
- Read existing notes in the same cluster before writing new ones (avoid duplication)
- Set `status: seed` for new notes — humans will review and upgrade
- Include your agent identifier in `contributors:`
- Don't modify other contributors' notes without explicit instruction
- **Test that your frontmatter parses** — the schema is validated by Zod in `src/content.config.ts`

## Quality Checklist

Before committing a new note:
- [ ] Filename has locale suffix (`.en.md`)
- [ ] Frontmatter has all required fields (title, slug, layout, description, type, cluster, status)
- [ ] `slug` maps to the desired URL path
- [ ] Dimensions are scored (or deliberately omitted)
- [ ] Description is a real one-liner (not just repeating the title)
- [ ] At least one `[[wikilink]]` to another vault note
- [ ] `related:` frontmatter lists connected notes
- [ ] Status is appropriate (seed for new, research for well-sourced)
- [ ] No broken external links

## What NOT to Do

- Don't claim things exist that don't (no land, no entity, no revenue yet)
- Don't use "off-grid" — say "semi-autonomous"
- Don't put speculative revenue projections on the investors page
- Don't add ayahuasca references outside the retreat page (legal risk)
- Don't duplicate slug values — each slug must be unique across the vault
- Don't use locale prefixes in slugs (wrong: `"en/vision"`, right: `"vision"`)
- Don't put BARK-specific content in `vision/` — it belongs in `places/bolivia/`

## Current State (April 2026)

34 vault notes seeded from the BARK hackathon site. Priority next steps:
1. Real Spanish translations for key pages (currently ES falls back to EN)
2. Dimension scoring for all notes (Phase 3 of implementation plan)
3. New cosmos-level content: tools/, case-studies/, failure-museum/
4. Additional places/ entries for comparison (Southeast Asia, etc.)
