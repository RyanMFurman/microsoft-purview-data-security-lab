# Prioritized Remediation Playbook

**Evidence label: DESIGNED FOR PURVIEW**

## Prioritization model

Order work by patient-data impact, access reduction, dependency value, reversibility, and ability to validate safely.

## Priority 0 — Authorization and baseline

1. Confirm tenant owner authorization, licensing, roles, workloads, data owners, and approved test identities.
2. Inventory patient-data repositories without copying raw sensitive content into project evidence.
3. Capture baseline permissions, links, guests, labels, policy modes, and audit readiness.

**Exit criterion:** Authorized scope and owners documented; unsafe locations isolated from testing.

## Priority 1 — Reduce access and external-sharing risk

1. Assign owner to each in-scope SharePoint/OneDrive repository.
2. Review direct permissions, inherited groups, guests, anonymous/organization links, and nested memberships.
3. Remove stale or unjustified access through change control.
4. Validate business workflows before removal.
5. Recheck permissions after remediation.

**Rollback:** Restore only the specific approved membership/link needed for business continuity; do not restore broad access wholesale.

**Metric:** Critical findings closed; anonymous-link count; owner-review completion.

## Priority 2 — Pilot classification and PHI protection

1. Create labels in approved order.
2. Publish to P1 pilot group.
3. Apply Internal default and downgrade justification.
4. Test E1 encryption with synthetic files and approved identities.
5. Validate unauthorized access, coauthoring, recovery, and mobile/application behavior.

**Rollback:** Remove pilot publication before deleting labels; preserve and recover already encrypted content deliberately.

**Metric:** Label availability, correct application, access-test success, support incidents.

## Priority 3 — Simulate and enforce DLP

1. Test custom MRN definition independently.
2. Run Healthcare Sensitive Data External Sharing Policy in simulation.
3. Review all positive, boundary, false-positive, and negative cases.
4. Tune corroboration and proximity.
5. Enable policy tips.
6. Progress to D1 block with business-justified override.
7. Move proven anonymous/repeat/high-risk cases to no-override blocking.

**Rollback:** Return to simulation; narrow scope; preserve events; revise and rerun test matrix.

**Metric:** Detection coverage, false-positive rate, override rate, repeat events, containment time.

## Priority 4 — Validate investigation and lifecycle

1. Conduct an authorized tabletop using the Phase 6 playbook.
2. Confirm sharing, permission, access, download, label, and DLP evidence.
3. Approve lifecycle schedules.
4. Test R1 90-day AI evaluation handling, holds, exceptions, and disposition.

**Metric:** Evidence completeness, correct severity decisions, disposition backlog, expired exceptions.

## Priority 5 — Gate Copilot pilot

1. Apply G1 owner-approved access gate.
2. Train five role-diverse users.
3. Confirm labels, DLP, audit, retention, support, and response readiness.
4. Use reviewed repositories and synthetic/approved scenarios first.
5. Review DSPM insights and recommendations where licensed.

**Stop condition:** Any unresolved Critical permission or PHI-protection finding.

**Metric:** Reviewed repositories, trained users, unresolved Critical findings, AI DLP matches, response-test results.

## Change-control template

For each remediation record:

- Risk and business impact
- Current and target state
- Owner and approver
- Dependencies and licensing
- Scope and exclusions
- User impact
- Test plan and expected outcome
- Rollback steps and trigger
- Evidence captured
- Target and completion date

