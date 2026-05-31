---
title: "Land Selection Framework"
slug: "tools/land-selection-framework"
layout: "prose"
description: "An open-source web tool that filters candidate regions for a long-horizon settlement across eight resilience dimensions (climate, water, soil, conflict, solar, forest, networks, density) — and deliberately refuses to score or rank them."
type: tool
cluster: crisis-autonomy
status: seed
dimensions:
  autonomy: 0.7
  tech_complexity: 0.5
  governance: 0.2
  economic: 0.3
  resilience: 0.9
  scalability: 0.4
tags: [land, siting, gis, resilience, climate-adaptation, water, soil, open-source, ecovillage, planning]
related: [animate-intelligence, community-weaving-toolkit, low-tech-magazine]
geographic: global
contributors: [claude-opus]
date_created: 2026-05-31
date_updated: 2026-05-31
---

The Land Selection Framework is an open-source, non-commercial web app (built by Gustaf Palm / "Islands of Coherence") that helps a community decide *where* to settle for the long haul — a 50–100 year horizon — by comparing candidate regions across eight resilience dimensions. Its defining design choice is restraint: **"the framework filters, never scores, ranks, or recommends."** You set threshold sliders for each dimension; regions that clear your thresholds remain visible, in their native units, and the value judgement stays with you. It is the operational companion to the *Land Selection Framework* and *Tools for Living Together* essays in [[animate-intelligence]].

## The eight dimensions

1. **Climate trajectory** — projected temperatures ~2041–2060 (will the place still be liveable?)
2. **Water stress** — demand-to-supply ratio out to 2050
3. **Soil organic carbon** — proxy for regenerative / food-growing potential
4. **Forest cover trajectory** — 20-year directional trend (reforesting vs. losing cover)
5. **Solar PV potential** — kWh output capacity for energy autonomy
6. **Conflict proximity** — documented violence within recent years
7. **Regenerative network density** — nearby ecovillages/farms (~100 km) for mutual support
8. **Population density** — persons/km² through 2030

## How it works

- **Inputs:** sliders set minimum/maximum acceptable thresholds per dimension.
- **Output:** an interactive matrix — regions as rows, the eight criteria as columns — shown in raw units with **no composite score**. Users build custom shortlists and comparison tables.
- **Coverage today:** **20 candidate regions — 10 in Europe, 10 in North America** (e.g. Alentejo, Connemara, Transylvania). Full V1 was slated for release before June 2026, with a "deeper" page documenting methodology and ethics.

## Data sources

| Layer | Source |
|-------|--------|
| Forest cover trajectory | Hansen / Global Forest Watch |
| Water stress (sub-basins, 2050) | WRI Aqueduct |
| Conflict event density | UCDP (Uppsala Conflict Data Program) |
| Intentional-community sites | OpenStreetMap |
| Climate, soil, solar | public projection datasets (cited with vintage dates) |

Exports are designed to drop into **QGIS** and **Jupyter** for further analysis.

## Why it matters for the project

The framework is a near-direct articulation of what a rigorous siting analysis for a semi-autonomous Coroico community would need — and its *show-the-axes, let-the-community-judge* stance is exactly the vault's honest-about-tradeoffs posture. Concretely:

1. **A ready methodology to replicate.** The eight dimensions + the named open datasets are a reusable recipe. Even where the live tool can't help (see below), the *method* transfers directly.
2. **Pairs with the human layer.** Picking land is half the problem; [[community-weaving-toolkit]] and [[sociocracy-3-0]] cover the other half — who decides, and whether the group coheres before it commits to a place.
3. **Honest framing.** "Filter, don't rank" resists the false precision of a single livability score — useful tone calibration for any BARK resilience assessment.

## Limitations / tradeoffs

- **It does not cover Latin America.** Current coverage is Europe + North America only, so it is **not usable as-is for Coroico or Bolivia.** Its value to BARK is as a *methodology template* to re-run with regional datasets, not as a map to read off.
- **Early-stage and single-maintainer.** Open-source but small; V1 was still landing as of mid-2026. Treat data vintages and thresholds as provisional.
- **Filtering hides interactions.** Eight independent sliders won't capture how dimensions compound (e.g. water stress × conflict). It narrows a longlist; it does not replace ground truth, local knowledge, or legal/tenure due diligence — none of which it models.
- **Resolution.** Region-level granularity is for longlisting, not for choosing a specific parcel.

## Source

- Live tool: https://land-selection-framework.vercel.app/
- Methodology essay: https://animateintelligence.substack.com/p/land-selection-framework
- Maintainer: Gustaf Palm — gustaf@islands-of-coherence.com (open-source, non-commercial)
- Surfaced via: [[animate-intelligence]]

## Related

- [[animate-intelligence]] — the publication and essays behind the tool
- [[community-weaving-toolkit]] — the relational/governance half of "where + how to settle"
- [[sociocracy-3-0]] — how the settling group could make the decision
- [[low-tech-magazine]] — appropriate-technology sourcing once a site is chosen
