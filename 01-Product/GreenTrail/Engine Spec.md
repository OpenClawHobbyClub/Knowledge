# GreenTrail — Emission Calculation Engine Specification

_Authors: Wilson (PM) + Jessica (Research)_
_Status: DRAFT — In Progress_
_Last updated: 2026-04-20_
_Target audience: Marcus (Architect), Dev Team_

---

## 1. Purpose & Scope

This document specifies the GreenTrail Emission Calculation Engine — the core computational component that transforms raw shipment data into ISO 14083-compliant greenhouse gas emission figures.

The engine must:
- Implement the GLEC Framework v3.2 methodology (the only globally recognized implementation guide for ISO 14083:2023)
- Support all major transport modes relevant to European logistics SMBs
- Produce two output types from a single calculation: shipment-level data (for enterprise customers) and company-level aggregates (for VSME B3 compliance)
- Be auditable — every output traceable to its inputs, emission factors, and methodology version

Out of scope for this spec:
- Carbon offset tracking (ISO 14083 explicitly forbids netting offsets against emissions)
- Scope 1+2 non-transport emissions (other tools handle this)
- TMS integration connectors (separate integration spec)

---

## 2. Standards Basis

| Standard | Role | Version |
|----------|------|---------|
| ISO 14083:2023 | Governing standard — methodology for quantification, assignment, allocation, and reporting of GHG emissions across transport chains | 2023 |
| GLEC Framework | Practical implementation guide for ISO 14083; provides mode-specific emission factors and default values | v3.2 (Oct 2025) |
| CountEmissionsEU | EU regulation (political agreement Nov 2025) — mandates ISO 14083 methodology when transport emissions are reported | Draft / in force |
| VSME Standard (EFRAG) | SME sustainability disclosure standard — defines B3 climate data requirements | Delegated act expected July 2026 |

**Key principle from ISO 14083:** The standard permits default emission factors where primary data is unavailable. This is the critical SMB enabler — companies can be compliant from day one using GLEC defaults without needing telematics or fuel card data.

---

## 3. Emission Boundaries

### 3.1 What the Engine Must Calculate

The engine calculates **Well-to-Wheel (WTW)** emissions, composed of:

- **Tank-to-Wheel (TTW):** Direct combustion/operation emissions (tailpipe CO₂, energy use at point of use)
- **Well-to-Tank (WTT):** Upstream emissions from fuel/energy production, refining, and distribution

ISO 14083 requires WTW reporting. GLEC Framework v3.2 provides WTT correction factors by fuel type and region.

> ⚠️ **Important:** Raw ISO 14083 emission factors are known to underestimate methane leakage during fossil fuel production (per IEA research). GLEC Framework v3.2 incorporates updated findings. The engine **must use GLEC factors, not raw ISO 14083 factors**.

### 3.2 GHGs in Scope

Primary: CO₂ equivalent (CO₂e), covering CO₂, CH₄, N₂O

GLEC v3.2 added Module 6 for air pollutants (NOx, PM, SO₂) — this is a **v2 feature**, not MVP.

### 3.3 What Is Excluded

- Carbon offsets and ETS certificates (must NOT be subtracted from reported emissions per ISO 14083)
- Scope 1+2 non-transport sources (e.g., office energy use — out of scope for this engine)

---

## 4. Transport Modes Supported

### 4.1 MVP Scope (v1)

| Mode | Sub-modes | Priority |
|------|-----------|----------|
| Road | Truck (various weight classes), van | 🔴 Must-have |
| Sea | Container, bulk, Ro-Ro, general cargo | 🔴 Must-have |
| Air | Belly cargo, freighter | 🔴 Must-have |
| Rail | Freight rail (diesel + electric) | 🔴 Must-have |

### 4.2 Deferred to v2

| Mode | Notes |
|------|-------|
| Inland waterways | Relevant for Rhine/Danube corridor |
| Pipeline | Niche; low SMB demand |
| Logistics hubs | Warehouses, cross-docking, ports (GLEC Framework covers these) |
| Multimodal chain calculation | MVP handles individual legs; v2 chains them |

---

## 5. Data Quality Tiers

ISO 14083 defines a hierarchy of input data quality. The engine must assign and display a tier label on every calculation.

| Tier | Name | Description | SMB Applicability |
|------|------|-------------|-------------------|
| 1 | Primary | Actual fuel consumption, energy use from operations (e.g., fuel card data, telematics) | Advanced users, v2 feature |
| 2 | Modelled | Calculated from known parameters (vehicle type, route, load factor) | Available at MVP with sufficient input |
| 3 | Default | GLEC v3.2 default emission intensity values | **MVP baseline — all users start here** |

**Design requirement:** Every report, every shipment line, every aggregate figure must display its data quality tier. Auditors and enterprise customers will check this.

**Progressive upgrade path:** The architecture must allow a company to improve their tier over time as they connect better data sources — without requiring a full re-onboarding.

---

## 6. Input Data Schema

### 6.1 Minimum Required Fields (Default/Tier 3 calculation)

| Field | Type | Notes |
|-------|------|-------|
| `shipment_id` | string | User's own reference |
| `date` | date | ISO 8601 |
| `origin_country` | ISO 3166-1 alpha-2 | Used for emission factor region selection |
| `destination_country` | ISO 3166-1 alpha-2 | |
| `transport_mode` | enum | road / sea / air / rail |
| `cargo_weight_kg` | number | Gross weight of goods |
| `distance_km` | number | Optional — engine can estimate if not provided |

### 6.2 Optional Fields (Improve tier from Default → Modelled)

| Field | Type | Notes |
|-------|------|-------|
| `vehicle_type` | string | e.g. "HGV > 32t", "container_ship_large" |
| `fuel_type` | enum | diesel / HVO / electric / LNG / MGO / etc. |
| `load_factor` | float (0-1) | Actual load as % of capacity |
| `actual_distance_km` | number | Overrides estimated distance |
| `empty_return_leg` | boolean | Whether return leg was empty |
| `carrier_id` | string | For carrier-specific emission factor lookup (future) |

### 6.3 Primary Data Fields (v2 — Tier 1)

| Field | Type | Notes |
|-------|------|-------|
| `actual_fuel_consumed_litres` | number | From fuel cards / telematics |
| `actual_energy_kwh` | number | For electric vehicles |
| `actual_co2e_kg` | number | If carrier provides direct emission data |

---

## 7. Calculation Methodology

_Section 7 is being completed by Jessica (Research) — see Section 7 placeholder below._

### 7.1 Core Formula

The fundamental calculation follows GLEC Framework methodology:

```
Emissions (kgCO₂e) = Activity Data × Emission Intensity Factor
```

Where:
- **Activity Data** = transport work performed (typically tonne-km or TEU-km)
- **Emission Intensity Factor** = gCO₂e per tonne-km (mode and fuel-specific, from GLEC v3.2)

Transport work = `cargo_weight_tonnes × distance_km`

### 7.2 Distance Estimation

When actual distance is not provided, the engine must estimate:
- **Road:** Great-circle distance × detour factor (typically 1.2–1.4 for road)
- **Sea:** Port-to-port routing (use established sea lane distances)
- **Air:** Great-circle distance × 1.0 (air routes approximate great-circle)
- **Rail:** Great-circle distance × rail network factor (varies by region)

> 📌 **Architecture decision needed (Marcus):** Do we embed a distance estimation library, call a routing API (Google, OpenStreetMap), or use a lookup table for common lanes? Routing API introduces external dependency and cost; lookup table is faster but limited.

### 7.3 Mode-Specific Emission Intensity Defaults

_[To be completed by Jessica with GLEC v3.2 default emission intensity values by mode, vehicle type, and region]_

Key requirement: the engine must store emission factors in a **versioned, updateable database** — not hardcoded. GLEC updates annually; the engine must be able to apply new factor sets to new calculations without requiring a code deployment.

### 7.4 WTT Uplift Factors

_[To be completed by Jessica — WTT correction factors by fuel type per GLEC v3.2]_

### 7.5 Load Factor Adjustment

When load factor is known, emissions should be allocated to actual cargo weight, not vehicle capacity:

```
Adjusted Emission Intensity = Default Intensity × (Reference Load Factor / Actual Load Factor)
```

GLEC Framework v3.2 provides reference load factors by mode/vehicle type.

### 7.6 Allocation Rules

ISO 14083 requires emissions to be allocated across transport service users (i.e., multiple shippers sharing a truck/vessel). Allocation must follow the GLEC Framework rules:

- **Mass-based allocation** (default): emissions allocated proportional to cargo weight
- **Volume-based allocation**: for low-density goods where volume is the constraining factor
- **TEU-based allocation**: for container shipping

> 📌 **Architecture decision needed:** For MVP, should we default to mass-based allocation only and defer volume/TEU until v2? Most SMB use cases will be mass-based.

### 7.7 Multimodal Chain Calculation

When a shipment uses multiple transport legs (e.g., truck → sea → truck), emissions must be calculated per leg and summed. Allocation must be applied consistently across legs.

_MVP note: v1 handles single-mode shipments. Multimodal chain support is a v2 feature, but the data schema must be designed to accommodate it from day one._

---

## 8. Output Schema

### 8.1 Shipment-Level Output (ISO 14083 structured)

For each shipment:

| Field | Type | Notes |
|-------|------|-------|
| `shipment_id` | string | Echo of input |
| `date` | date | |
| `origin` | string | |
| `destination` | string | |
| `transport_mode` | string | |
| `cargo_weight_kg` | number | |
| `distance_km` | number | Actual or estimated |
| `tonne_km` | number | Calculated |
| `emission_intensity_gco2e_per_tkm` | number | Factor used |
| `ttw_emissions_kgco2e` | number | Tank-to-wheel |
| `wtt_emissions_kgco2e` | number | Well-to-tank |
| `total_wtw_emissions_kgco2e` | number | WTW total |
| `data_quality_tier` | enum | default / modelled / primary |
| `glec_version` | string | e.g. "3.2" |
| `calculation_timestamp` | datetime | When calculated |
| `methodology_notes` | string | Any overrides or assumptions |

### 8.2 Company-Level Aggregate Output (VSME B3 compatible)

For a given reporting period (typically annual):

| Field | Notes |
|-------|-------|
| Total transport emissions (tCO₂e) | Sum of all WTW emissions |
| Breakdown by mode | Road / Sea / Air / Rail |
| Breakdown by data quality tier | % of emissions at each tier |
| GHG intensity ratio | tCO₂e per €M revenue (requires revenue input from user) |
| GLEC version used | For auditability |
| Reporting period | Start/end date |

> 📌 **VSME B3 note:** The VSME standard requires Scope 1+2 totals plus energy consumption — transport emissions are Scope 1 for own-fleet and Scope 3 Category 4 for contracted carriers. The engine must correctly classify emissions by Scope based on whether the user owns the vehicle.

---

## 9. Versioning & Auditability

### 9.1 Emission Factor Versioning

- All emission factors stored with a version identifier (`glec_3.2`, `hbefa_5.1`, etc.)
- Every calculation records which factor version was used
- When GLEC publishes a new version, existing calculations are NOT retroactively updated — only new calculations use new factors
- Users can request a recalculation using updated factors (manual trigger)

### 9.2 Calculation Audit Trail

Every calculation must produce an immutable audit record containing:
- Input data (as received)
- Emission factors applied (with version)
- Calculation steps (intermediate values)
- Output values
- Timestamp and user identifier

This is required for ISO 14083 transparency principles and enterprise customer auditors.

---

## 10. SFC/GLEC Data Access & Accreditation

### 10.1 Emission Factor Data Access

GLEC v3.2 default emission factor data is available through the Smart Freight Centre (SFC):
- Available to SFC members and GLEC-accredited tool providers
- Request form available on SFC website
- Alternative public sources exist for specific modes (HBEFA for road, IMO MEPC81 for sea) — these can bootstrap development while SFC access is pending

**Status:** ⚠️ SFC membership / accreditation application not yet submitted. This is a **P1 dependency** — must be initiated before build starts.

### 10.2 GLEC Tool Accreditation

The SFC offers a GLEC accreditation programme for software tools:
- Provides credibility signal ("GLEC-accredited" badge)
- Recognized by CDP and SBTi
- Required for enterprise sales into sustainability-conscious procurement
- Application involves submitting methodology documentation and sample calculations for review

**Recommendation:** Apply for accreditation during build phase; target having the badge at or shortly after MVP launch.

---

## 11. MVP vs. v2 Feature Split

| Feature | MVP (v1) | v2 |
|---------|----------|----|
| Road emission calculation | ✅ | |
| Sea emission calculation | ✅ | |
| Air emission calculation | ✅ | |
| Rail emission calculation | ✅ | |
| GLEC v3.2 default factors (Tier 3) | ✅ | |
| Modelled data inputs (Tier 2) | ✅ partial | Full coverage |
| Primary data inputs (Tier 1) | ❌ | ✅ |
| Single-mode shipment calculation | ✅ | |
| Multimodal chain calculation | ❌ | ✅ |
| Mass-based allocation | ✅ | |
| Volume/TEU-based allocation | ❌ | ✅ |
| Shipment-level output (ISO 14083) | ✅ | |
| Company-level output (VSME B3) | ✅ | |
| Emission factor versioning | ✅ | |
| Calculation audit trail | ✅ | |
| Air pollutant emissions (NOx, PM, SO₂) | ❌ | ✅ (GLEC v3.2 Module 6) |
| Logistics hub emissions | ❌ | ✅ |
| Inland waterways mode | ❌ | ✅ |
| GLEC/SFC accreditation badge | ❌ (apply during build) | ✅ |

---

## 12. Open Architecture Decisions

These require input from Marcus (Architect) before technical design can be finalized:

| Decision | Options | Recommendation |
|----------|---------|----------------|
| Distance estimation | Embedded library vs. routing API vs. lane lookup table | Routing API (OpenStreetMap/OSRM) — open source, no per-call cost, self-hostable |
| Emission factor storage | Hardcoded vs. database vs. versioned config files | Database with version tracking — required for annual updates |
| Calculation engine language | Language-agnostic spec; Marcus to decide | — |
| Multimodal data model | Single-leg first vs. chain-first schema | Chain-first schema (even for MVP) — avoids painful migration |
| Scope classification | User-declared vs. inferred from vehicle ownership | User-declared at onboarding (own fleet vs. contracted) |
| Allocation method default | Mass-based only (MVP) vs. user-selectable | Mass-based default, user can override in v2 |

---

## 13. Jessica's Research Section

_[Pending — Jessica to complete with detailed GLEC v3.2 methodology, emission factor tables, WTT uplift factors, allocation rule details, and edge cases]_

Topics to cover:
- GLEC v3.2 default emission intensity values by mode/vehicle type/region (road: gCO₂e/tonne-km by truck class; sea: gCO₂e/TEU-km by vessel type; air: gCO₂e/tonne-km by aircraft type; rail: gCO₂e/tonne-km by traction type)
- WTT uplift factors by fuel type (diesel, HVO, LNG, MGO, electric by grid region)
- GLEC reference load factors by mode
- ISO 14083 allocation hierarchy and rules in detail
- Known edge cases: empty returns, repositioning legs, temperature-controlled cargo, air cargo uplift factors for high-altitude radiative forcing
- Data gaps requiring SFC membership vs. publicly available

---

_This document is a living spec. Major decisions and completions should be noted with date and author._
