# DSPM for AI and Microsoft 365 Copilot Readiness Assessment

**Evidence label: DESIGNED FOR PURVIEW**

## Evidence boundary

This assessment is documentation-only. The lab has no Microsoft 365 Copilot license, authorized tenant, DSPM access, AI telemetry, prompts, responses, data-risk assessment results, recommendations, or one-click policies.

The current Microsoft documentation distinguishes the newer **Data Security Posture Management (DSPM) preview** from **Data Security Posture Management (classic)** and **DSPM for AI (classic)**. A real implementation must verify which experience, features, roles, billing, and licenses are present in the target tenant rather than following screenshots from a different version.

## Executive finding

Copilot readiness is primarily a data-access and governance problem, not just an AI-license deployment. Microsoft 365 Copilot honors existing Microsoft 365 access controls; it can make legitimately accessible but poorly governed content easier to discover and summarize. Therefore, excessive SharePoint/OneDrive permissions, unmanaged sharing links, unlabeled sensitive files, and unclear ownership must be addressed before expanding a Copilot pilot.

## Assessment scope

- SharePoint and OneDrive oversharing
- Sensitivity labels and encryption
- DLP for content and AI interactions
- Entra identity, groups, guests, and least privilege
- Copilot prompt/response auditing and retention
- DSPM visibility and recommendations
- Risky or inappropriate AI activity
- Pilot governance, education, incident response, and success metrics

## Readiness risk register

| Risk | Scenario | Likelihood | Impact | Priority | Proposed treatment |
|---|---|---:|---:|---:|---|
| Overshared repositories | Broad groups or links allow users to discover patient files they do not need | High | High | 1 | Permission inventory, access review, link remediation, owner assignment |
| Unlabeled patient data | PHI files lack classification or persistent protection | High | High | 1 | Publish four-label taxonomy, recommend PHI label, validate E1 encryption |
| Excessive guest access | Former vendors or broad partner groups retain access | Medium | High | 1 | Guest/link review, expiry, sponsor ownership, least privilege |
| Sensitive prompts | User submits patient-linked information to an AI interaction | Medium | High | 2 | DLP simulation, policy tips, approved use guidance, monitoring |
| Inherited permission amplification | Copilot surfaces information that was already accessible but difficult to find | High | High | 1 | Remediate access before pilot; limit pilot to reviewed repositories/users |
| Unmanaged AI apps | Users paste sensitive data into third-party AI sites | Medium | High | 2 | Endpoint/browser DLP design, sanctioned-app guidance, licensing assessment |
| Missing investigation evidence | Prompts, responses, referenced content, or access events cannot be reviewed | Medium | High | 2 | Audit, retention, eDiscovery, roles, and response playbook validation |
| Over-retained AI data | Raw patient-linked evaluation data persists beyond its purpose | Medium | High | 2 | R1 90-day schedule and approved de-identified aggregate preservation |
| Inappropriate AI behavior | Risky, abusive, or noncompliant interactions go undetected | Medium | Medium | 3 | Communication Compliance/Insider Risk design, privacy review, user notice |

Likelihood and impact are design assumptions, not measured tenant findings.

## Copilot inherited-access model

Copilot does not grant a user new permission merely by answering a prompt. However, it can reduce the effort required to locate and synthesize content the user can already access. Consequently:

- Broad SharePoint membership becomes an AI-readiness risk.
- “Anyone” and organization-wide links require review.
- Nested groups and inherited permissions require owner validation.
- Removing a Copilot license does not correct underlying oversharing.
- DLP and labels supplement—but do not replace—permission remediation.

## Readiness workstreams

### 1. Discover and prioritize data

- Identify repositories likely to hold patient-support, transcription, employee, investigation, and financial content.
- Use data classification, Content explorer, Activity explorer, and DSPM where licensed.
- Prioritize patient-linked data and repositories with broad access.
- Assign a business owner to every pilot repository.

### 2. Remediate permissions

- Inventory site members, owners, guests, links, and nested groups.
- Remove stale guests and broad access without a documented need.
- Replace anonymous or organization-wide links with named access where practical.
- Require sponsor/owner review for vendor access.
- Confirm pilot users need access independently of Copilot.

### 3. Classify and protect

- Apply the Public, Internal, Confidential, and Highly Confidential – PHI taxonomy.
- Encrypt confirmed PHI under E1 using centrally assigned usage rights.
- Require downgrade justification.
- Start recommendations and service-side policies in simulation.
- Do not assume a restricted site labels every file it contains.

### 4. DLP for AI-related activity

- Extend tested DLP intent to supported Copilot locations only after license and feature validation.
- Begin in simulation and review prompt/content matches.
- Protect PHI in prompts and referenced content using supported sensitive information types and labels.
- Consider endpoint/browser DLP for pasting sensitive text into supported third-party AI sites.
- Avoid blocking broad healthcare vocabulary without patient context.

Microsoft documents a default DLP policy for the Microsoft 365 Copilot location that initially runs in simulation with policy tips; a real tenant must review and tune it rather than assuming default coverage is sufficient.

### 5. DSPM assessment workflow

In a licensed, authorized tenant:

1. Verify whether the tenant exposes DSPM preview, DSPM classic, or DSPM for AI classic.
2. Assign least-privileged reader/administrator roles.
3. Review setup requirements and analytics processing before opting in.
4. Review sensitive-data locations, unprotected-data insights, oversharing, risky users, AI apps, and recommendations.
5. Validate each recommendation against business context before creating a policy.
6. Record baseline posture metrics.
7. Remediate high-priority access and protection gaps.
8. Remeasure trends after telemetry and propagation periods.

Do not treat a recommendation as proof of an incident or activate a one-click policy without scope, impact, and rollback review.

### 6. Audit, retention, and investigation

- Confirm which Copilot prompts, responses, referenced content, and user actions are audited.
- Apply approved retention to interaction data.
- Define eDiscovery authorization and search procedures.
- Add AI activity to the Phase 6 investigation playbook.
- Correlate prompt/response evidence with access and source-file evidence.
- State telemetry gaps explicitly.

### 7. Insider Risk and Communication Compliance integration

These are future designs, not standalone simulations in this MVP:

- Insider Risk Management can correlate risky AI usage and data-handling indicators where licensed and approved.
- Communication Compliance can review supported generative-AI interactions for sensitive information or conduct risks.
- Both require privacy, legal, HR, employee-notice, role-separation, and reviewer-governance decisions.
- A policy match requires review and must not be treated automatically as malicious intent.

### 8. User education

Pilot users must understand:

- Copilot can use content they are already permitted to access.
- Sensitive data should not be pasted into unapproved AI tools.
- PHI requires the approved label and workflow.
- AI output must be verified before business use.
- Prompts and responses may be auditable, retained, and discoverable according to policy.
- Suspected oversharing or inappropriate output must be reported.

## Pilot gate decision

- **G1 — Gate pilot access on completed permission review (recommended):** Only users and repositories with owner-approved access reviews enter the initial pilot.
- **G2 — Launch a broad pilot and remediate findings afterward:** Faster adoption but exposes inherited permission problems at AI speed.

**Decision outcome:** G1 selected. Use five role-diverse pilot users and only owner-approved, reviewed SharePoint/OneDrive repositories. Do not use “pilot” as a reason to skip access governance.

## Phased pilot

### Before licenses

- Assign owners and review pilot repositories.
- Remove stale links, guests, and excessive groups.
- Publish and test labels.
- Validate DLP simulation and incident routing.
- Approve AI-use policy, retention, training, support, and response process.

### Limited pilot

- Five role-diverse users under G1.
- Reviewed repositories only.
- Synthetic or approved nonproduction test scenarios first.
- Monitor labels, DLP, audit, support, and sharing changes.
- Weekly owner/security review.

### Expansion gate

Expand only when:

- Critical access findings are remediated.
- PHI labeling and encryption tests pass.
- DLP false positives and overrides are within approved thresholds.
- Audit and investigation evidence is retrievable.
- Training is complete.
- Owners accept residual risk.

## Incident response additions

For suspected AI-related exposure:

- Preserve the prompt, response, timestamps, user, app, and referenced-content identifiers where authorized.
- Identify source content and its label, permissions, and sharing history.
- Determine whether AI surfaced already-accessible information or a control failed.
- Revoke inappropriate source access; do not focus only on deleting the AI interaction.
- Search for related prompts, downloads, sharing, and copies.
- Tune permissions, labels, DLP, training, and retention based on root cause.

## Success metrics

- 100% of pilot repositories have named owners and completed access reviews.
- 100% of pilot users complete training.
- Zero unresolved anonymous links in PHI pilot repositories.
- 100% of known PHI fixtures receive expected classification handling.
- DLP false-positive and override rates remain within owner-approved thresholds.
- Audit/investigation test retrieves expected authorized evidence.
- Time to remediate oversharing findings trends downward.
- No pilot expansion with unresolved Critical findings.

## Evidence classification

| Category | Project status |
|---|---|
| Configured | Nothing configured in Microsoft 365 or Purview |
| Observed | No DSPM, Copilot, prompt, response, recommendation, or AI telemetry observed |
| Implemented locally | Synthetic-data analysis, DLP simulation logic, configuration validation, and test results |
| Designed | Copilot readiness, permissions review, DSPM workflow, AI DLP, audit, retention, education, and response |
| Requires licensing | Copilot, DSPM capabilities, advanced Purview features, Insider Risk, Communication Compliance, and feature-specific telemetry as applicable |
| Requires production telemetry | Oversharing trends, risky users, AI app use, prompt matches, recommendations, and posture improvement |

## Sources

- [Microsoft 365 Copilot data and compliance readiness](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-minimum-requirements-data-compliance)
- [Microsoft 365 Copilot data protection architecture](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-architecture-data-protection-auditing)
- [Data Security Posture Management preview](https://learn.microsoft.com/en-us/purview/data-security-posture-management-learn-about)
- [DSPM for AI classic](https://learn.microsoft.com/en-us/purview/dspm-for-ai)
- [Secure Copilot interactions with Purview training](https://learn.microsoft.com/en-us/training/modules/purview-ai-secure-copilot/)
- [Official SC-401 hosted instructions](https://microsoftlearning.github.io/SC-401T00-Information-Security-Administrator/)
