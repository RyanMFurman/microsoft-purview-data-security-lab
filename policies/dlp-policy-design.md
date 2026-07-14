# Healthcare Sensitive Data External Sharing Policy

**Evidence label: DESIGNED FOR PURVIEW**

## Executive intent

Reduce inappropriate external access to patient-linked healthcare files stored in SharePoint Online and OneDrive while preserving legitimate internal collaboration and creating reviewable evidence for analysts.

No DLP policy, match, alert, incident report, restriction, or policy tip in this document was created or observed in Microsoft Purview.

## Policy identity

- **Name:** `Healthcare Sensitive Data External Sharing Policy`
- **Initial locations:** SharePoint Online and OneDrive for Business
- **Initial audience:** Role-diverse pilot users and approved synthetic test locations
- **Excluded workloads:** Exchange, Teams chat, endpoints, Fabric, and AI locations until workload-specific testing is designed
- **Initial state:** Run in simulation mode without policy tips
- **Primary owner:** Compliance Administrator
- **Investigation owner:** Data Security Analyst
- **Business approver:** Patient-support Data Owner

## Business requirement

When a SharePoint or OneDrive item contains confirmed or likely patient-linked healthcare information and is shared outside the organization, the organization needs to detect the event, warn the user during controlled rollout, preserve reviewable evidence, and ultimately restrict external access for high-confidence cases.

## Protected information

| Signal | Proposed implementation | Evidence role |
|---|---|---|
| Organization-specific MRN | Custom sensitive information type matching `MRN-HCA-######` | Primary patient-record signal |
| U.S. SSN | Microsoft built-in sensitive information type | Strong identity signal when context supports it |
| Medical terms and conditions | Microsoft named-entity or relevant built-in classifier, licensing permitting | Clinical context |
| Patient identity context | Name, date of birth, contact information, or custom corroborative keywords | Supporting evidence |
| Sensitivity label | Highly Confidential – PHI | Business classification condition after label rollout |

The local MRN pattern is a demonstration design. A production custom sensitive information type requires representative, approved testing and false-positive analysis.

## Scope and external-recipient logic

The rule applies when:

1. The item is stored in an included SharePoint site or OneDrive account.
2. The item is or becomes shared with people outside the organization.
3. The content meets a high- or medium-confidence PHI condition.

“External” means a guest, anonymous link, external domain recipient, or other identity outside the approved organization boundary. Exact link and guest behavior must be validated in the target tenant.

## Rule design

### Rule 1 — High-confidence PHI external sharing

Match when all are true:

- Content is shared from Microsoft 365 with people outside the organization.
- At least one patient-record indicator exists: confirmed custom MRN or Highly Confidential – PHI label.
- At least one corroborating signal exists: patient identity, SSN, diagnosis, medication, treatment, or medical terminology.

Proposed actions by rollout stage:

| Stage | Action | User experience |
|---|---|---|
| 1 | Simulation without policy tips | No user impact; analyst reviews modeled matches |
| 2 | Simulation with policy tips | User sees warning; modeled block-with-override behavior can be evaluated |
| 3 | Enforce block with business-justified override | D1 selected for the initial enforced pilot |
| 4 | Block without override for proven, narrowly scoped high-confidence PHI | External access restricted; internal access retained according to design |

Alert design:

- Generate a high-severity alert for each high-confidence external-sharing attempt during the pilot.
- Include policy, rule, location, item identifier, user, sharing state, matched information type, label, and action when available.
- Do not place sensitive content values in email notifications or repository evidence.

### Rule 2 — Possible PHI requiring review

Match when:

- An MRN pattern or medical/identity signal is present, but corroborating evidence is insufficient; or
- Content is sensitive but external-sharing status is uncertain.

Action:

- Audit/simulate only.
- Create a medium-severity review event rather than blocking.
- Route recurring false positives to classifier tuning.

This rule preserves visibility without treating detection as confirmed exposure.

## Exceptions

No broad exception is permitted. Candidate exceptions require all of:

- Documented business purpose
- Data-owner approval
- Named recipient or approved partner group
- Approved secure delivery method
- Time-bounded access where supported
- Logged justification
- Periodic exception review

Do not exempt entire domains merely for convenience. Break-glass or legal-response workflows require separate approval and evidence.

## User notification and policy tip

Proposed text:

> This file appears to contain patient-linked healthcare information and is being shared outside the organization. Remove external access or provide an approved business justification. Contact the Data Security team if you believe this is incorrect.

The tip should state the risk and required action without exposing matched sensitive values.

## Incident report and investigation handoff

For each high-confidence pilot match, preserve or record:

- Policy and rule name
- Timestamp and workload
- User and data owner
- Item identifier and location, sanitized for portfolio use
- Sharing link/recipient category
- Matched classifier names and confidence—not raw sensitive values
- Current label and permissions
- User override and justification, if permitted
- Containment status and analyst disposition

These fields become inputs to the Phase 6 simulated investigation.

## Deployment sequence

1. Confirm licensing, roles, approved sites/accounts, test identities, and authorization.
2. Create and independently test the custom MRN information type.
3. Create the DLP policy with SharePoint and OneDrive locations only.
4. Scope it to isolated test repositories and pilot identities where supported.
5. Run in simulation without policy tips.
6. Review all positive, negative, boundary, and false-positive fixtures.
7. Tune conditions and exceptions.
8. Run simulation with policy tips and evaluate override behavior.
9. Obtain data-owner, security, privacy, and change approval.
10. Enforce narrowly, monitor outcomes, and expand only after success criteria are met.

Microsoft states that SharePoint and OneDrive simulation evaluates existing and new/changed items. Simulation does not enforce configured blocking when policy tips are off and is intended for tuning before enforcement.

## False-positive tuning

| False-positive source | Tuning response |
|---|---|
| MRN-shaped campaign or ticket code | Require patient or clinical corroboration within proximity |
| Medical education content | Require patient-record indicator or PHI label |
| Synthetic training fixtures | Keep in isolated test location or document an approved testing exception |
| Shared employee/team alias | Do not treat contact information alone as patient identity |
| Published payment test number | Mark as controlled test data; avoid broad financial rule conclusions |

Do not tune by adding a broad exception that hides genuine exposure.

## Rollback plan

- Change the policy from enforcement to simulation or turn it off.
- Remove or narrow affected pilot locations and identities.
- Revoke unintended external links through the workload's sharing controls.
- Preserve alerts, changes, and analyst decisions before modification.
- Notify pilot users and support owners.
- Correct the rule in a new simulation version before replacing the prior version.

Rollback does not automatically reverse every sharing permission or remove protection already applied by sensitivity-label encryption.

## Change management

- Named policy owner and backup owner
- Versioned configuration and decision log
- Peer review by security and patient-support data owner
- Privacy/legal review before production use
- Pilot communications and support path
- Approved maintenance window for enforcement changes
- Post-change validation and documented rollback criteria

## Success metrics

- 100% of strong-positive external-sharing cases detected in local simulation logic
- 0 public negative controls classified as high-confidence PHI
- 100% of standalone MRN cases retained for review rather than silently ignored
- Documented disposition for every high-severity pilot alert
- Measured false-positive rate and override rate before enforcement expansion
- No unapproved broad tenant or workload scope
- Mean time to containment and repeat-event rate tracked in a future authorized environment

## Designed portal procedure

**DESIGNED FOR PURVIEW — not executed**

1. Purview portal → Solutions → Data Loss Prevention → Policies → Create policy.
2. Choose a custom policy and enter the policy name and description.
3. Select SharePoint sites and OneDrive accounts only.
4. Limit included locations and users to the approved pilot where supported.
5. Create Rule 1 and Rule 2 using the conditions above.
6. Configure notifications, policy tips, incident reporting, and alerts by rollout stage.
7. Select **Run the policy in simulation mode** without tips.
8. Review simulation overview, items for review, and simulation alerts.
9. Tune and rerun before enabling policy tips or enforcement.

## Sources

- [Learn about DLP simulation mode](https://learn.microsoft.com/en-us/purview/dlp-simulation-mode-learn)
- [Test DLP policies](https://learn.microsoft.com/en-us/purview/dlp-test-dlp-policies)
- [DLP policy reference](https://learn.microsoft.com/en-us/purview/dlp-policy-reference)
- [Sensitive information type definitions](https://learn.microsoft.com/en-us/purview/sit-sensitive-information-type-entity-definitions)
- [Official SC-401 hosted instructions](https://microsoftlearning.github.io/SC-401T00-Information-Security-Administrator/)
