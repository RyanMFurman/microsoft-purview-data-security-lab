# NIST and ISO Control Mapping

> **DESIGNED FOR PURVIEW** — Illustrative architecture and control mapping. This is not evidence of certification, an audit, legal compliance, or deployment in a Microsoft 365 tenant.

## Purpose and interpretation

This appendix connects the lab's implemented local evidence, Purview designs, and simulated investigation to selected security-control concepts. A mapping means that an artifact could help design or assess a control; it does not mean the fictional organization has implemented the control effectively.

Organizational validation would require an approved control scope, accountable owners, live configuration evidence, operating-effectiveness testing, risk acceptance, legal and records-management review, and independent audit evidence.

## Evidence labels

- **IMPLEMENTED LOCALLY**: executed code or locally validated workflows.
- **DESIGNED FOR PURVIEW**: detailed configuration or operating design that was not deployed.
- **SIMULATED INVESTIGATION**: fictional events and evidence used to demonstrate analysis.

## Illustrative NIST CSF 2.0 mapping

| NIST CSF 2.0 outcome | Project control or artifact | Evidence label | What the evidence supports | What remains unproven |
|---|---|---|---|---|
| GV.OC-03 — legal, regulatory, and contractual requirements are understood and managed | Lifecycle approval gates and project limitations | **DESIGNED FOR PURVIEW** | Requires legal, privacy, records, security, and business-owner approval | No requirements assessment or legal determination occurred |
| GV.RM-01 — risk-management objectives are established and agreed to | Project charter, success criteria, risk matrix, and roadmap | **DESIGNED FOR PURVIEW** | Documents risk objectives and evidence-gated priorities | No enterprise risk acceptance or governance approval |
| ID.AM-07 — inventories of data and corresponding metadata are maintained | Synthetic data inventory, personas, assets, and data flows | **IMPLEMENTED LOCALLY** / **DESIGNED FOR PURVIEW** | Demonstrates an inventory method using synthetic assets | No Microsoft 365 content inventory or discovery scan |
| PR.AA-05 — permissions and entitlements are defined, managed, enforced, and reviewed with least privilege | Copilot pilot access-review gate and role-based label publishing plan | **DESIGNED FOR PURVIEW** | Defines owner approval and least-privilege review before pilot access | No Entra, SharePoint, or OneDrive permission review was executed |
| PR.DS-01 and PR.DS-02 — data at rest and in transit are protected | PHI sensitivity-label encryption design and external-sharing DLP design | **DESIGNED FOR PURVIEW** | Specifies protection behavior and external-sharing controls | No label encryption or DLP enforcement occurred in a tenant |
| PR.DS-10 — confidentiality, integrity, and availability of data in use are protected | Classification taxonomy, handling rules, and Copilot readiness gates | **DESIGNED FOR PURVIEW** | Defines handling expectations while users and AI services access data | No production enforcement or Copilot telemetry |
| DE.CM-09 — computing environments and their data are monitored for adverse events | DLP alert design, Python detector, and configuration validation | **IMPLEMENTED LOCALLY** / **DESIGNED FOR PURVIEW** | Local detector and validation logic were executed; monitoring was designed | No live Purview alerts, audit stream, or production telemetry |
| RS.AN-03 — analysis establishes what occurred and the root cause | External PHI-sharing case and investigation playbook | **SIMULATED INVESTIGATION** | Demonstrates evidence review, exposure determination, and root-cause method | No real event, custodian data, or audit log was analyzed |
| RS.MI-01 — incidents are contained | Containment and remediation steps in the case and playbook | **SIMULATED INVESTIGATION** / **DESIGNED FOR PURVIEW** | Defines access revocation, sharing containment, and policy tuning | No real incident was contained |
| RC.IM-01 — recovery improvements are identified | Lessons learned, remediation playbook, and 30/60/90-day roadmap | **DESIGNED FOR PURVIEW** | Converts findings into owners, priorities, metrics, and validation evidence | No recovery program or corrective action was operated |

## Illustrative ISO/IEC 27001:2022 and 27002:2022 mapping

ISO/IEC 27001 defines requirements for an information security management system; ISO/IEC 27002 provides control guidance. The references below are limited conceptual mappings and must be checked by the organization against its licensed editions, Statement of Applicability, risk treatment plan, and audit scope.

| ISO control concept | Project control or artifact | Evidence label | Alignment rationale | Validation still required |
|---|---|---|---|---|
| 5.12 Classification of information | Four-level classification taxonomy and synthetic detector cases | **IMPLEMENTED LOCALLY** / **DESIGNED FOR PURVIEW** | Classification rules distinguish public, internal, confidential, and PHI content | Business approval, coverage testing, and production accuracy |
| 5.13 Labelling of information | Sensitivity-label design and publishing plan | **DESIGNED FOR PURVIEW** | Specifies label purpose, ordering, markings, protection, and publication | Tenant configuration and user-behavior testing |
| 5.15 Access control; 5.18 Access rights | Personas, least-privilege model, owner-approved Copilot pilot review | **DESIGNED FOR PURVIEW** | Defines access decisions, owners, review gates, and pilot boundaries | Live identity and repository entitlement evidence |
| 5.24–5.26 Incident-management planning, assessment, and response | Investigation playbook, severity logic, containment, and remediation | **SIMULATED INVESTIGATION** / **DESIGNED FOR PURVIEW** | Demonstrates a repeatable analyst workflow | Approved response process and real operational testing |
| 5.28 Collection of evidence | Evidence register, preservation steps, and evidence labels | **SIMULATED INVESTIGATION** / **DESIGNED FOR PURVIEW** | Separates facts, inference, simulation, and chain-of-custody needs | Legally approved evidence procedures and real preservation tooling |
| 5.33 Protection of records | Lifecycle schedule, disposition review, and legal-hold distinction | **DESIGNED FOR PURVIEW** | Defines ownership and retention/disposition decision gates | Legal, privacy, records, and business approval |
| 8.10 Information deletion | Lifecycle deletion actions and validation expectations | **DESIGNED FOR PURVIEW** | Addresses data minimization and defensible deletion | Live deletion, exception, hold, and proof-of-disposal testing |
| 8.12 Data leakage prevention | Healthcare external-sharing DLP policy and test matrix | **DESIGNED FOR PURVIEW** / **IMPLEMENTED LOCALLY** | Detailed policy logic is backed by local synthetic test cases | Purview simulation, alert quality, overrides, and enforcement telemetry |
| 8.15 Logging; 8.16 Monitoring activities | Audit-evidence requirements, DLP alert design, PowerShell validation | **IMPLEMENTED LOCALLY** / **DESIGNED FOR PURVIEW** | Local validation ran and production logging requirements are specified | Tenant log sources, retention, alert routing, and operating effectiveness |

## Coverage limitations

- This is a selective mapping, not a complete NIST CSF Organizational Profile or ISO Statement of Applicability.
- Local tests validate demonstration logic, not Microsoft Purview's classification engine.
- Designed controls have no live configuration, propagation, enforcement, or telemetry evidence.
- Simulated evidence cannot establish a real exposure, incident, or response outcome.
- Control ownership, frequency, exceptions, risk acceptance, and operating effectiveness require organizational decisions.
- HIPAA or other legal compliance is not asserted.

## Recommended organizational validation

1. Confirm applicable obligations and scope with legal, privacy, records, risk, and business owners.
2. Build a NIST CSF Current Profile and Target Profile using verified organizational evidence.
3. Map ISO controls through the organization's risk assessment, treatment plan, and Statement of Applicability.
4. Pilot Purview designs with authorized synthetic content, least privilege, simulation mode, and rollback criteria.
5. Collect configuration, telemetry, access-review, incident, training, exception, and effectiveness evidence.
6. Have control owners and independent assurance functions validate conclusions.

## Interview explanation

“I created a selective crosswalk from the lab artifacts to NIST CSF 2.0 outcomes and ISO 27001/27002 control concepts. I separated locally executed evidence, Purview designs, and simulated investigation material. The mapping shows how the project could support a control program, but I would never call it compliance or certification; an organization must validate scope, ownership, live implementation, and operating effectiveness.”

## Authoritative references

- [NIST Cybersecurity Framework 2.0](https://doi.org/10.6028/NIST.CSWP.29)
- [NIST Cybersecurity Framework resources](https://www.nist.gov/cyberframework)
- [ISO/IEC 27001:2022 overview](https://www.iso.org/standard/27001)
- [ISO/IEC 27002:2022 overview](https://www.iso.org/standard/75652.html)

Reference identifiers were reviewed for this illustrative mapping on 2026-07-14. Organizations should verify the current authoritative publications and any licensed standards before adoption.
