# GreenTrail - Insights Tracker

_Daily insights from Wilson (PM) and Jessica (Research), running through Monday April 13._

## Format

| Date | Author | Insight | Category |
|------|--------|---------|----------|
| 2026-04-08 | Wilson | The airline offset analogy is the "why now" framing - consumers already accept per-transaction carbon visibility; logistics is the next industry to adopt this | Market Framing |
| 2026-04-08 | Wilson | This is an integration play, not a data collection problem - shipment data already exists in TMS/carrier systems | Architecture |
| 2026-04-08 | Wilson | CSRD 2027 creates a hard buying trigger with a fixed deadline - rare in B2B SaaS | Go-to-Market |
| 2026-04-09 | Wilson | Competitive landscape reveals a "missing middle" - all tools target enterprise, leaving SMBs in a dead zone. GreenTrail's wedge is simplicity + price, not features | Competitive Strategy |
| 2026-04-09 | Jessica | ISO 14083 + GLEC + CountEmissionsEU converge into one compliance requirement; GLEC default factors enable zero-friction onboarding; GreenTrail's real value is compliance-as-a-service | Standards & Compliance |
| 2026-04-10 | Wilson | The CSRD Omnibus value-chain cap + VSME standard creates a "top-down acquisition engine" - enterprise customers push SMBs to adopt, and GreenTrail should be the landing page they arrive at. GTM = partner with large shippers, not cold-call SMBs | Go-to-Market Strategy |
| 2026-04-10 | Jessica | The VSME creates a two-tier data architecture: B3 (Scope 1+2 energy/GHG) is the regulatory floor, but enterprise procurement demands ISO 14083 shipment-level data far beyond it. GreenTrail must serve both layers - VSME compliance as the hook, ISO 14083 depth as the value | Regulatory & Product Architecture |
| 2026-04-11 | Jessica | The European SMB TMS landscape is deeply fragmented - split between expensive enterprise platforms (CargoWise, SAP TM), regional champions (Riege Scope, WinSped, Alpega), and emerging cloud-native tools (Cargoson, Wisor). No TMS offers native ISO 14083 carbon calculation; sustainability modules are premium add-ons charging 15-30% extra. GreenTrail's integration strategy should target CSV/Excel first (the 66% on spreadsheets), then API connectors for the top 5 EU SMB TMS platforms. | TMS Landscape & Integration Strategy |
| 2026-04-11 | Wilson | GreenTrail's MVP is a "10-minute compliance" play — CSV upload → ISO 14083 calculation → dual output (VSME B3 company report + shipment-level data for enterprise customers). Three user entry points: self-serve SMB, enterprise-invited supplier, and TMS white-label. The product-market fit test is one question: can an SMB with zero sustainability expertise produce an ISO 14083-compliant emission report within one session? If yes, we win. | Product Definition & MVP Strategy |

---

## Day 1 - April 8, 2026

### Wilson (PM Perspective)

*Insight: The biggest strategic advantage is that this is an integration problem, not a data problem.*

Most sustainability tools assume you need to collect new data. But logistics companies already track shipment weights, distances, modes, and carriers in their TMS. The carbon calculation is a *layer on top of existing data*, not a new data stream.

This means:
- **Faster time-to-value** - connect to what they have, don't make them change how they work
- **Lower switching cost** - it's an add-on, not a replacement
- **Defensible moat** - whoever builds the best TMS integrations wins (network effect with carrier APIs)

The product play is clear: *be the carbon intelligence layer that sits on top of existing logistics infrastructure.*

### Jessica (Research Perspective)

_Note: Jessica came online on April 8 but contributed her first insight on Day 2 (April 9). Day 1 slot left intentionally blank._

---

## Day 2 - April 9, 2026

### Wilson (PM Perspective)

*Insight: The competitive landscape reveals a clear "missing middle" - every existing tool is built for enterprises, leaving SMBs in a dead zone.*

After researching the current carbon accounting tools for logistics (BigMile, Cozero, Loginex, Searoutes, EcoTransIT), a pattern emerges:

- **All major players target LSPs, mid-to-large enterprises, or freight forwarders with dedicated sustainability teams**
- **Pricing models assume enterprise budgets** - custom quotes, annual contracts, professional services for integration
- **Integration complexity is high** - API-first approaches like Searoutes are powerful but require dev resources SMBs don't have
- **Compliance coverage is broad** - CSRD, CDP, SBTi - but the UX assumes someone who knows what those acronyms mean

**The gap is not technology - it's accessibility.** The calculation engines exist (GLEC Framework v3.2, ISO 14083). The emission factor databases exist. What doesn't exist is a product that:
1. Lets an SMB with zero sustainability expertise get started in under a day
2. Costs under €500/month
3. Requires no custom integration work (CSV upload + pre-built connectors)
4. Produces a compliant report without a consultant

**Product positioning implication:** GreenTrail shouldn't try to out-feature BigMile or Cozero. It should be the **Stripe of carbon accounting for logistics** - developer-easy is their thing, ours is **operator-easy**. The wedge is simplicity and price, not capability.

### Jessica (Research Perspective)

*Insight: The standards landscape is GreenTrail's secret weapon - ISO 14083 + GLEC Framework provide a "compliance engine" that SMBs can't build themselves, but that GreenTrail can embed invisibly.*

After deep-diving into the regulatory and standards ecosystem, a critical product architecture insight emerges:

**Three standards are converging into one compliance requirement:**
1. **ISO 14083:2023** - the global standard for quantifying & reporting transport chain GHG emissions (published March 2023, replaces EN 16258)
2. **GLEC Framework v3.2** - the practical implementation guide for ISO 14083 (updated October 2025 by Smart Freight Centre)
3. **CountEmissionsEU** - new EU regulation (political agreement November 2025) that mandates ISO 14083 methodology for *anyone who chooses to disclose* transport emissions in the EU

**The SMB trap:** ISO 14083 defines a strict data hierarchy - primary data preferred, then modelled data, then default values as fallback. SMBs will overwhelmingly start with default emission factors (the lowest tier). *But that's actually fine for initial compliance.* The standard explicitly permits it.

**Product implication for GreenTrail:** The product should:
- Start users on GLEC default emission factors (zero setup friction) → compliant from day one
- Progressively upgrade data quality as TMS integrations feed primary data → accuracy improves over time
- Auto-generate reports that are ISO 14083-structured and CountEmissionsEU-ready
- Transparently label data quality tier per calculation (builds auditor trust)

**Why this matters:** No SMB logistics company is going to read a 100+ page ISO standard or track GLEC Framework version updates. GreenTrail's real value proposition isn't *calculation* - it's **compliance-as-a-service**. Embed the standards so deeply that the user never has to think about them.

---

## Day 3 - April 10, 2026

### Wilson (PM Perspective)

*Insight: The CSRD Omnibus value-chain cap transforms GreenTrail's go-to-market from "sell to SMBs" to "be the tool enterprise customers push their SMB suppliers toward."*

A critical regulatory development reshapes the entire acquisition strategy:

The **CSRD Omnibus I Directive** (entered into force 18 March 2026) introduced a **value-chain cap** - companies with fewer than 1,000 employees can now legally refuse sustainability data requests that exceed the **Voluntary SME Standard (VSME)**, which the EU Commission must publish by mid-2026.

This sounds like it *reduces* pressure on SMBs. Paradoxically, it **increases** the opportunity for GreenTrail:

1. **The cap standardizes what's asked.** Instead of every enterprise customer sending bespoke sustainability questionnaires (which SMBs ignore or fumble), there will be ONE known standard (VSME) that everyone aligns to. GreenTrail can be purpose-built to produce exactly that output.

2. **Commercial pressure remains uncapped.** The value-chain cap only limits *formal CSRD data requests*. Enterprise customers can still require carbon data as a **procurement condition** - and they will. "Provide your ISO 14083-compliant emission data or lose the contract" is a commercial decision, not a CSRD request. The cap doesn't touch it.

3. **This creates a "top-down acquisition engine."** Large shippers and freight buyers (DHL, Kuehne+Nagel, CEVA, Maersk, enterprise manufacturers) need Scope 3 data from their SMB logistics providers. They will actively push SMBs toward tools that produce compatible data. GreenTrail's GTM should **partner with enterprise buyers** rather than cold-calling SMBs.

**The product-channel fit:**
- Build a **"supplier portal"** mode where an enterprise customer invites their SMB logistics providers
- The enterprise gets standardized, auditable emission data for their CSRD Scope 3 reporting
- The SMB gets a free or subsidized tool (enterprise pays per supplier seat)
- GreenTrail captures the SMB as a long-term customer who eventually pays directly

**Analogy:** This is the Coupa/Ariba playbook - the buyer network effect. Enterprises don't buy Coupa *for* their suppliers. They buy it for themselves and *pull* suppliers onto the platform. GreenTrail should work the same way for carbon data.

**Pricing implication:** Consider a **freemium-for-supplier** model where the enterprise shipper pays for the platform and their SMB carriers get basic access free. Once SMBs see the value (and face requests from *multiple* enterprise customers), they upgrade to paid.

### Jessica (Research Perspective)

*Insight: The VSME standard and the value-chain cap create a two-tier data architecture - and the gap between the two tiers is exactly where GreenTrail lives.*

After deep-diving into the EFRAG VSME standard (finalized December 17, 2024) and the Omnibus I value-chain cap mechanics, a critical product architecture finding emerges:

**Tier 1: What the law allows SMBs to limit themselves to (VSME)**

The VSME has two modules:
- **Basic Module (B1-B11):** 11 disclosures. The climate-relevant one is **B3 - Energy and Greenhouse Gas Emissions**, which requires:
  - Total energy consumption in MWh (renewable vs. non-renewable breakdown)
  - Gross GHG emissions: **Scope 1 and Scope 2 only** (location-based method)
  - GHG intensity ratio (per € million turnover)
  - Scope 3 is explicitly **voluntary** under B3
- **Comprehensive Module (C1-C9):** Adds GHG reduction targets (C3), climate transition plans, climate risks (C4). Transport-specific emissions still not mandated.

Under the Omnibus I value-chain cap (in force March 18, 2026), companies with <1,000 employees have a **statutory right to refuse** any data request beyond the VSME. The delegated act codifying this is due by **July 19, 2026**.

**Tier 2: What enterprise customers actually need (ISO 14083 shipment-level data)**

Here's the critical gap: VSME B3 asks for *company-level* Scope 1+2 totals. But what enterprise shippers need for their own CSRD Scope 3 Category 4/9 reporting is *shipment-level* emission data calculated per ISO 14083 methodology. These are fundamentally different:

| Dimension | VSME B3 | Enterprise Procurement Need |
|-----------|---------|---------------------------|
| Granularity | Company-level annual totals | Per-shipment, per-lane |
| Scopes | Scope 1+2 only | Scope 3 (their perspective) |
| Methodology | Any credible source | ISO 14083 / GLEC Framework |
| Format | Free-form sustainability report | Structured, machine-readable |
| Frequency | Annual | Continuous / per-invoice |

**The Omnibus "commercial loophole":** The value-chain cap limits *CSRD reporting data requests* - but Recital 12 of Omnibus I explicitly states the cap does **not prohibit** requesting information for risk management, due diligence, or voluntary commercial purposes. Enterprise shippers can (and will) continue requiring ISO 14083-compliant emission data as a **procurement condition**. Carbon metrics already account for ~18% of 3PL RFP scoring.

**What this means for GreenTrail's product architecture:**

1. **Layer 1 - VSME Compliance (the hook):** Auto-generate a VSME B3-compliant climate disclosure from the same data. This is the "free" value that gets SMBs in the door and protects them legally.
2. **Layer 2 - ISO 14083 Shipment Data (the real value):** Provide the granular, per-shipment emission calculations their enterprise customers actually need. This is what wins contracts.
3. **The bridge between them:** GreenTrail calculates at the shipment level (Layer 2) and *aggregates up* to produce company-level totals (Layer 1). One data entry, two outputs. The SMB never has to think about which standard applies where.

**Early signal on enterprise operationalization:** Smart Freight Centre’s “Sustainable Logistics Procurement” playbook is guiding large freight buyers to standardize carbon data collection from their carrier networks. Companies like DHL, Amazon, and Maersk already have supplier carbon data programs. Post-Omnibus, these programs will likely converge on VSME as the baseline + ISO 14083 as the procurement-grade standard. 70% of supply chain professionals cite lack of supplier data as their primary Scope 3 barrier (MIT Sloan, 2025).

---

## Day 4 - April 11, 2026

### Jessica (Research Perspective)

*Insight: The European SMB TMS landscape is deeply fragmented — and the carbon integration gap across every tier is GreenTrail's clearest product-market wedge.*

After mapping the transport management system landscape serving European SMB logistics companies (50–500 employees), a critical integration strategy finding emerges:

**The market splits into four tiers, and none of them solve carbon:**

**Tier 1 — Enterprise Platforms (CargoWise, SAP TM, Oracle TMS, Blue Yonder)**
- Target: Global enterprises with 200+ employees, dedicated IT teams
- Cost: $30,000–$500,000+/year; 6–24 month implementation
- Carbon: Blue Yonder has a GLEC-accredited Logistics Emissions Calculator; CargoWise and SAP TM rely on third-party integrations (EcoTransIT, Cozero). Carbon is always a separate premium module, never native.
- EU SMB relevance: Essentially zero. Price, complexity, and implementation timelines are prohibitive for SMBs.

**Tier 2 — Regional Champions (Riege Scope, LIS WinSped, Alpega, Transporeon)**
- Target: Mid-sized European freight forwarders, carriers, and LSPs
- Cost: €10,000–€300,000/year depending on modules and scale
- Carbon: Alpega has a basic sustainability-with-TMS offering. Transporeon has freight benchmarking that touches carbon. Riege Scope and WinSped have **no native carbon calculation** — this is a major gap. Riege recently partnered with CargoAi for digital air cargo (Jan 2025), showing its modernization trajectory, but carbon is not on its public roadmap.
- EU SMB relevance: **High.** These are the TMS platforms that actual European SMB forwarders use. Riege Scope and WinSped are particularly strong in the DACH region (Germany/Austria/Switzerland). Alpega has broader European coverage.

**Tier 3 — Emerging Cloud-Native (Cargoson, GoFreight, Wisor, Magaya, FreightPOP)**
- Target: SMBs, growing forwarders, shippers wanting fast deployment
- Cost: €199–€5,000/month; 1–8 week implementation
- Carbon: Cargoson is notably ahead — it offers **real-time CO₂ calculations directly in the dashboard** alongside price and transit time comparisons. This is the closest to what GreenTrail envisions, but it’s a lightweight feature (basic CO₂ per carrier), not ISO 14083-compliant or GLEC-aligned. GoFreight, Wisor, and FreightPOP have **no carbon features.**
- EU SMB relevance: **Growing rapidly.** Cargoson specifically targets European manufacturers, wholesalers, and retailers. GoFreight is strong in US mid-market. Wisor targets small-to-mid freight forwarders.

**Tier 4 — Spreadsheets & Manual Processes**
- Target: The majority of SMB logistics companies
- Cost: Free (but enormous hidden costs in labor, errors, and lost contracts)
- Carbon: None. Over **75% of freight forwarders** report manual processes slow operations (Freightify, 2026). **66% of Scope 3 reporting still relies on spreadsheets** (MIT Sloan, 2025).
- EU SMB relevance: **This is GreenTrail's largest addressable segment.** Many SMBs use a TMS for core operations but handle sustainability entirely in Excel — or not at all.

**The carbon integration gap across all tiers:**

| TMS Tier | Carbon Capability | ISO 14083 Compliant? | GLEC Accredited? | Integration Path for GreenTrail |
|----------|-------------------|---------------------|-----------------|-------------------------------|
| Enterprise (CargoWise, SAP) | Premium add-on modules | Partial (via 3rd party) | Blue Yonder only | Not a priority (different segment) |
| Regional (Riege, WinSped, Alpega) | Minimal or none | No | No | **API/EDI connectors — high priority** |
| Cloud-Native (Cargoson, GoFreight) | Basic CO₂ (Cargoson only) | No | No | **API partnerships — medium priority** |
| Spreadsheets | None | No | No | **CSV upload — highest priority** |

**The key finding: TMS vendors treat carbon as a premium upsell, not a core capability.** Research on TMS procurement shows sustainability modules typically add 15–30% to total system costs, and vendors are exploiting CSRD urgency to charge premiums for what should be standard functionality. This creates the perfect positioning for GreenTrail as a **standalone carbon intelligence layer** that plugs into any TMS rather than replacing it.

**Integration strategy recommendation (prioritized):**

1. **CSV/Excel import (launch priority):** Capture the 66% on spreadsheets. Accept standard shipment export formats — most TMS systems can export CSV. This is the zero-friction entry point.
2. **Riege Scope API** (Q3 2026 target): Scope Hub by Riege is building an ecosystem of digital integrations. A GreenTrail connector here accesses the DACH SMB market — Germany alone has ~25,000 freight forwarding companies.
3. **Cargoson partnership** (Q3 2026): Cargoson already shows carbon in its dashboard but lacks ISO 14083 depth. GreenTrail could be the compliance engine behind Cargoson’s carbon feature — a white-label or API partnership.
4. **Alpega TMS connector** (Q4 2026): Broader European reach. Alpega’s sustainability-with-TMS positioning suggests openness to carbon integrations.
5. **WinSped / LIS integration** (Q4 2026): Strong in German road freight — perfect for the land transport segment where ISO 14083 road mode calculations are most straightforward.

**Why “plug-in” beats “platform” for GreenTrail:**

The SMB TMS market is deeply fragmented — no single platform holds even 20% of the European SMB segment. Trying to build GreenTrail as a full TMS would mean competing with entrenched regional players. Instead, GreenTrail should be the **carbon intelligence layer that works with every TMS** — the Stripe model applied to carbon. CSV-in from any source, ISO 14083-compliant calculation, VSME + enterprise-grade reports out.

This also de-risks the enterprise supplier portal strategy from Day 3: when a large shipper invites an SMB carrier onto GreenTrail, the SMB doesn’t need to change their TMS. They just export their shipment data (or connect via API) and GreenTrail handles the rest.

---

## Day 4 (continued) - April 11, 2026

### Wilson (PM Perspective)

*Insight: GreenTrail's MVP is a "10-minute compliance" play — the product that turns CSV shipment data into ISO 14083-compliant reports before the user finishes their coffee.*

After four days of research, the pieces snap together into a clear product definition. Jessica mapped the TMS landscape (Day 4) and found nobody offers native ISO 14083 carbon. My earlier work identified the competitive gap (Day 2), the top-down GTM via enterprise buyers (Day 3), and the integration-over-collection architecture (Day 1). Now: what do we actually build?

**The MVP = "10-Minute Compliance"**

The core product thesis reduces to one test: *Can an SMB logistics company with zero sustainability expertise produce an ISO 14083-compliant emission report within a single session?*

If the answer is yes, GreenTrail wins. Here's why: every competitor requires weeks of setup, custom integration, or consultant hand-holding. If we nail the 10-minute experience, we're not competing on features — we're competing on a fundamentally different time-to-value.

**Three Entry Points, One Engine:**

```
Entry Point 1: Self-Serve SMB
  [Sign up] → [Upload CSV] → [Map columns] → [Calculate] → [Download report]
  Time: 10 minutes | Cost: Free trial / €199-499/mo

Entry Point 2: Enterprise-Invited Supplier
  [Receive invite link] → [Create account] → [Upload CSV] → [Reports auto-shared with buyer]
  Time: 10 minutes | Cost: Free (enterprise pays per supplier seat)

Entry Point 3: TMS White-Label (future)
  [API integration] → [Automatic calculation] → [Reports in TMS dashboard]
  Time: Zero for end user | Cost: Per-calculation API fee
```

**MVP Feature Set (Ruthlessly Scoped):**

| Feature | In MVP? | Rationale |
|---------|---------|-----------|
| CSV/Excel upload | ✅ Yes | Targets 66% of market on spreadsheets |
| Column auto-mapping | ✅ Yes | "Smart" detection of origin, destination, weight, mode, carrier |
| GLEC default emission factors | ✅ Yes | Zero-friction; compliant from day one |
| ISO 14083 shipment-level calculation | ✅ Yes | The core engine |
| VSME B3 company-level report | ✅ Yes | Aggregates from shipment data; dual output |
| Data quality tier labeling | ✅ Yes | Required by ISO 14083; builds auditor trust |
| Enterprise supplier invite flow | ✅ Yes | The GTM channel; must be in v1 |
| PDF/Excel report export | ✅ Yes | The deliverable SMBs share with customers |
| TMS API connectors | ❌ v2 | Start with CSV; APIs after product-market fit |
| Scenario modeling / reduction planning | ❌ v2 | Nice-to-have, not core compliance |
| Offset tracking | ❌ Never in reports | ISO 14083 forbids netting offsets |
| GLEC/SFC accreditation | 🎯 Target | Apply during MVP build; credibility signal |

**The "Supplier Portal" as GTM Weapon:**

This is the critical architectural decision: the enterprise invite flow isn't a feature — it's the distribution channel. Drawing from the EcoVadis and Coupa playbooks:

1. Enterprise shipper signs up → gets a dashboard showing their carrier network's emissions
2. Enterprise invites SMB carriers via email link → "Your customer [DHL/Maersk/etc.] is requesting ISO 14083 emission data"
3. SMB clicks link → creates account → uploads one CSV → report auto-generates and shares back to enterprise
4. SMB is now on the platform. Second enterprise customer asks for the same data? Already there.
5. Network effect compounds: more enterprises → more SMBs → more enterprises see their carriers already reporting

**Pricing Model:**

| Tier | User | Price | What They Get |
|------|------|-------|---------------|
| Free | Enterprise-invited SMB | €0 | Basic reports for the inviting enterprise customer |
| Starter | Self-serve SMB | €199/mo | Up to 500 shipments/mo, 1 enterprise report output |
| Growth | SMB with multiple customers | €499/mo | Unlimited shipments, multi-customer dashboard, API access |
| Enterprise | Large shipper/buyer | €50-100/supplier/mo | Supplier portal, fleet-wide dashboard, audit trail |

**The "Free-for-Invited-Suppliers" model is non-negotiable.** If we charge the SMB to respond to their customer's data request, friction kills adoption. The enterprise buyer must pay. This is the Coupa model: buyer funds the platform, suppliers join for free, value compounds as the network grows.

**Timeline Alignment:**

| Milestone | Date | Why It Matters |
|-----------|------|----------------|
| VSME delegated act published | ~July 2026 | Standardizes the output format; first-mover advantage |
| CountEmissionsEU final text | H2 2026 | Confirms ISO 14083 as the methodology |
| CSRD first reports including Scope 3 | 2025-2026 (ongoing) | Enterprise buyers actively seeking supplier data NOW |
| GreenTrail MVP target | Q3 2026 | Land before VSME publication; iterate after |

**Key Risk:** GLEC default emission factors are available to SFC members and certified tools. We need to secure access early — either through SFC membership or by applying for GLEC tool accreditation during MVP build. This is a gating dependency.

**What This Means for the Board Meeting (Monday):**

The product definition is now clear enough to discuss build decisions:
1. *Build or buy the calculation engine?* (Recommendation: build — it's the core IP, and the GLEC math is documented)
2. *Which entry point first?* (Recommendation: self-serve SMB for validation, enterprise invite for scale)
3. *Who builds it?* (This is an architecture + front-end + back-end discussion for the full agent team)
4. *GLEC/SFC relationship?* (Need to initiate contact — Roger, is this something the Board wants to pursue?)

---
