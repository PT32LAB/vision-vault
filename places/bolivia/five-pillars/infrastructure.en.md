---
title: "Infrastructure"
slug: "pillars/infrastructure"
layout: "prose"
description: "Semi-autonomous systems for energy, water, food, and connectivity — BARK's physical foundation"
type: place
cluster: regional-economy
status: research
dimensions:
  autonomy: 0.95
  tech_complexity: 0.7
  governance: 0.4
  economic: 0.5
  resilience: 0.95
  scalability: 0.6
tags: [infrastructure, energy, water, food, connectivity, solar, micro-hydro, permaculture, starlink]
related: [technopark, trading-house, overview]
geographic: bolivia
date_created: 2026-04-03
date_updated: 2026-04-05
---

# Infrastructure

**The physical foundation for semi-autonomous living.**

Infrastructure is what separates a vision from a viable community. BARK's systems are designed for semi-autonomy — capable of operating independently when needed, while normally integrated with regional grids and supply chains. Every system below is specified with real data, not aspirational hand-waving.

## Energy

BARK's energy strategy uses a dual solar-hydro approach that exploits the complementary nature of the Yungas climate. The region receives **3.5--4.5 kWh/m²/day** of solar irradiance according to the [Global Solar Atlas](https://globalsolaratlas.info/detail?c=-16.18,-67.73,11), which is good but not exceptional — the cloud forest means more overcast days than the Altiplano above. This is precisely why solar alone is insufficient.

Micro-hydro compensates for cloud cover. Mountain streams within 500 meters of any viable building site in the Coroico area provide consistent small-scale hydroelectric potential. The steep terrain (200--400m elevation drop over short distances) creates ideal conditions for 1--100 kW run-of-river systems. During the wet season (November--March), when solar output drops due to cloud cover, stream flow is at its peak — the two sources are naturally counter-cyclical.

Grid connection is maintained as backup and for net metering revenue. Bolivia's electrical grid reaches Coroico, and excess generation from solar and hydro can be sold back under Bolivia's net metering regulations. This turns infrastructure investment into a revenue stream during periods of surplus generation. Combined with Bolivia's $325M solar electrification program, the regulatory environment is favorable for renewable energy deployment.

Smart load management completes the system: priority circuits for critical loads (water pumps, communications, medical equipment, food storage), graceful degradation during low-generation periods, and battery storage sized for 48--72 hours of autonomy for essential systems.

> **Sources:** Solar irradiance data from [Global Solar Atlas](https://globalsolaratlas.info/) (World Bank / ESMAP). Micro-hydro potential based on Yungas terrain surveys and Bolivia's Programa de Electrificacion Rural.

![Energy flow diagram](/images/diagrams/energy-flow.svg)

*BARK energy system: sources, storage, distribution, and revenue loop.*

## Water

The Coroico area receives **1,100--1,300mm of annual rainfall**, with a distinct wet season from November to March providing the bulk of precipitation. Beyond rainfall, the Yungas are rich in surface water: the Coroico River and numerous mountain springs provide reliable flow year-round. Multiple streams suitable for both water supply and micro-hydro generation are within walking distance of any reasonable building site.

BARK's water system is designed in three tiers:

1. **Primary supply** — Gravity-fed spring capture. Mountain springs are tapped upstream and piped downhill without pumping, eliminating energy costs for the main water supply.
2. **Secondary supply** — Rainwater harvesting from building roofs, collected in ferrocement or polyethylene tanks sized for dry-season bridging.
3. **Purification** — Multi-stage treatment: sediment filtration, followed by slow sand filtration (a proven appropriate technology), then UV treatment for pathogen elimination, with continuous quality monitoring via low-cost turbidity and pH sensors.

Bio-sand filters — effective household-level units at approximately **$50 per unit** in materials — provide point-of-use backup and are deployable to surrounding communities as well.

**Greywater recycling:** Greywater from sinks, showers, and laundry is separated from blackwater and treated through constructed wetlands before being recycled for irrigation. This reduces freshwater demand by an estimated 30--40% and provides nutrient-rich water for the permaculture gardens.

**Blackwater processing:** Composting toilets or biodigester systems that produce methane (supplementary cooking fuel) and safe fertilizer.

> **Sources:** Rainfall data from SENAMHI Bolivia (Servicio Nacional de Meteorologia e Hidrologia). Bio-sand filter costs from CAWST (Centre for Affordable Water and Sanitation Technology). Greywater recycling efficiency from WHO Guidelines for the Safe Use of Wastewater.

## Food

The Yungas' extraordinary biodiversity and year-round growing season support a permaculture system that few locations on Earth can match. At 1,750m elevation with subtropical temperatures (18--19 C mean annual), the Coroico area supports an overlapping range of tropical, subtropical, and temperate crops.

### Crops that thrive without greenhouse assistance

- **Coffee** (Coffea arabica) — the region's signature crop, shade-grown at 1,400--1,800m. Both a food system component and a cash crop processed through the [[trading-house|Trading House]].
- **Cacao** (Theobroma cacao) — viable at lower elevations in the Yungas (below 1,200m). Wild Beniano and Alto Beni varieties are internationally recognized for quality.
- **Citrus** — oranges, mandarins, lemons, limes, and grapefruit all grow well. Year-round harvests are achievable with staggered planting of multiple varieties.
- **Bananas and plantains** — a Yungas staple. Multiple varieties provide fruit year-round with minimal maintenance.
- **Avocados** — Hass and local criollo varieties. High caloric density and healthy fat content make avocados a critical food security crop.
- **Passion fruit** (maracuya) — vigorous growers in the Yungas. High market value both fresh and processed into juice or preserves.
- **Yuca** (cassava) — carbohydrate staple that grows with minimal input. A food security backbone.

### Controlled growing systems

**Greenhouses** extend the range of cultivable species and protect high-value crops from heavy rain during the wet season. Low-tunnel designs using locally available bamboo and UV-stabilized plastic are effective and inexpensive ($200--$500 per tunnel).

**Aquaponics** — integrated fish and plant cultivation in recirculating water systems — provides protein (tilapia, trout at this elevation) alongside leafy greens and herbs. A community-scale aquaponics system (500--1,000 liters) can produce 50--100 kg of fish and 200--400 kg of vegetables per year.

### Seed bank

A seed bank preserves local and heirloom varieties — not just for BARK's own resilience, but as a regional resource. The Yungas' agricultural biodiversity is under pressure from monoculture expansion and climate change. A well-maintained community seed bank is both practical infrastructure and conservation work.

> **Sources:** Crop suitability data from INIAF (Instituto Nacional de Innovacion Agropecuaria y Forestal). Aquaponics yield estimates from FAO Technical Paper No. 589, "Small-scale aquaponic food production." Yungas biodiversity data from Ministerio de Medio Ambiente y Agua, Bolivia.

## Connectivity

Bolivia has historically had the slowest average internet speeds in South America. Terrestrial infrastructure in the Yungas is limited to 3G/4G mobile coverage from Entel, Tigo, and Viva — sufficient for messaging but inadequate for remote work, video conferencing, or data-intensive research. **Starlink changes this.** Bolivia lifted restrictions on satellite internet in December 2024, and satellite broadband now provides 50--200 Mbps download speeds independent of terrestrial infrastructure. For a community that depends on global connectivity for its trading house, retreat bookings, open-source publishing, and remote-work residents, this is transformational.

Starlink serves as the internet backbone, but BARK's internal communications do not depend on it. A local mesh network using **LoRa (Long Range) radio modules** provides community-wide connectivity for messaging, sensor data, and local services. LoRa mesh operates on unlicensed ISM bands, has a range of 2--15 km depending on terrain, and costs $15--$50 per node. The mesh network functions with zero internet connectivity — if Starlink goes down or satellite service is disrupted, internal communications continue.

**HF/VHF radio** provides emergency and regional communication beyond the mesh network's range. HF radio can reach La Paz and beyond without any infrastructure dependency. This is not a contingency plan — it is the baseline communication layer that everything else is built on top of.

**On-site servers** host critical knowledge and services locally: the community wiki, medical references, agricultural databases, open-source design files, and cached copies of key internet resources. If external connectivity is lost entirely, the community's knowledge base remains accessible on the local network. Storage is cheap; knowledge loss is expensive.

> **Sources:** Bolivia internet speed rankings from Speedtest Global Index (Ookla). Starlink Bolivia availability and performance from [starlink.com](https://www.starlink.com/). LoRa specifications from Semtech Corporation. Node costs from open-source LoRa hardware suppliers (LILYGO, Heltec).

## Design Principles

Every system follows the same philosophy:

- **Maintainable by residents** — no vendor lock-in
- **Documented openly** — anyone can replicate
- **Gracefully degrading** — partial failure doesn't mean total failure
- **Locally integrated** — our infrastructure benefits the surrounding community too
