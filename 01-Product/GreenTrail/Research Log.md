# GreenTrail — Research Log

_Tracking ongoing research findings for the GreenTrail project._

## Format

Each entry: date, author, finding, source, and implications.

---

## 2026-04-08

### Entry 1 — CSRD Scope & Timeline (Wilson)

**Finding:** The Corporate Sustainability Reporting Directive (CSRD) applies to large companies from 2024, but extends to listed SMEs from 2026 (reporting on 2025 data). Non-listed SMBs in the supply chain face indirect pressure as their large-company customers need Scope 3 data.

**Implication:** Even if SMBs aren't directly mandated yet, their customers will require carbon data — creating a market pull effect. The 2027 reporting year is the inflection point.

---

---

## 2026-04-09

### Entry 2 — Competitive Landscape: Carbon Accounting for Logistics (Wilson)

**Finding:** Surveyed 7 major carbon accounting tools targeting logistics:

| Tool | HQ | Target Segment | Standards | Key Differentiator |
|------|-----|---------------|-----------|--------------------|
| BigMile | NL | Large LSPs, carriers | ISO 14083, GLEC | Multi-modal supply chain analytics, scenario modeling |
| Cozero | Berlin | Mid-to-large enterprises | ISO 14083, GLEC | Full carbon management cycle (Log/Act/Share), ROCI framework |
| Loginex | EU | LSPs, carriers, consultants | EN 16258, COFRET, ISO 14083, GLEC | Regulation-focused, multi-standard compliance |
| Searoutes | Hamburg | Shippers, freight forwarders | GLEC, ISO 14083+ | API-first, route optimization algorithms |
| EcoTransIT | EU | Enterprise logistics | GLEC | Established standard, used as backend by others (e.g., Cozero) |

**Key observation:** Every tool assumes the buyer has (a) a sustainability team, (b) budget for custom integration, (c) technical capacity for API work. No product is purpose-built for the 50-500 employee SMB with zero sustainability headcount.

**Implication:** The SMB segment is genuinely unserved, not just underserved. This validates the positioning thesis: GreenTrail competes on accessibility, not features. CSV-in, report-out, under €500/month.

**Source:** BigMile blog (Mar 2026), Gartner Logistics Carbon reviews, vendor websites.

---

### Entry 3 — Standards Landscape: ISO 14083, GLEC Framework & CountEmissionsEU (Jessica)

**Research Question:** What emission calculation standards apply to European logistics companies, and what do they mean for GreenTrail's product architecture?

**Finding: Three standards are converging into a single compliance requirement**

#### 1. ISO 14083:2023 — The Global Standard

- Published March 2023 by ISO, replacing the older EN 16258 standard
- Covers all transport modes: road, rail, air, sea, inland waterways, pipeline, and cable
- Also covers logistics hubs (ports, warehouses, cross-docking, distribution centers)
- Defines methodology for **quantification, assignment, allocation, and reporting** of GHG emissions across transport chains
- Key distinction from predecessor: introduces **well-to-tank (WTT) emissions** into calculation (not just tailpipe)
- Companies can choose their own emission factors, provided the source is credible
- Explicitly separates emissions accounting from offsetting — offsets and ETS certificates may NOT be subtracted from reported emissions

**Data Hierarchy (critical for product design):**

ISO 14083 defines a clear priority order for input data:
1. **Primary data** (highest quality) — actual fuel consumption, energy use from operations
2. **Modelled data** — calculated from known parameters (vehicle type, route, load factor)
3. **Default values** (lowest tier) — generic emission intensity values provided in ISO 14083 and GLEC Framework

The standard prioritizes primary data but **explicitly permits default values** where primary data isn't available. This is the key enabler for SMBs — they can start compliant immediately using defaults.

#### 2. GLEC Framework v3.2 — The Practical Implementation Guide

- Developed by Smart Freight Centre (global non-profit, founded 2013)
- The **only globally recognized implementation guide** for ISO 14083
- Latest version: v3.2 (published October 23, 2025)
- Written in more accessible language than ISO 14083, with practical examples
- Provides **mode-specific emission factor guidance** and default emission intensity values
- Recognized by CDP and Science Based Targets initiative (SBTi)
- **GLEC accreditation** exists for software tools — provides credibility signal

**v3.2 Updates (October 2025):**
- New Module 6: Air pollutant emissions methodology (NOx, PM, SO₂, etc.)
- Updated fuel emission factors for Europe, North America, China
- New India-specific emission factors (first time)
- Updated marine fuel factors per IMO MEPC81
- Updated logistics hub emission data (new Fraunhofer IML study)

**Implementation Timeline:**
- 2025 inventory: v3.2 encouraged but not mandatory
- 2026 inventory: v3.2 expected and recommended
- 2026/2027: CLEVER harmonised emission factor database expected → will be integrated into future GLEC versions

#### 3. CountEmissionsEU — The EU Regulatory Hammer

- Political agreement reached November 5, 2025 between EU Parliament and Council
- Creates a **single EU-wide methodology** for calculating GHG emissions from transport services
- Built directly on ISO 14083 methodology
- **Key nuance: participation is voluntary** — the regulation does NOT mandate reporting
- **BUT:** if a company *chooses* to report (or is *asked* by a customer to provide emission data), it **MUST use the CountEmissionsEU methodology**
- This is a "binding opt-in" — voluntary to start, mandatory once you do
- SMEs are **exempted from mandatory verification** requirements (reduces compliance burden)
- Combined with CSRD Scope 3 requirements flowing down the supply chain, this creates a de facto mandate for logistics SMBs

#### The Cascade Effect on SMBs

The regulatory pressure chain works like this:
1. **CSRD** requires large EU companies to report Scope 3 emissions (including Category 4: upstream transport & Category 9: downstream transport)
2. Large companies **need emission data from their logistics providers** (even SMB ones)
3. When SMB logistics companies provide that data, **CountEmissionsEU requires them to use ISO 14083 methodology**
4. The **GLEC Framework** is the practical guide for implementing ISO 14083

Result: SMB logistics companies face a **de facto mandate** to calculate emissions using GLEC/ISO 14083 methodology, even though they're not directly regulated under CSRD.

#### Implications for GreenTrail Product Architecture

| Design Decision | Rationale |
|----------------|----------|
| Embed GLEC v3.2 default emission factors as starting point | Zero-friction onboarding; compliant from day one |
| Build progressive data quality upgrade path | Default → modelled → primary data as TMS integrations mature |
| Label data quality tier on every calculation | Builds auditor trust; required by ISO 14083 transparency principles |
| Auto-generate ISO 14083-structured reports | The format customers' enterprise clients need for their CSRD filings |
| Target GLEC/SFC accreditation early | Credibility signal; differentiator vs. DIY spreadsheets |
| Track GLEC Framework version updates programmatically | Emission factors update ~annually; product must stay current without user action |
| Separate offsetting from reporting | ISO 14083 explicitly forbids netting offsets against emissions |

#### Available Emission Factor Sources

| Source | Type | Access | Notes |
|--------|------|--------|-------|
| GLEC Framework default values | Default | SFC members + certified tools (request form) | Excel sheet available |
| HBEFA (Handbook Emission Factors for Road Transport) | Modelled | Licensed | v5.1 published Oct 2025; European road freight |
| SmartWay | Default | Public (US-focused) | Updated 2024 |
| Clean Cargo Working Group | Default | Member access | Container vessel emission intensities |
| IMO MEPC81 | Default | Public | Marine fuel emission factors |
| CLEVER database | Harmonised | Expected 2026/2027 | Future EU-wide standard database |

#### Known Limitation of ISO 14083

Research by the IEA has shown that the fuel emission factors included in ISO 14083 **underestimate methane leakage** during fossil fuel production and transport. The GLEC Framework already incorporates more up-to-date findings on this. → GreenTrail should use GLEC factors, not raw ISO 14083 factors.

**Source:** ISO.org (ISO 14083:2023 listing), Smart Freight Centre (GLEC Framework page), Searoutes blog (GLEC v3.2 update, Nov 2025), BigMile blog (ISO 14083 explainer), Greenplaces (GLEC/ISO 14083 article), CLECAT (CountEmissionsEU agreement, Nov 2025), shipzero blog (ISO 14083 key insights), BFG Logistics (CSRD supply chain impact), EU Commission (CountEmissionsEU announcement).

---

_More entries to follow from Jessica (Research) and Wilson (PM)._
