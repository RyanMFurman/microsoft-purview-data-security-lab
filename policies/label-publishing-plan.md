# Label Publishing Plan

**Evidence label: DESIGNED FOR PURVIEW**

## Evidence boundary

This policy was not created or published in Microsoft Purview. Names below are fictional implementation specifications.

## Policy identity

- **Name:** `Purview Healthcare Lab – Pilot Label Policy`
- **Purpose:** Publish the four approved labels to a small, role-diverse pilot before broader availability.
- **Initial policy mode:** Labels visible to pilot users; conservative policy settings.

## Publishing audience decision

- **P1 — Role-diverse pilot group (recommended):** `Purview-Lab-Pilot-Users`, containing one compliance administrator, one data-security analyst, one patient-support data owner, and two standard employees.
- **P2 — Administrators and analysts only:** Lower exposure but insufficient end-user usability evidence.
- **P3 — All users:** Broadest coverage but inappropriate before validation and training.

**Decision outcome:** P1 selected. Publish to the role-diverse pilot group. Use fictional or authorized test identities only in a future tenant.

## Published labels

1. Public
2. Internal
3. Confidential
4. Highly Confidential – PHI

## Staged settings

### Stage 1 — Visibility and usability

- Publish all four labels to P1 pilot users.
- Default label for files: Internal.
- Default label for email: Internal, subject to workload testing.
- Require justification to remove a label or lower its classification: On.
- Require users to label files and emails: Off initially.
- Require users to apply a label to groups/sites: Out of scope.
- Provide a help link to the internal classification guide.
- Do not configure automatic label application.

### Stage 2 — Controlled behavior

After pilot validation:

- Consider mandatory labeling for pilot users.
- Add recommended labeling for high-confidence PHI conditions.
- Review downgrade justifications and help-desk feedback.
- Validate encrypted-file access, coauthoring, search, mobile use, and recovery.

### Stage 3 — Expansion proposal

Only after approval:

- Expand to a department or business unit.
- Consider container-label designs for restricted SharePoint sites and Teams.
- Run service-side auto-labeling in simulation.
- Do not publish tenant-wide until owners approve support, communications, rollback, and success metrics.

## Success metrics

- All pilot users see the intended labels in priority order.
- At least one synthetic example is correctly classified at each level.
- PHI strong positives receive the expected user decision or recommendation.
- PHI false-positive candidates do not receive automatic PHI classification.
- Unauthorized users cannot open content encrypted under the PHI design.
- Downgrade justifications are meaningful and reviewable.
- Pilot support issues and business exceptions are documented before expansion.

## Dependencies

- Approved E1/E2/E3 encryption decision
- Authorized tenant and feature-level licensing
- Least-privileged Information Protection administration role
- Pilot security group and approved synthetic test identities
- Office client and SharePoint/OneDrive prerequisites
- User guidance, owner approval, support path, and rollback owner

## Communications plan

Tell pilot users:

- Why labels exist and which examples belong at each level
- That Public means approved for release
- That Highly Confidential – PHI is limited to patient-linked healthcare content
- How to request review when uncertain
- Why a downgrade requires justification
- Where to report access or collaboration problems

## Sources

- [Publish sensitivity labels by creating a label policy](https://learn.microsoft.com/en-us/purview/create-sensitivity-labels#publish-sensitivity-labels-by-creating-a-label-policy)
- [Get started with sensitivity labels](https://learn.microsoft.com/en-us/purview/get-started-with-sensitivity-labels)
- [Official SC-401 hosted instructions](https://microsoftlearning.github.io/SC-401T00-Information-Security-Administrator/)
