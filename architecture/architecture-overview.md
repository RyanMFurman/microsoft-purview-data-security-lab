# Architecture Overview

**Evidence label: DESIGNED FOR PURVIEW**

## Personas

| Persona | Responsibility | Intended access |
|---|---|---|
| Compliance Administrator | Designs and publishes Purview controls | Least-privileged policy administration |
| Data Security Analyst | Triages alerts and investigates exposure | Read evidence and manage assigned cases |
| Standard Employee | Creates and shares business content | Normal collaboration; policy tips and restrictions apply |
| Data Owner | Approves classification, access, retention, and exceptions | Business-owned repositories and reviews |
| External Recipient | Receives explicitly permitted content | No implicit internal access |
| Executive Stakeholder | Accepts risk and funds remediation | Aggregated reporting, not case-level sensitive evidence |

## Assets

| Asset | Sensitivity driver | Conceptual system |
|---|---|---|
| Patient-support records | Synthetic patient identifiers and medical context | SharePoint, OneDrive, Exchange |
| Transcription evaluation data | Synthetic health conversations and model-quality annotations | SharePoint, Teams |
| Employee records | Synthetic identity and employment fields | SharePoint, Exchange |
| Security investigation records | Case details and evidence | Restricted SharePoint case site |
| Public marketing material | Approved public content | SharePoint public-content library |
| Identity and authorization data | Users, groups, roles, sharing relationships | Microsoft Entra ID |
| AI interaction records | Prompts, responses, and referenced content | Microsoft 365 Copilot and Purview telemetry |

## Trust boundaries

1. **Managed identity boundary:** Entra-authenticated internal users versus unauthenticated or external identities.
2. **Microsoft 365 workload boundary:** Exchange, Teams, SharePoint, and OneDrive store and transmit content under different collaboration models.
3. **External-sharing boundary:** Content leaving internal control requires classification-aware DLP and explicit authorization.
4. **Administrative boundary:** Policy designers and investigators require separate least-privileged roles from standard users.
5. **AI grounding boundary:** Copilot can only surface content a user can access, so excessive permissions become an AI-amplified exposure risk.
6. **Lab evidence boundary:** Local implementations and fictional events are separated from unexecuted Purview designs.

## Data flows

1. Employees create or upload content into Microsoft 365 workloads.
2. Purview classifiers conceptually inspect content for sensitive information types.
3. Sensitivity labels communicate handling requirements and can apply protection.
4. DLP evaluates content, context, destination, user, and policy exceptions.
5. An allowed action proceeds; a risky action can be audited, warned, overridden, or blocked depending on rule design.
6. Audit, alerts, and activity signals conceptually support analyst investigation.
7. Lifecycle controls retain or delete content according to approved schedules.
8. Copilot inherits the requesting user's access; Purview controls and identity hygiene reduce what can be surfaced or disclosed.
9. In this lab, sanitized sample exports feed local validation scripts and simulated events feed the investigation playbook.

## Threat model

| Threat | Example | Primary control family |
|---|---|---|
| Accidental external disclosure | Employee shares a patient spreadsheet externally | Classification, labels, DLP, sharing governance |
| Oversharing | Broad site permissions expose sensitive files | Entra groups, SharePoint permissions, DSPM assessment |
| Misclassification | Sensitive content remains unlabeled | Sensitive information types, labeling guidance, review |
| Excess retention | Old transcription data remains indefinitely | Retention and deletion design |
| Malicious or negligent insider | Bulk download or repeated override | Audit, Insider Risk design, investigation playbook |
| AI-amplified exposure | Copilot surfaces accessible but overshared content | Permission remediation, labels, DLP, DSPM design |
| Evidence misrepresentation | Simulated alert presented as real | Mandatory evidence labels and decision log |

## Assumptions

- The fictional organization uses a commercial Microsoft 365 tenant in the target-state design.
- Final licensing, roles, retention schedules, legal requirements, and business exceptions require organizational validation.
- DLP begins in simulation or audit mode and expands only after tuning.
- Content uses synthetic identifiers; no test requires real sensitive information.

## Limitations

- No portal settings, policy matches, audit records, or AI interactions were observed.
- Product behavior is based on current official documentation and SC-401 workflow analysis.
- Local pattern matching demonstrates analyst automation, not Purview classification parity.
- The architecture is illustrative and not a production deployment blueprint without tenant discovery.

## Architectural decisions and alternatives

### Identity-first control plane

Selected: Entra identity, groups, roles, and access are prerequisites for Purview policy scope and Copilot exposure analysis.

Alternative: Treat Purview as a standalone enforcement system. Rejected because workload permissions determine access before many content controls act.

### Classification before enforcement

Selected: Establish data types and sensitivity labels before blocking actions.

Alternative: Deploy broad external-sharing blocks first. Rejected because it creates user friction without evidence-driven tuning.

### Simulation before enforcement

Selected: Design policies to begin with simulation or audit, review matches, then move through warning and narrowly scoped blocking.

Alternative: Immediate blocking. Reserved only for proven, high-confidence, isolated scenarios with an approved rollback plan.

### Central policy with workload-aware validation

Selected: Define shared classification and DLP intent centrally while testing Exchange, SharePoint, OneDrive, and Teams behavior separately.

Alternative: Independent policy language per workload. Rejected because it creates inconsistent handling, though workload differences still require distinct tests.

### Local evidence adapter

Selected: Sanitized configuration samples and fictional events allow repeatable local validation.

Alternative: Static documentation only. Rejected because executable tests provide stronger interview evidence.

