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

## 2026-04-10

### Entry 4 — CSRD Omnibus Value-Chain Cap & Top-Down GTM Strategy (Wilson)

**Research Question:** How does the March 2026 CSRD Omnibus reform change the go-to-market dynamics for a tool targeting SMB logistics providers?

**Finding: The value-chain cap creates a standardized, enterprise-driven acquisition channel for GreenTrail.**

#### Background: The CSRD Omnibus I Directive (18 March 2026)

The EU's Omnibus simplification package introduced a **value-chain cap** on sustainability data requests:

- CSRD-reporting companies may **no longer require** suppliers with fewer than 1,000 employees to provide data **beyond what's covered by the VSME** (Voluntary SME Standard)
- The EU Commission must publish the binding VSME content by **July 2026**
- SMEs have a **legal right to refuse** data requests exceeding the VSME scope
- Large companies must **clearly disclose** when they request data beyond the VSME and inform SMEs of their right to refuse
- SMEs can self-declare their status (headcount < 1,000); the requester does not need to verify unless circumstances suggest the declaration is false

#### What the Cap Does NOT Limit

Critically, the value-chain cap applies **only to formal CSRD-driven data requests**. Several other channels of pressure remain fully uncapped:

| Pressure Channel | Capped? | Example |
|-----------------|---------|----------|
| Formal CSRD data requests | ✅ Yes (VSME ceiling) | "Fill in this ESRS questionnaire for our sustainability report" |
| Commercial procurement requirements | ❌ No | "Provide ISO 14083 emission data or you won't be in next year's tender" |
| CountEmissionsEU compliance | ❌ No | "If you report transport emissions, you must use ISO 14083 methodology" |
| Voluntary sustainability commitments (SBTi, etc.) | ❌ No | "We need supplier-level data for our Science-Based Targets" |
| Due diligence (CSDDD) | ❌ No | Risk-based ESG information requests |
| Green Claims Directive | ❌ No | Substantiation data for environmental marketing claims |

**Net effect:** The formal reporting channel gets standardized (good for tooling). The commercial channel remains wide open (good for demand generation). SMBs still face real pressure to produce carbon data — they just won't be buried in bespoke questionnaires anymore.

#### The VSME Standard — What to Expect

Based on the EFRAG draft and Commission guidance:
- Simplified set of **climate and governance disclosures** proportionate to SME size
- Likely covers **company-level GHG emissions** (not product-level)
- Product-level carbon footprints and full LCAs are **unlikely to be in scope**
- Basic governance and social indicators
- Publication expected **mid-2026** (watch date: July 2026)

**Product implication:** GreenTrail should be ready to produce VSME-compliant output from day one of the standard's publication. First mover to support the standardized format wins the enterprise partner channel.

#### GTM Insight: The Top-Down Acquisition Engine

Traditional SMB SaaS GTM relies on bottom-up self-serve (SEO, content marketing, free trials). For GreenTrail, this is **necessary but insufficient**. The real volume driver is top-down:

1. **Enterprise shippers need Scope 3 data** from their SMB logistics providers
2. Instead of each enterprise building bespoke supplier surveys, they'll want a **platform** that onboards their carrier network
3. GreenTrail positions as that platform — the enterprise is the buyer, SMBs are the users
4. The SMB gets pulled onto the platform by their *customer's* procurement process
5. Once on the platform (serving one customer), the SMB faces requests from *additional* enterprise customers → stickiness + upsell

**Comparable playbooks:**
| Company | Buyer | Pulled User | Network Effect |
|---------|-------|-------------|----------------|
| Coupa/SAP Ariba | Enterprise procurement | Suppliers | More buyers → more suppliers → more buyers |
| Stripe | Platform/marketplace | End customer | More platforms → more merchants → more volume |
| EcoVadis | Enterprise sustainability | Suppliers (ESG ratings) | More rated suppliers → more enterprise adoption |
| **GreenTrail** | **Enterprise shipper** | **SMB logistics provider** | **More shippers → more carriers → network value** |

**Pricing model implication:**
- **Enterprise tier:** Per-supplier-seat pricing; enterprise pays to onboard their carrier network
- **SMB freemium:** Basic access free when invited by an enterprise customer; upgrade for multi-customer dashboard, advanced analytics
- **Direct SMB paid:** For SMBs who find GreenTrail on their own (bottom-up); lower price point, self-serve

**Source:** Re-Flow.io (CSRD Omnibus maritime analysis, April 2026), Stratecta (Value Chain Cap explainer, 2026), KPMG (EU Omnibus ESRS changes), BFG Logistics (CSRD supply chain impact), EU Commission (VSME Q&A), GA Institute (Managing value chain data requests with VSME).

---

### Entry 5 — VSME Climate Disclosures, ISO 14083 Gap Analysis & Enterprise Data Operationalization (Jessica)

**Research Question:** What does the EFRAG VSME standard specifically require for climate disclosures, how does it interact with ISO 14083, and how are enterprise shippers planning to collect supplier data post-Omnibus?

**Finding: The VSME and ISO 14083 are complementary but serve fundamentally different purposes — and the gap between them defines GreenTrail's product architecture.**

#### Part 1: What the VSME Actually Requires for Climate (B3 & C3)

**Basic Module — B3: Energy and Greenhouse Gas Emissions**

The VSME was finalized by EFRAG on December 17, 2024, and adopted as an EU Commission Recommendation on July 30, 2025. The delegated act (binding version) is due by July 19, 2026.

B3 requires SMEs to disclose:

| Datapoint | Unit | Required? | Notes |
|-----------|------|-----------|-------|
| Total energy consumption | MWh | Yes | Breakdown by renewable vs. non-renewable |
| Electricity (per utility bills) | MWh | Yes | Split renewable/non-renewable |
| Fuels consumed | MWh | Yes | Split renewable/non-renewable |
| Scope 1 GHG emissions | tCO₂e | Yes | Direct emissions from owned/controlled sources |
| Scope 2 GHG emissions (location-based) | tCO₂e | Yes | From purchased electricity/heat |
| Scope 2 GHG emissions (market-based) | tCO₂e | Optional | Can report alongside location-based |
| GHG intensity ratio | tCO₂e / €M turnover | Yes | Emissions per million euro revenue |
| Scope 3 GHG emissions | tCO₂e | **Voluntary** | "Entity-specific" — encouraged but explicitly not required |

Key design notes:
- No materiality analysis required (VSME uses "if applicable" approach instead of double materiality)
- Location-based method is the default for Scope 2
- Nuclear energy is emission-free but NOT counted as renewable
- If a company chooses to report Scope 3, it must be presented alongside B3 data

**Comprehensive Module — C3: GHG Reduction Targets & Climate Transition**

| Datapoint | Required? | Notes |
|-----------|-----------|-------|
| GHG reduction targets (absolute, Scope 1+2) | If targets exist | Absolute values required |
| Base year and target year | If targets exist | |
| Climate transition plan | Optional | For high-climate-impact sectors (NACE H: Transportation & Storage is one) |
| Explanation of contribution to GHG reduction | Optional | |

**Comprehensive Module — C4: Climate Risks**

| Datapoint | Required? | Notes |
|-----------|-----------|-------|
| Physical climate risks identified | If applicable | |
| Transition risks identified | If applicable | |
| Financial effects of climate risks | If applicable | Qualitative description permitted |

#### Part 2: VSME vs. ISO 14083 — Complementary, Not Overlapping

The VSME and ISO 14083 serve entirely different functions:

| Dimension | VSME (B3 + C3) | ISO 14083 / GLEC |
|-----------|----------------|------------------|
| **Purpose** | Company-level sustainability disclosure | Transport chain emission quantification |
| **Granularity** | Annual company totals | Per-shipment, per-transport-leg |
| **Scope coverage** | Scope 1+2 mandatory; Scope 3 voluntary | All emissions across transport chain (WTT + TTW) |
| **Who reports** | The SMB about itself | The SMB to its customers about their shipments |
| **Methodology** | GHG Protocol (flexible) | ISO 14083 (strict hierarchy + allocation rules) |
| **Output format** | Narrative sustainability report | Structured emission data per transport service |
| **Frequency** | Annual | Continuous (per shipment/invoice/quarter) |
| **Legal basis** | CSRD value-chain cap ceiling | CountEmissionsEU + commercial procurement |

**Critical insight: These are NOT substitutes.** An SMB logistics company needs BOTH:
1. **VSME B3** to satisfy its own regulatory disclosure and respond to value-chain-capped data requests
2. **ISO 14083 shipment-level data** to satisfy its enterprise customers' Scope 3 reporting needs and win procurement tenders

A tool that only produces one is incomplete. GreenTrail's architecture must produce both from the same underlying data.

#### Part 3: The "VSME Floor + ISO 14083 Ceiling" Product Architecture

The Omnibus I value-chain cap creates a clear two-tier structure:

**Floor (VSME B3):** The maximum a CSRD-reporting company can formally demand from an SMB supplier for sustainability reporting purposes. Company-level Scope 1+2 GHG totals + energy mix + intensity ratio.

**Ceiling (ISO 14083):** What enterprise customers actually need and will demand commercially. Shipment-level emission calculations, per-lane breakdowns, mode comparisons, allocation to specific customers, data quality labeling.

**The Omnibus commercial loophole (Recital 12):** The value-chain cap explicitly does NOT prohibit data requests for:
- Risk management purposes
- Due diligence under CSDDD
- Voluntary commercial sharing
- Procurement qualification criteria

This means enterprise shippers can (and will) continue requiring ISO 14083-compliant emission data as a procurement condition. The cap just standardizes the floor — it doesn't lower the ceiling.

**Product architecture implication:**

```
[Shipment Data Input]
        ↓
[ISO 14083/GLEC Calculation Engine]
        ↓
    ┌───┴───┐
    ↓       ↓
[Layer 1]  [Layer 2]
 VSME B3    ISO 14083
 Company    Shipment-level
 totals     reports
    ↓       ↓
[Own ESG    [Enterprise
 report]    customers]
```

One data input → two outputs. The SMB enters shipment data once. GreenTrail calculates at the granular level and aggregates up for VSME.

#### Part 4: Early Signals on Enterprise Supplier Data Operationalization

**How are large shippers planning to collect data post-Omnibus?**

Several converging signals:

1. **Carbon as procurement qualification:** Carbon metrics now account for ~18% of 3PL RFP scoring (GlobeNewsWire/Astute Analytica, 2025). This is enough to determine contract outcomes when price and service are comparable.

2. **70% data gap:** 70% of supply chain professionals cite lack of supplier data as their primary Scope 3 barrier (MIT Sloan, 2025). Enterprise shippers are actively seeking tooling to close this gap.

3. **Smart Freight Centre's Sustainable Logistics Procurement playbook:** SFC is actively guiding large freight buyers to standardize carbon data collection using GLEC-aligned methodology. This playbook is becoming the de facto procurement standard.

4. **Platform-driven collection emerging:** Rather than bespoke surveys, enterprise shippers are moving toward platform-based supplier data collection:
   - Amazon has supplier climate requirements embedded in procurement
   - DHL offers Scope 3 tracking guidance for shippers across their network
   - EcoVadis model (ESG ratings) is being adapted for carbon-specific data

5. **66% still on spreadsheets:** Most Scope 3 reporting still relies on spreadsheets (MIT Sloan, 2025). The market is pre-tool — a purpose-built solution has a massive greenfield opportunity.

6. **CSDDD adds another pressure channel:** Companies with 5,000+ employees must conduct risk-based due diligence on their supply chain. For suppliers <5,000 employees, information requests must be "strictly targeted" to material risks — but environmental/climate risk in logistics is almost always material, so this creates another lever for data collection beyond the VSME cap.

#### Implications for GreenTrail

| Implication | Action |
|-------------|--------|
| VSME B3 is the minimum viable product output | Build VSME-compliant report generation as a day-one feature |
| ISO 14083 shipment data is the premium output | This is the upsell and the enterprise value driver |
| The two tiers share the same underlying data | Architecture: calculate at shipment level, aggregate for VSME |
| Enterprise buyer is the acquisition channel | Build supplier portal / invite flow from day one |
| VSME delegated act (July 2026) is a launch window | Be ready to ship VSME support within weeks of publication |
| Carbon is now a procurement qualifier, not a nice-to-have | Position as "win more tenders" not "comply with regulation" |
| NACE H (Transport & Storage) is a high-climate-impact sector | C3 climate transition plans are especially relevant for logistics SMBs |

**Source:** EFRAG VSME Standard (Dec 2024), EFRAG Knowledge Hub (B3 interactive), Selko Insights (B3 & C3 explainers), ESG for Suppliers (VSME 11 disclosures guide), EcoVadis (Value chain action post-Omnibus), BCLP Law (CSRD data requests from SME suppliers), Sunhat (CSRD Omnibus + VSME analysis), KPMG (EU Omnibus ESRS changes), CodeNinja Consulting (Scope 3 logistics qualification gap), Smart Freight Centre (Sustainable Logistics Procurement), MIT Sloan (Supply chain Scope 3 tracking).

---

## 2026-04-11

### Entry 6 — European SMB TMS Landscape & GreenTrail Integration Strategy (Jessica)

**Research Question:** What TMS systems do European SMB logistics companies (50–500 employees) actually use, and what are their carbon reporting capabilities? How should GreenTrail’s integration strategy be prioritized?

**Finding: The European SMB TMS market is deeply fragmented across four tiers, and no platform provides native ISO 14083-compliant carbon calculation. This fragmentation is GreenTrail's strategic opportunity.**

#### Part 1: European TMS Market Overview

The global TMS market was valued at $15 billion in 2025 (GM Insights) and is expected to grow at 10.6% CAGR through 2035. The European TMS market specifically is projected to reach $7.4 billion by 2031 (6W Research, CAGR 7.2%). Berg Insight estimates the combined Europe + North America TMS market will exceed €5 billion by 2028.

The market is dominated by enterprise platforms (SAP, Oracle, Blue Yonder, Manhattan Associates, Descartes) that collectively hold the majority of revenue share. However, revenue share is misleading for GreenTrail’s purposes — enterprise platforms serve a small number of very large customers. The SMB segment is served by a fragmented long tail of regional and cloud-native vendors.

#### Part 2: TMS Vendor Landscape by Tier

**Tier 1 — Enterprise Platforms**

| Vendor | HQ | Target | Price Range | Carbon? | Implementation |
|--------|-----|--------|-------------|---------|----------------|
| CargoWise (WiseTech) | Australia | Global enterprises 200+ | $6–10/shipment (new model) | Via 3rd party | 6–12+ months |
| SAP TM | Germany | Enterprise ERP users | $$$$$+/user | Via 3rd party | 12–24 months |
| Oracle TMS | US | Oracle ecosystem | $$$+/user | Via 3rd party | 6–18 months |
| Blue Yonder | US | Enterprise supply chain | $$$$$+/user | **GLEC-accredited Logistics Emissions Calculator** | 12–24 months |
| Manhattan Active TM | US | Large retailers/manufacturers | $$$$+/user | Via MetaPack/partners | 12+ weeks |

**Key insight:** CargoWise dominates global freight forwarding (A$880M revenue FY2024, 28% YoY growth), but is pricing SMBs out. Its 2025 shift to per-shipment “value packs” ($6–10/shipment) caused 150% cost increases for some existing customers, creating significant churn risk. Loadstar reports (2025) that rival TMS providers (Riege, Magaya) are seeing a sharp rise in interest from companies exploring alternatives — a window for complementary tools like GreenTrail.

**Blue Yonder is the only enterprise TMS with GLEC-accredited carbon calculation** — but it’s an enterprise platform with enterprise pricing and implementation timelines. Not relevant for SMBs.

**Tier 2 — European Regional Champions**

| Vendor | HQ | Target | Carbon? | EU SMB Fit |
|--------|-----|--------|---------|------------|
| Riege Software (Scope) | Germany | Freight forwarders, customs | None native | **High** — Strong in DACH, ~40 years in market |
| LIS (WinSped) | Germany | Freight forwarders, carriers | None native | **High** — Leading in German road freight |
| Alpega Group | Belgium | Mid-large forwarders | Basic sustainability module | **Medium-High** — Broader EU coverage |
| Transporeon (Trimble) | Germany | Large shippers, 150k+ carriers | Freight benchmarking touches carbon | **Medium** — More shipper-focused, €50k+ annual |
| Descartes | Canada | Compliance-focused global ops | Via partners | **Medium** — Strong in compliance, less in SMB |

**Key insight:** Riege Scope and LIS WinSped are the TMS platforms most European SMB freight forwarders actually encounter. Riege’s Scope Hub is building an ecosystem of digital integrations (Jan 2025: CargoAi partnership for air cargo), suggesting openness to third-party connectors. WinSped covers the full transport chain with modular architecture. Neither has native carbon capabilities — this is a massive gap that GreenTrail can fill.

**Tier 3 — Emerging Cloud-Native**

| Vendor | HQ | Target | Price | Carbon? | Implementation |
|--------|-----|--------|-------|---------|----------------|
| Cargoson | Estonia | EU manufacturers, wholesalers, retailers | From €199/mo | **Basic CO₂ in dashboard** | Days to weeks |
| GoFreight | US | Mid-market freight forwarders (10–100 emp) | $/user competitive | None | 4–8 weeks |
| Wisor | US | Small-mid freight forwarders | $/user | None | Days |
| Magaya | US | Forwarders with WMS needs | $100–400/user/mo | None | 8–12 weeks |
| FreightPOP | US | Small teams, regional forwarders | Affordable | None | Minimal |

**Key insight:** Cargoson stands out — it’s the only cloud-native European TMS that shows CO₂ emissions alongside price and transit times in real-time. But it’s a basic calculation (estimated CO₂ per carrier), not ISO 14083-compliant, not GLEC-aligned, and not designed for regulatory reporting. This represents both a **potential competitor** and a **potential partner** for GreenTrail. Partnership is more likely: Cargoson is a pure shipper-focused TMS, not a carbon compliance tool. GreenTrail could be the ISO 14083 engine behind Cargoson’s carbon feature.

**Tier 4 — Spreadsheets & Manual Processes**

- 75% of freight forwarders report manual logistics processes slow operations (Freightify, 2026)
- 66% of Scope 3 reporting still relies on spreadsheets (MIT Sloan, 2025)
- Many SMBs use a TMS for operational tasks but handle carbon/sustainability in Excel
- This segment represents GreenTrail’s largest day-one addressable market

#### Part 3: The Carbon Module Pricing Problem

Research on TMS procurement reveals a systematic pattern: TMS vendors charge 15–30% premiums for sustainability modules (TransportManagementSoftware.org, 2026). Specific cost patterns:

- Basic carbon tracking add-ons: 15–30% increase on total system cost
- Integration with emissions databases via API: $5,000–$15,000 per connection
- Complex ERP emissions integrations: $50,000+
- Implementation cost overruns: Hidden costs exceed initial estimates by 25–30%

Vendors are exploiting CSRD urgency and regulatory uncertainty to justify premium pricing for what increasingly should be standard functionality. Several TMS vendors (Cargoson, Alpega, nShift) are beginning to offer transparent carbon pricing as a competitive differentiator against this practice.

**Implication for GreenTrail:** Position as the **affordable, standards-compliant carbon layer** that eliminates the need for expensive TMS sustainability add-ons. SMBs get ISO 14083/GLEC-compliant carbon calculation at a fraction of what enterprise TMS vendors charge for basic CO₂ estimation.

#### Part 4: Integration Strategy Recommendation

**Priority 1 (MVP launch): CSV/Excel Import**
- Target: 66%+ of market on spreadsheets
- Accept common TMS export formats (CSV, XLSX)
- Template library for common fields: origin, destination, weight, mode, carrier, date
- Zero integration cost, zero technical dependency on TMS vendor

**Priority 2 (Q3 2026): Riege Scope API Connector**
- Scope Hub ecosystem designed for third-party integrations
- Accesses DACH market (Germany alone: ~25,000 freight forwarding companies, most are SMBs)
- Riege’s partnership strategy (CargoAi, etc.) suggests openness to ecosystem plays

**Priority 3 (Q3 2026): Cargoson Partnership**
- Already shows carbon in dashboard but lacks ISO 14083 depth
- White-label or API partnership: GreenTrail provides the compliant calculation engine
- Cargoson’s European shipper focus aligns with GreenTrail’s target market

**Priority 4 (Q4 2026): Alpega TMS Connector**
- Broader European reach beyond DACH
- Already positioning around sustainability-with-TMS
- Likely receptive to carbon integration partners

**Priority 5 (Q4 2026): WinSped/LIS Integration**
- Strong in German road freight
- Road mode = simplest ISO 14083 calculation path (HBEFA v5.1 emission factors)
- Modular architecture may support integration

#### Part 5: Market Sizing Signal

Europe has approximately **400,000+ logistics companies** (Eurostat), of which the vast majority are SMEs. Germany alone has ~60,000 companies in NACE H (Transportation & Storage). France, Italy, Spain, Poland, and the Netherlands each have tens of thousands more.

The addressable market for a €200–500/month carbon compliance tool targeting just the 50–500 employee segment is conservatively **50,000–100,000 companies** across the EU — a €120M–€600M annual revenue opportunity.

#### Implications for GreenTrail

| Implication | Action |
|-------------|--------|
| No TMS provides native ISO 14083 carbon | GreenTrail has clear white space |
| TMS vendors charge 15–30% for basic carbon | Price GreenTrail at a fraction of that |
| Market is deeply fragmented (no dominant SMB platform) | Build as a standalone layer, not a TMS feature |
| CSV/Excel is the universal export format | Prioritize CSV import for MVP |
| Riege Scope + WinSped dominate DACH SMB segment | Target these for first API integrations |
| Cargoson has basic carbon but lacks compliance depth | Explore white-label partnership |
| Enterprise TMS churn (CargoWise pricing) | Opportunity to capture forwarders in transition |
| VSME delegated act (July 2026) = launch window | TMS integration roadmap should align with this |

**Source:** Cargoson blog (Top 17 TMS 2026), Wisor.ai (Top 8 TMS for freight forwarders 2026), GoFreight (Best TMS 2026), Riege.com (Scope Hub, CargoAi partnership Jan 2025), LIS.eu (WinSped), Alpega Group (Sustainability with TMS), Berg Insight (TMS Market Report, 2024), GM Insights (TMS Market Size 2025), 6W Research (Europe TMS Market), Mordor Intelligence (TMS Market Size), TransportManagementSoftware.org (Carbon reporting procurement), Blue Yonder (GLEC-accredited Logistics Emissions Calculator), IntelliTrans (EcoTransIT integration), Loadstar (CargoWise pricing rivals, 2025), WiseTech FY2024 results, FreightOScope (CargoWise competitors), MIT Sloan (Scope 3 spreadsheet data 2025), Freightify (75% manual processes stat 2026).

---

_More entries to follow from Jessica (Research) and Wilson (PM)._
