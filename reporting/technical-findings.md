# Technical Findings

## Rating method

- **Impact:** Potential harm if the risk is realized.
- **Likelihood:** Design estimate based on the fictional scenario, not measured telemetry.
- **Priority:** Combined implementation urgency and dependency value.
- **Evidence status:** Prevents a design assumption from being presented as an observed fact.

## Risk matrix

| ID | Risk | Likelihood | Impact | Rating | Evidence status |
|---|---|---:|---:|---:|---|
| F-01 | Excessive or stale SharePoint/OneDrive access | High | High | Critical | Unverified design risk |
| F-02 | Patient-linked content lacks tested classification/encryption | High | High | Critical | Designed; not deployed |
| F-03 | External PHI sharing lacks tested DLP enforcement | Medium | High | High | Designed; locally modeled |
| F-04 | Copilot pilot proceeds before permission remediation | Medium | High | High | Readiness design risk |
| F-05 | Raw AI evaluation data is retained beyond purpose | Medium | High | High | Lifecycle design risk |
| F-06 | Alert/audit evidence cannot support exposure determination | Medium | High | High | Simulated workflow only |
| F-07 | Configuration drift or disabled controls go unnoticed | Medium | Medium | Medium | Local validator demonstrated |
| F-08 | Broad exceptions or repeated overrides weaken DLP | Medium | Medium | Medium | Policy/test design |

Ratings are illustrative and require organizational validation.

## F-01 — Access governance before Copilot

- **Condition:** Patient-support repositories may contain broad groups, inherited permissions, stale guests, or permissive links.
- **Evidence:** No tenant evidence; risk derived from the business scenario and Copilot inherited-access model.
- **Business impact:** Patient-linked data may be discoverable by users without a need to know, with Copilot reducing discovery effort.
- **Recommendation:** Inventory permissions and links; assign owners; remediate stale/broad access; require G1 approval before pilot access.
- **Owner:** SharePoint Service Owner + Patient Support Data Owner + Entra/IAM.
- **Target:** Before Copilot licensing or pilot enablement.
- **Validation:** Owner-approved access review; zero unresolved anonymous links in PHI pilot repositories.
- **Dependency:** Authorized tenant, site inventory, owner participation.

## F-02 — PHI labels and encryption are untested

- **Condition:** Taxonomy and labels are designed but not created or applied.
- **Evidence:** `classification-taxonomy.md`, `sensitivity-label-design.md`, E1 decision.
- **Business impact:** Users may classify inconsistently; downloaded files may lack persistent protection.
- **Recommendation:** Pilot four labels; default Internal; require downgrade justification; encrypt Highly Confidential – PHI for approved group.
- **Owner:** Compliance Administrator + Data Owner.
- **Target:** First 30 days.
- **Validation:** Label order, visibility, access, coauthoring, recovery, and false-positive tests pass.
- **Dependency:** Licensing, roles, Office/SharePoint prerequisites.

## F-03 — External PHI DLP is not deployed

- **Condition:** Healthcare DLP specification exists but has not generated a live match or alert.
- **Evidence:** Policy design, twelve-case matrix, local Python modeled actions.
- **Business impact:** External sharing could proceed unnoticed or an untested policy could disrupt legitimate work.
- **Recommendation:** Simulation without tips → tune → tips → D1 controlled enforcement → no-override for proven cases.
- **Owner:** Compliance Administrator + Data Security Analyst.
- **Target:** Days 15–60.
- **Validation:** Strong positives detected; negatives allowed; false positives reviewed; overrides tracked.
- **Rollback:** Return to simulation, narrow scope, preserve evidence, retest revised rule.

## F-04 — Copilot readiness depends on access remediation

- **Condition:** DSPM/Copilot telemetry is unavailable and repository readiness is unknown.
- **Evidence:** AI-governance assessment only.
- **Business impact:** Copilot could surface already-accessible but overshared sensitive content.
- **Recommendation:** Apply G1; pilot five users against reviewed repositories only.
- **Owner:** Copilot Program Owner + SharePoint + Security + Data Owners.
- **Target:** Days 30–90.
- **Validation:** Critical access findings closed; training and audit tests complete.

## F-05 — AI evaluation retention needs enforcement

- **Condition:** Raw patient-linked evaluation artifacts may outlive their purpose.
- **Evidence:** R1 lifecycle decision; no live inventory.
- **Business impact:** Increased breach, oversharing, discovery, and secondary-use exposure.
- **Recommendation:** Apply approved 90-day post-completion schedule; preserve only approved de-identified aggregates longer.
- **Owner:** AI Evaluation Data Owner + Privacy + Records.
- **Target:** Days 30–60 after schedule approval.
- **Validation:** Samples expire correctly; holds and exceptions prevent deletion when authorized.

## F-06 — Investigation evidence is unvalidated

- **Condition:** No real audit, DLP, eDiscovery, or permissions evidence was retrieved.
- **Evidence:** SIM-2026-001 and investigation playbook.
- **Business impact:** Analysts could overstate a match as a breach or fail to identify verified access.
- **Recommendation:** Test alert intake, sharing events, access/download evidence, permissions snapshots, preservation, and escalation.
- **Owner:** Data Security Analyst + Audit/eDiscovery Owners.
- **Target:** Days 30–60.
- **Validation:** Authorized tabletop retrieves expected evidence and documents gaps.

## F-07 — Configuration validation provides local control assurance

- **Condition:** Manual inventories can miss naming, priority, mode, scope, and encryption drift.
- **Evidence:** PowerShell validator executed: 12 pass, 0 fail against sanitized sample.
- **Business impact:** Misconfiguration can weaken protection or create unexpected enforcement.
- **Recommendation:** Validate sanitized authorized exports in CI or scheduled analyst workflow; require human approval for remediation.
- **Owner:** Compliance Engineering.
- **Target:** Days 30–60.
- **Validation:** Known-good sample passes; deliberately altered sample produces expected failures.
- **Limitation:** Live property mapping remains untested.

## F-08 — Exceptions and overrides require governance

- **Condition:** D1 allows business-justified overrides during pilot.
- **Evidence:** DEC-009 and DLP policy design.
- **Business impact:** Broad domain exceptions or repeated overrides could normalize PHI disclosure.
- **Recommendation:** Alert on high-confidence overrides; review justifications; escalate repeated behavior; prohibit convenience-based domain exclusions.
- **Owner:** Data Security Analyst + Data Owner.
- **Target:** During pilot.
- **Validation:** Override rate, justification quality, repeat-user activity, and exception expiry reported.

## Known limitations

- No tenant inventory or baseline metrics
- No licensing validation beyond documentation research
- No live Purview, Copilot, DSPM, Audit, eDiscovery, Insider Risk, or Communication Compliance evidence
- No legal validation of retention or healthcare handling requirements
- Local detector is not Microsoft Purview

