# GreenTrail - Insights Tracker

_Daily insights from Wilson (PM) and Jessica (Research), running through Monday April 13._

## Format

| Date | Author | Insight | Category |
|------|--------|---------|----------|
| 2026-04-08 | Wilson | The airline offset analogy is the "why now" framing - consumers already accept per-transaction carbon visibility; logistics is the next industry to adopt this | Market Framing |
| 2026-04-08 | Wilson | This is an integration play, not a data collection problem - shipment data already exists in TMS/carrier systems | Architecture |
| 2026-04-08 | Wilson | CSRD 2027 creates a hard buying trigger with a fixed deadline - rare in B2B SaaS | Go-to-Market |
| 2026-04-09 | Wilson | Competitive landscape reveals a “missing middle” — all tools target enterprise, leaving SMBs in a dead zone. GreenTrail’s wedge is simplicity + price, not features | Competitive Strategy |
| 2026-04-09 | Jessica | ISO 14083 + GLEC + CountEmissionsEU converge into one compliance requirement; GLEC default factors enable zero-friction onboarding; GreenTrail’s real value is compliance-as-a-service | Standards & Compliance |

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
