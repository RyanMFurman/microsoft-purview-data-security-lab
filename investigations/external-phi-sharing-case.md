# Case SIM-2026-001 — Attempted External PHI Sharing

**Evidence label: SIMULATED INVESTIGATION**

> Every user, event, timestamp, alert, identifier, permission, finding, and outcome below is fictional. This case was not created in Purview or Microsoft Defender, and no Microsoft 365 audit log was searched.

## Executive case statement

A fictional standard employee attempted to share `synthetic-patient-data.csv` from a simulated SharePoint patient-support site with a fictional external transcription vendor. The modeled DLP rule detected strong patient-linked healthcare indicators and blocked the action with an override prompt. The employee did not override. Simulated permission review found no active external link or guest permission, and simulated audit review found no external access or download event.

The file sensitivity is **Highly Confidential – PHI**. Incident severity is **Medium** under DEC-010 because the attempt was prevented and no external access is demonstrated.

## Intake

| Field | Simulated value |
|---|---|
| Case ID | SIM-2026-001 |
| Source | Modeled DLP-001 high-confidence match |
| Policy | Healthcare Sensitive Data External Sharing Policy |
| Rule | Rule 1 — High-confidence PHI external sharing |
| Actor | `pilot-standard-user-01` |
| Custodian | `pilot-standard-user-01` |
| Data owner | `patient-support-owner-01` |
| External target | `external-transcription-reviewer-01` |
| Workload | Simulated SharePoint Online |
| Item | `synthetic-patient-data.csv` |
| Classification | Highly Confidential – PHI |
| Initial status | Investigating |

## Scope

- Actor activity from 14:00–16:00 UTC on 2026-07-14
- Source file and any renamed, downloaded, copied, or shared versions
- Simulated Patient Support Pilot site
- Direct permissions, guest membership, secure links, and anonymous links
- DLP match, label, sharing, access, and download events
- Intended external recipient identity

## Simulated timeline

| UTC time | Simulated event | Evidence identifier | Interpretation |
|---|---|---|---|
| 14:02 | Employee uploads synthetic patient spreadsheet | SIM-EVT-001 | Sensitive content enters repository |
| 14:04 | Highly Confidential – PHI label is modeled as applied | SIM-EVT-002 | Business classification established |
| 14:11 | Employee initiates sharing to fictional external recipient | SIM-EVT-003 | External disclosure attempt begins |
| 14:11 | Rule 1 modeled high-confidence match | SIM-EVT-004 | MRN plus identity/clinical context detected |
| 14:11 | Block-with-override prompt displayed | SIM-EVT-005 | Preventive control interrupts action |
| 14:12 | User cancels; no override justification submitted | SIM-EVT-006 | Sharing attempt not completed |
| 14:20 | Analyst accepts simulated case | SIM-EVT-007 | Investigation begins |
| 14:28 | Permission review finds internal membership only | SIM-EVT-008 | No active external permission found in simulation |
| 14:35 | Audit review finds no simulated external access/download | SIM-EVT-009 | No external access demonstrated |
| 14:50 | Data owner confirms vendor lacked approved access path | SIM-EVT-010 | Attempt was unauthorized, apparently nonmalicious |
| 15:10 | User coaching and process remediation assigned | SIM-EVT-011 | Corrective actions initiated |

## Simulated evidence register

| Evidence | Source type | Simulated finding | Limitation |
|---|---|---|---|
| E-001 DLP event | Modeled Purview alert | High-confidence Rule 1 match; action blocked | Not a real alert |
| E-002 source fixture | Local synthetic CSV | Contains multiple fictional patient records | Local fixture, not tenant content |
| E-003 classification | Taxonomy mapping | Highly Confidential – PHI | Designed label, not applied in Purview |
| E-004 permissions snapshot | Fictional SharePoint state | No external guest/link after attempt | Not a real permission export |
| E-005 audit search result | Fictional audit result | No external access/download event found | Absence in simulation is not proof about a real system |
| E-006 user statement | Fictional interview | Intended vendor quality review; unaware of approved workflow | Requires corroboration in a real case |

## Search criteria

- Actor: `pilot-standard-user-01`
- Item: `synthetic-patient-data.csv`
- MRN example: `MRN-HCA-100001`
- Date range: 2026-07-14 14:00–16:00 UTC
- Workloads: SharePoint, OneDrive, Purview DLP, Entra identity
- Activities: sharing invitation, secure/anonymous link, permission change, access, download, label change, DLP match, override

## Sensitive information detected

The local fixture contains fictional combinations of:

- Patient name and date of birth
- MRN
- SSN-style test value
- Email and phone
- Diagnosis and medication

The modeled rule uses corroboration. The MRN pattern alone would not establish a confirmed high-risk match.

## Sharing and access determination

- **Attempted sharing:** Supported by fictional event SIM-EVT-003.
- **DLP intervention:** Modeled as block with override.
- **Override:** Not used.
- **External permission/link:** Not present in the simulated post-event state.
- **External access/download:** No simulated event found.
- **Conclusion:** Attempted disclosure was prevented; external exposure is not demonstrated.

This conclusion must not be shortened to “no breach occurred.” A real investigation would state evidence coverage and retention limitations.

## Severity decision

### S1 — Medium (recommended)

- Data sensitivity is high.
- The sharing attempt was unauthorized.
- The control blocked the action.
- No override, link, guest permission, access, or download is demonstrated.
- Behavior is modeled as isolated and nonmalicious.

**Decision outcome:** S1 selected.

### S2 — High

Use High if organizational policy assigns high severity to every attempted PHI disclosure regardless of control outcome, or if evidence coverage is insufficient enough that exposure remains materially uncertain.

Escalate to High or Critical if a link was created, override used, external access occurred, multiple records were exposed at scale, or behavior was repeated/malicious.

## Containment

Simulated actions:

- Confirm no external link or guest permission exists.
- Retain internal access for authorized patient-support users.
- Preserve the modeled event and case notes.
- Confirm the file remains classified Highly Confidential – PHI.
- Instruct the user not to retry through email, Teams, personal storage, or another channel.

Account disablement is not justified by the simulated evidence.

## Root cause

### Immediate cause

The employee attempted to use ordinary SharePoint sharing for an external transcription-quality workflow.

### Contributing causes

- No clearly documented approved vendor-transfer workflow
- Insufficient role-specific DLP and PHI-sharing training
- Business process relied on identifiable records when de-identified samples could meet the need
- Vendor access and data-owner approval were not integrated into the workflow

Root cause is not recorded simply as “user error.”

## Remediation

| Priority | Action | Owner | Validation |
|---|---|---|---|
| Immediate | Confirm and revoke any external link/permission | SharePoint owner | Permission review |
| Immediate | Preserve case evidence and classification | Data Security Analyst | Evidence register complete |
| 7 days | Coach employee and patient-support team | Data owner | Training acknowledgment and scenario check |
| 14 days | Define approved de-identified vendor-review workflow | Data owner + Privacy | Approved procedure and sample test |
| 14 days | Review DLP override and repeat-event alerts | Compliance Administrator | Test matrix results |
| 30 days | Review pilot site membership and guest settings | Site owner | Access-review evidence |

## Lessons learned

- A blocked event still deserves triage because it reveals workflow pressure and control effectiveness.
- High data sensitivity does not automatically mean high incident severity.
- DLP should direct users to an approved alternative, not merely stop work.
- Permission review and access evidence are necessary before claiming disclosure.
- De-identification can reduce risk when external quality review does not require patient identity.

## Honest interview summary

> I created a simulated case in which a DLP design blocked an external sharing attempt involving synthetic PHI. I separated the high sensitivity of the file from the proposed Medium incident severity because the action was blocked and no external access was demonstrated. I documented which audit, sharing, permission, and access evidence I would collect in production, but I did not claim that any Purview alert or audit record was real.
