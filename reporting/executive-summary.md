# Executive Summary

**Evidence basis: IMPLEMENTED LOCALLY + DESIGNED FOR PURVIEW + SIMULATED INVESTIGATION**

## Purpose

Contoso Care Assist, a fictional healthcare-technology organization, is preparing for Microsoft 365 Copilot while managing patient-support, transcription-evaluation, employee, investigation, and business information across Microsoft 365. This lab evaluates the controls needed to classify patient-linked data, reduce inappropriate external sharing, investigate exposure, limit retention, and improve AI readiness.

## Evidence boundary

No Microsoft 365 tenant was available. No Purview label, DLP policy, alert, audit event, eDiscovery case, DSPM recommendation, or Copilot interaction was configured or observed. Local automation was executed against synthetic data and sanitized configuration samples; the investigation is explicitly simulated; Purview controls are implementation designs.

## Headline risk

**Approved priority under DEC-014:** Unreviewed SharePoint and OneDrive access could expose patient-linked information directly and amplify discovery through Microsoft 365 Copilot. Copilot honors existing access; it does not correct broad groups, stale guests, or permissive sharing links.

## Key findings

| Priority | Finding | Business impact | Evidence status |
|---:|---|---|---|
| 1 | Access and sharing require owner review before any Copilot pilot | Users may discover patient-linked information they do not need | Design risk; no tenant telemetry |
| 1 | PHI classification, encryption, and DLP are not live-tested | External sharing controls may be absent, mis-scoped, or disruptive | Purview design only |
| 2 | AI transcription data needs purpose-limited retention | Raw patient-linked evaluation data can accumulate or be reused beyond purpose | R1 90-day design |
| 2 | Investigation evidence and escalation must be validated | Teams may confuse a policy match, availability, and confirmed access | Simulated case/playbook |
| 3 | Configuration validation can be automated safely | Manual review can miss disabled, misordered, or over-scoped controls | Locally implemented; 12/12 checks passed |

## Demonstrated results

- Four-level taxonomy from Public to Highly Confidential – PHI
- Fourteen synthetic positive, boundary, false-positive, employee, financial, and public cases
- Python detector and external-sharing simulator: 14 cases analyzed
- Seven Python unit tests passed
- PowerShell configuration validator: 12 controls passed, 0 failed
- SharePoint/OneDrive PHI DLP policy and twelve-case test matrix
- Simulated investigation with exposure, severity, root-cause, and remediation decisions
- Copilot-readiness and DSPM implementation plan

These results validate local logic and analyst workflow—not Microsoft Purview behavior.

## Recommended actions

1. Assign owners and review SharePoint/OneDrive permissions, guests, links, and groups for patient-data repositories.
2. Pilot the approved sensitivity labels; encrypt Highly Confidential – PHI only under E1.
3. Run the Healthcare Sensitive Data External Sharing Policy in simulation, tune it, then progress to D1 block with justified override.
4. Gate a five-user Copilot pilot on completed access reviews, training, DLP, audit, and investigation validation.
5. Apply the R1 90-day lifecycle to raw patient-linked AI evaluation data after approved legal/records review.
6. Use sanitized automation to validate policy names, priority, scope, encryption, and mode.

## 90-day outcome

The organization should have reviewed high-risk repositories, tested PHI labels and DLP in a controlled pilot, validated evidence retrieval and response, approved lifecycle schedules, and established measurable gates for Copilot expansion. Production deployment requires licensing, authorization, change control, legal/privacy/records approval, and real tenant telemetry.
