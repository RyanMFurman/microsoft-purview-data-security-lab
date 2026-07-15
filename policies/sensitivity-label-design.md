# Sensitivity Label Design

**Evidence label: DESIGNED FOR PURVIEW**

## Evidence boundary

This is an implementation-ready specification based on current Microsoft guidance and the official SC-401 sensitivity-label workflow. No label was created, published, applied, recommended, or automatically assigned in a tenant.

## Design goals

- Translate the approved four-level taxonomy into understandable user choices.
- Protect patient-linked healthcare content most strongly.
- Keep the first rollout limited to files and emails.
- Avoid automatic enforcement before simulation, testing, and false-positive review.
- Preserve collaboration while requiring justification for downgrades.

## Label order and scope

| Priority | Label | Initial scope | Why |
|---:|---|---|---|
| 0 | Public | Files and emails | Approved unrestricted content |
| 1 | Internal | Files and emails | Normal workforce content and planned default |
| 2 | Confidential | Files and emails | Limited need-to-know business, employee, and financial data |
| 3 | Highly Confidential – PHI | Files and emails | Patient-linked health and care information |

Microsoft Purview treats labels lower in the list as higher priority. Only one sensitivity label can be applied to an item at a time.

Container labels for Teams, Microsoft 365 groups, and SharePoint sites are an expansion design, not part of the initial MVP. Container settings do not automatically apply the same label or protection to files inside a container.

## Detailed settings

### Public

- **User description:** Approved for public distribution. Do not use for drafts or content awaiting approval.
- **Admin description:** Lowest-priority label for formally approved public content.
- **Scope:** Files and emails.
- **Marking:** None.
- **Encryption:** None.
- **Auto-labeling:** None; publication approval is contextual.
- **Downgrade:** Downgrading to Public from a higher label requires justification through the publishing policy.

### Internal

- **User description:** Routine business content intended for employees and authorized internal contractors.
- **Admin description:** Default working label for nonpublic content without a stronger sensitivity driver.
- **Scope:** Files and emails.
- **Marking:** Footer `INTERNAL` in dark gray, small font.
- **Encryption:** None initially; repository permissions provide access control.
- **Auto-labeling:** None; candidate default label in the pilot publishing policy.
- **Downgrade:** Lowering from Confidential or Highly Confidential – PHI requires justification.

### Confidential

- **User description:** Sensitive business, employee, financial, contractual, or security content for authorized recipients only.
- **Admin description:** Limited need-to-know business content; excludes patient-linked healthcare content.
- **Scope:** Files and emails.
- **Marking:** Header and footer `CONFIDENTIAL`; no watermark in the MVP.
- **Encryption:** Decision E1/E2/E3 determines whether encryption is enabled in the initial design.
- **Auto-labeling:** User recommendation only after conditions are tested; no immediate service-side auto-application.
- **Sharing intent:** Named internal groups; external use requires data-owner approval.

### Highly Confidential – PHI

- **User description:** Patient-linked health, treatment, support, transcription, or care information. Internal need-to-know use only.
- **Admin description:** Highest-priority label for confirmed patient-linked healthcare content.
- **Scope:** Files and emails.
- **Marking:** Header and footer `HIGHLY CONFIDENTIAL – PHI`; diagonal watermark with the same text.
- **Encryption:** Required design intent. Assign permissions now to an approved internal PHI users group; do not let users define arbitrary permissions in the MVP.
- **Proposed rights:** Coauthor for approved PHI users; owner/full control limited to designated data owners. Exact rights require authorized tenant testing.
- **Offline access:** Seven days proposed, subject to business continuity testing.
- **Content expiration:** None proposed; lifecycle policy, not label encryption, governs retention.
- **Auto-labeling:** Begin as a user recommendation or service-side simulation. Do not auto-apply until strong-positive and false-positive results are reviewed.
- **Sharing intent:** External access blocked by the later DLP design unless an approved exception and secure delivery path exist.

## Encryption decision

- **E1 — Encrypt Highly Confidential – PHI only (recommended):** Strongest protection for patient-linked data with manageable pilot friction.
- **E2 — Encrypt Confidential and Highly Confidential – PHI:** Broader protection but greater collaboration, search, coauthoring, and external-sharing complexity.
- **E3 — No encryption in the initial design:** Simplest operation but weakens persistent protection if a file leaves its repository.

**Decision outcome:** E1 selected. Encrypt Highly Confidential – PHI only in the initial design.

### Why E1 balances protection and productivity

E1 gives confirmed patient-linked information persistent protection if a labeled file is downloaded or leaves its original repository. It avoids immediately encrypting every Confidential business, employee, financial, or security document, which reduces initial disruption to collaboration, coauthoring, external workflows, mobile access, support, and recovery.

The design uses centrally assigned permissions for an approved PHI group rather than letting users create arbitrary permissions. When sensitivity-label support for SharePoint and OneDrive is correctly enabled, Microsoft services can process supported encrypted files for capabilities such as search, eDiscovery, DLP, and coauthoring. Exact behavior depends on the encryption configuration, file type, client, service settings, and when the file was uploaded or edited.

E1 therefore limits the number of encrypted files that could experience compatibility or indexing problems; it does **not** guarantee search indexability. The pilot must validate search results, eDiscovery discovery, DLP inspection, coauthoring, mobile access, offline access, and recovery with synthetic files before expansion.

## Labeling methods

| Method | Meaning in this design |
|---|---|
| Create label | Define its name, priority, scope, markings, encryption, and optional detection behavior |
| Publish label | Make selected labels available to selected users through a label policy |
| Manual labeling | A user selects the label based on business context |
| Recommended labeling | Office suggests a label; the user accepts or rejects it |
| Automatic labeling | A client or service applies a label under configured conditions; service-side deployment should begin in simulation |
| File/email label | Applies classification and configured protection to an item |
| Container label | Configures privacy and sharing settings for a site, group, or team; it does not label contained files automatically |

## Designed Purview procedure

The following steps are **DESIGNED FOR PURVIEW**, not executed:

1. Open Microsoft Purview portal → Solutions → Information Protection → Sensitivity labels.
2. Create labels in priority order: Public, Internal, Confidential, Highly Confidential – PHI.
3. Select the Files and emails/item scope only for the initial MVP.
4. Configure the descriptions and markings above.
5. Configure encryption for Highly Confidential – PHI only, using centrally assigned usage rights for the approved PHI users group.
6. Confirm that Highly Confidential – PHI is the highest-priority label.
7. Do not create automatic-labeling enforcement during initial label creation.
8. Create the pilot publishing policy described in `label-publishing-plan.md`.
9. Validate label visibility and behavior with synthetic files in an authorized test tenant.
10. Record propagation time, client behavior, access results, downgrade events, and exceptions before expansion.

## Validation matrix for a future authorized tenant

| Test | Expected result |
|---|---|
| Pilot user opens Office label picker | All four published labels appear in priority order |
| Nonpilot user checks label picker | Pilot labels do not appear through this policy |
| New unlabeled document | Internal is proposed/applied according to publishing policy stage |
| User lowers Confidential to Public | Business justification is requested |
| Approved PHI user opens PHI-labeled file | Access succeeds with intended rights |
| Unauthorized internal user opens PHI-labeled file | Access denied |
| External recipient opens PHI-labeled file | Access denied unless explicitly included by an approved design |
| PHI-TP-001 is evaluated | Highly Confidential – PHI recommendation expected after rule design |
| PHI-FP-001 is evaluated | Must not automatically receive the PHI label |

## Rollback design

- Stop or remove the pilot label publishing policy to prevent new user application.
- Do not delete labels as a first rollback action; deleting a label from Purview does not remove existing protection from already labeled content.
- Identify already encrypted content and validate recovery/ownership before changing encryption settings.
- Preserve decision and test evidence before revising label priority or semantics.

## Sources

- [Get started with sensitivity labels](https://learn.microsoft.com/en-us/purview/get-started-with-sensitivity-labels)
- [Learn about sensitivity labels](https://learn.microsoft.com/en-us/purview/sensitivity-labels)
- [Enable sensitivity labels for SharePoint and OneDrive](https://learn.microsoft.com/en-us/purview/sensitivity-labels-sharepoint-onedrive-files)
- [Automatically apply sensitivity labels](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically)
- [Official SC-401 sensitivity-label exercise](https://microsoftlearning.github.io/SC-401T00-Information-Security-Administrator/Instructions/Labs/Lab1_Ex3_sensitivity_labels.html)
