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
| 2026-04-10 | Wilson | The CSRD Omnibus value-chain cap + VSME standard creates a "top-down acquisition engine" — enterprise customers push SMBs to adopt, and GreenTrail should be the landing page they arrive at. GTM = partner with large shippers, not cold-call SMBs | Go-to-Market Strategy |
| 2026-04-10 | Jessica | The VSME creates a two-tier data architecture: B3 (Scope 1+2 energy/GHG) is the regulatory floor, but enterprise procurement demands ISO 14083 shipment-level data far beyond it. GreenTrail must serve both layers — VSME compliance as the hook, ISO 14083 depth as the value | Regulatory & Product Architecture |

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

The **CSRD Omnibus I Directive** (entered into force 18 March 2026) introduced a **value-chain cap** — companies with fewer than 1,000 employees can now legally refuse sustainability data requests that exceed the **Voluntary SME Standard (VSME)**, which the EU Commission must publish by mid-2026.

This sounds like it *reduces* pressure on SMBs. Paradoxically, it **increases** the opportunity for GreenTrail:

1. **The cap standardizes what's asked.** Instead of every enterprise customer sending bespoke sustainability questionnaires (which SMBs ignore or fumble), there will be ONE known standard (VSME) that everyone aligns to. GreenTrail can be purpose-built to produce exactly that output.

2. **Commercial pressure remains uncapped.** The value-chain cap only limits *formal CSRD data requests*. Enterprise customers can still require carbon data as a **procurement condition** — and they will. "Provide your ISO 14083-compliant emission data or lose the contract" is a commercial decision, not a CSRD request. The cap doesn't touch it.

3. **This creates a "top-down acquisition engine."** Large shippers and freight buyers (DHL, Kuehne+Nagel, CEVA, Maersk, enterprise manufacturers) need Scope 3 data from their SMB logistics providers. They will actively push SMBs toward tools that produce compatible data. GreenTrail's GTM should **partner with enterprise buyers** rather than cold-calling SMBs.

**The product-channel fit:**
- Build a **"supplier portal"** mode where an enterprise customer invites their SMB logistics providers
- The enterprise gets standardized, auditable emission data for their CSRD Scope 3 reporting
- The SMB gets a free or subsidized tool (enterprise pays per supplier seat)
- GreenTrail captures the SMB as a long-term customer who eventually pays directly

**Analogy:** This is the Coupa/Ariba playbook — the buyer network effect. Enterprises don't buy Coupa *for* their suppliers. They buy it for themselves and *pull* suppliers onto the platform. GreenTrail should work the same way for carbon data.

**Pricing implication:** Consider a **freemium-for-supplier** model where the enterprise shipper pays for the platform and their SMB carriers get basic access free. Once SMBs see the value (and face requests from *multiple* enterprise customers), they upgrade to paid.

### Jessica (Research Perspective)

*Insight: The VSME standard and the value-chain cap create a two-tier data architecture — and the gap between the two tiers is exactly where GreenTrail lives.*

After deep-diving into the EFRAG VSME standard (finalized December 17, 2024) and the Omnibus I value-chain cap mechanics, a critical product architecture finding emerges:

**Tier 1: What the law allows SMBs to limit themselves to (VSME)**

The VSME has two modules:
- **Basic Module (B1–B11):** 11 disclosures. The climate-relevant one is **B3 — Energy and Greenhouse Gas Emissions**, which requires:
  - Total energy consumption in MWh (renewable vs. non-renewable breakdown)
  - Gross GHG emissions: **Scope 1 and Scope 2 only** (location-based method)
  - GHG intensity ratio (per € million turnover)
  - Scope 3 is explicitly **voluntary** under B3
- **Comprehensive Module (C1–C9):** Adds GHG reduction targets (C3), climate transition plans, climate risks (C4). Transport-specific emissions still not mandated.

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

**The Omnibus "commercial loophole":** The value-chain cap limits *CSRD reporting data requests* — but Recital 12 of Omnibus I explicitly states the cap does **not prohibit** requesting information for risk management, due diligence, or voluntary commercial purposes. Enterprise shippers can (and will) continue requiring ISO 14083-compliant emission data as a **procurement condition**. Carbon metrics already account for ~18% of 3PL RFP scoring.

**What this means for GreenTrail's product architecture:**

1. **Layer 1 — VSME Compliance (the hook):** Auto-generate a VSME B3-compliant climate disclosure from the same data. This is the "free" value that gets SMBs in the door and protects them legally.
2. **Layer 2 — ISO 14083 Shipment Data (the real value):** Provide the granular, per-shipment emission calculations their enterprise customers actually need. This is what wins contracts.
3. **The bridge between them:** GreenTrail calculates at the shipment level (Layer 2) and *aggregates up* to produce company-level totals (Layer 1). One data entry, two outputs. The SMB never has to think about which standard applies where.

**Early signal on enterprise operationalization:** Smart Freight Centre's "Sustainable Logistics Procurement" playbook is guiding large freight buyers to standardize carbon data collection from their carrier networks. Companies like DHL, Amazon, and Maersk already have supplier carbon data programs. Post-Omnibus, these programs will likely converge on VSME as the baseline + ISO 14083 as the procurement-grade standard. 70% of supply chain professionals cite lack of supplier data as their primary Scope 3 barrier (MIT Sloan, 2025).

---
