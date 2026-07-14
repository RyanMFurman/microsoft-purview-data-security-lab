# Data Lifecycle and Retention Plan

**Evidence label: DESIGNED FOR PURVIEW**

## Evidence and legal boundary

This is an illustrative implementation plan. No retention policy, retention label, record declaration, disposition review, legal hold, or deletion action was configured in Microsoft Purview.

The proposed periods are lab assumptions—not legal advice and not a claim of HIPAA, employment-law, NIST, ISO, contractual, or records-management compliance. Final schedules require written approval from Legal, Privacy, Records Management, Security, and the responsible business owner for every applicable jurisdiction and contract.

## Practical lifecycle schedule

| Data class | Example | Proposed lab period and trigger | Purview control design | End action | Owner | Primary risk addressed |
|---|---|---|---|---|---|---|
| Patient-support records | Patient cases, support notes, approved correspondence | **Illustrative: 7 years after case closure**, pending legal validation | Event-based retention label; consider record declaration for approved final records | Disposition review, then approved deletion | Patient Support + Records + Privacy | Premature deletion and uncontrolled over-retention |
| AI transcription-evaluation data | Synthetic/approved evaluation transcripts, annotations, quality scores | **90 days after evaluation completion (R1)** | Short-duration retention label scoped to evaluation repository | Delete after period unless approved exception/hold | AI Evaluation Data Owner | PHI/PII accumulation and model-evaluation reuse beyond purpose |
| Employee records | Onboarding, role, payroll-support, performance documents | **Illustrative: 7 years after separation**, pending jurisdictional validation | Event-based retention label triggered by separation | Disposition review for designated records, then deletion | People Operations + Legal | Employment evidence loss and excessive former-worker data |
| Security investigation records | Case notes, evidence register, findings, remediation | **Illustrative: 3 years after case closure**, unless legal/contractual need requires longer | Retention label; declare final case record where approved | Disposition review, then deletion | Security + Legal + Records | Loss of defensible investigation evidence |
| Public marketing data | Approved releases, web copy, campaign artifacts | **Illustrative: 2 years after superseded/withdrawn** | Retention policy or metadata-driven label | Delete obsolete working copies; preserve designated archive record if approved | Marketing + Records | Stale content and needless storage |

## Key distinctions

### Retention versus deletion

- **Retention** preserves content for a required period even if a user edits or deletes it.
- **Deletion** removes content after business, legal, regulatory, and hold requirements are satisfied.
- A design can retain only, delete only, or retain and then delete.
- A hold or another retention requirement can suspend permanent deletion.

### Retention policy versus retention label

| Control | Best use |
|---|---|
| Retention policy | Broad baseline coverage for an entire workload, site, mailbox, group, or scoped population |
| Retention label | Item-level schedule, event-based trigger, record declaration, exception handling, or disposition review |

This plan uses broad policies for baseline content and labels for patient, employee, investigation, and AI-evaluation records that need distinct triggers or outcomes.

### Sensitivity label versus retention label

- Sensitivity label: classification, markings, encryption, and access intent.
- Retention label: how long content is kept and what happens afterward.
- A file can need both because access protection and lifecycle are separate problems.

### Records management

Declaring an item as a record can restrict editing and deletion and adds record-focused auditing and disposition evidence. Regulatory-record settings are more restrictive and can be irreversible; they are not proposed without a validated legal requirement and specialized review.

### Legal hold

A legal or eDiscovery hold preserves relevant content for a matter even when the normal schedule would permit deletion. Only authorized legal/eDiscovery personnel should initiate, modify, or release a hold. The lifecycle schedule resumes only as applicable after hold release.

## Data minimization rules

- Collect only fields necessary for the approved purpose.
- Prefer de-identified or synthetic data for AI evaluation.
- Separate evaluation data from production patient-support repositories.
- Prevent “temporary” extracts from becoming unmanaged permanent copies.
- Remove redundant copies when the authoritative record is confirmed.
- Limit access while retained; retention does not justify broad access.
- Validate deletion across exports, downstream copies, and approved backups where technically and contractually applicable.

## Over-retention risks

- Larger exposure impact during compromise
- More content available through oversharing or AI grounding
- Higher eDiscovery, storage, review, and remediation costs
- Outdated or inaccurate records influencing decisions
- Data used beyond its original approved purpose

“Keep everything” is not a neutral choice.

## Disposition review design

For patient-support, employee, and final investigation records:

1. Purview identifies content reaching the end of its approved period.
2. A designated reviewer confirms record category, holds, ongoing business need, and ownership.
3. The reviewer approves deletion, extends/relabels under approved authority, or escalates uncertainty.
4. The organization preserves disposition evidence according to its records program.

Do not let the content creator serve as the only reviewer for high-value records.

## AI transcription retention decision

- **R1 — 90 days after evaluation completion (recommended):** Strong minimization; requires prompt validation and exception handling.
- **R2 — One year after evaluation completion:** Supports longer comparison and audit work but increases exposure and reuse risk.
- **R3 — Retain until project closure plus an owner-defined period:** Flexible but less consistent and harder to automate.

**Decision outcome:** R1 selected for raw or patient-linked evaluation artifacts. Preserve only approved, de-identified aggregate metrics longer when they remain useful.

## Designed implementation sequence

1. Inventory data owners, repositories, record categories, legal requirements, contracts, and existing holds.
2. Obtain approved schedules and event definitions.
3. Start with a nonproduction pilot and synthetic content.
4. Create baseline policies and item-level labels according to approved design.
5. Validate event triggers, user deletion behavior, search, holds, disposition, and deletion timing.
6. Train owners and reviewers.
7. Monitor unlabeled content, expired items, review queues, exceptions, and failed deletions.
8. Expand only after Legal, Privacy, Records, Security, and business approval.

## Success measures

- 100% of in-scope data classes have an approved owner and schedule.
- Raw AI evaluation data is deleted or excepted after the approved period.
- No item under hold is deleted by normal lifecycle processing.
- Disposition reviews have an owner, decision, and evidence.
- Exceptions are time-bounded and periodically reviewed.
- Retention does not expand access permissions.

## Sources

- [Data Lifecycle and Records Management overview](https://learn.microsoft.com/en-us/purview/manage-data-governance)
- [Records Management](https://learn.microsoft.com/en-us/purview/records-management)
- [Implement and manage retention training](https://learn.microsoft.com/en-us/training/modules/purview-implement-manage-retention/)
- [Retention end actions](https://learn.microsoft.com/en-us/purview/retention-label-flow)
