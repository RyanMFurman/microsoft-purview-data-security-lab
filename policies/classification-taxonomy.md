# Classification Taxonomy

**Evidence label: DESIGNED FOR PURVIEW**

## Purpose and evidence boundary

This four-level taxonomy defines business handling requirements for fictional Contoso Care Assist content. It is a design specification only: no sensitivity label was created, published, applied, recommended, or automatically assigned in Microsoft Purview.

Classification and detection are related but different:

- **Classification** states how the organization intends content to be handled.
- **Detection** identifies evidence that might support a classification.
- **Risk determination** evaluates context, exposure, permissions, destination, volume, and impact.

## Priority order

| Priority | Label | Plain-language rule |
|---:|---|---|
| 0 | Public | Approved for unrestricted public release |
| 1 | Internal | Routine business content intended for the workforce |
| 2 | Confidential | Sensitive business, employee, or financial content with a limited need to know |
| 3 | Highly Confidential – PHI | Patient-linked health or care information requiring the strongest handling controls |

The least restrictive label is listed first and the most restrictive last. This mirrors the Microsoft Purview priority model, in which higher-priority, more restrictive labels appear lower in the label list.

## Label definitions

### Public

| Attribute | Design |
|---|---|
| Business purpose | Identify content formally approved for unrestricted external distribution |
| Example data | Public website copy, approved press releases, webinar announcements, published product descriptions |
| Intended users | Employees, partners, customers, and the general public |
| Sharing restrictions | None after content-owner approval; publication process still applies |
| Encryption behavior | None |
| Content markings | Optional footer: `PUBLIC` only if operationally useful; default recommendation is no marking |
| Container settings | Public container access is a separate site-governance decision; the label must not make an internal site public automatically |
| Auto-labeling suitability | Poor candidate for content-based automatic labeling; publication approval is contextual |
| Exceptions | Draft marketing, embargoed announcements, contracts, security details, or customer-specific content are not Public |
| User impact | Minimal friction; users must understand that “Public” means approved, not merely harmless-looking |
| Potential false positives | Healthcare or AI terminology may appear in public educational material without being sensitive |

### Internal

| Attribute | Design |
|---|---|
| Business purpose | Identify routine operational content intended for authenticated workforce use |
| Example data | General procedures, team notes, internal templates, non-sensitive project updates, shared team aliases |
| Intended users | Employees and authorized internal contractors |
| Sharing restrictions | Internal by default; external sharing requires content-owner review |
| Encryption behavior | None initially; access is controlled through Microsoft 365 permissions |
| Content markings | Footer: `INTERNAL` |
| Container settings | Private team/site by default; external users disabled unless an approved collaboration need exists |
| Auto-labeling suitability | Suitable as a policy default, but weak candidate for content-pattern auto-labeling |
| Exceptions | Employee PII, financial details, credentials, security findings, or patient-linked data require a higher label |
| User impact | Low; serves as the normal working classification |
| Potential false positives | An employee ID or healthcare term alone does not necessarily make content Confidential or PHI |

### Confidential

| Attribute | Design |
|---|---|
| Business purpose | Protect sensitive business, employee, financial, contractual, or security information with limited need-to-know access |
| Example data | Employee onboarding records, test financial information, contracts, nonpublic financial reports, security findings |
| Intended users | Authorized departments, data owners, investigators, and named collaborators |
| Sharing restrictions | Named internal groups by default; external sharing requires documented business justification and owner approval |
| Encryption behavior | Recommended for files leaving managed repositories; exact rights and enforcement are a Phase 4 decision |
| Content markings | Header/footer: `CONFIDENTIAL`; optional watermark for high-risk document types |
| Container settings | Private container, controlled membership, guest access disabled unless explicitly approved |
| Auto-labeling suitability | Recommendation first; automatic application only for high-confidence, well-tested conditions |
| Exceptions | Patient-linked healthcare content is raised to Highly Confidential – PHI; approved public material is lowered only with owner approval |
| User impact | Moderate friction from restricted sharing, possible encryption, and downgrade justification |
| Potential false positives | Test payment numbers, example SSNs, generic employee codes, and public security guidance can resemble sensitive data |

### Highly Confidential – PHI

| Attribute | Design |
|---|---|
| Business purpose | Apply the strongest handling requirements to patient-linked health, support, treatment, or care information |
| Example data | Patient spreadsheet containing identity plus MRN or clinical information; transcription evaluation tied to a fictional patient; investigation evidence containing patient-linked data |
| Intended users | Authorized patient-support personnel, approved data owners, and assigned investigators |
| Sharing restrictions | Internal need-to-know only by default; external sharing blocked unless a formally approved exception and secure delivery method exist |
| Encryption behavior | Required design intent for files and emails; exact users, rights, offline access, and collaboration behavior are Phase 4 decisions |
| Content markings | Header/footer: `HIGHLY CONFIDENTIAL – PHI`; watermark recommended for rendered Office documents |
| Container settings | Private container, controlled membership, no unmanaged guest access, periodic access review, and sharing-link restrictions |
| Auto-labeling suitability | Begin with recommendation or simulation; auto-apply only after high-confidence conditions and false-positive review |
| Exceptions | De-identified, aggregated, or public health education content may receive a lower label after data-owner/privacy review; no automatic downgrade |
| User impact | Highest friction: access restrictions, external-sharing controls, possible coauthoring limitations, and downgrade justification |
| Potential false positives | Medical terms in public education, MRN-shaped campaign codes, synthetic training fixtures, and medication names without patient context |

## Dataset classification exercise

| Test case | Proposed label | Reason |
|---|---|---|
| PHI-TP-001 | Highly Confidential – PHI | Identity, MRN, SSN-style value, and clinical context coexist |
| PHI-BD-001 | Highly Confidential – PHI after contextual review | Identity and MRN identify a patient record even without diagnosis; handling classification must not be confused with detector confidence |
| PHI-BD-002 | Highly Confidential – PHI | MRN and clinical terms create patient-linked health context despite missing a name |
| PHI-FP-001 | Internal or Public depending publication state | MRN-shaped campaign code has explicit nonpatient context |
| PHI-TN-001 | Public | Approved public webinar language without patient information |
| PHI-TN-002 | Internal | Routine office inventory unless formally published |
| EMP-TP-001 | Confidential | Employee identity and SSN-style value require limited access |
| EMP-TP-002 | Confidential | Financial test data exercises restricted handling even though values are synthetic |
| EMP-BD-001 | Internal | Shared alias and employee identifier do not identify a sensitive employee record by themselves |
| EMP-FP-001 | Public if release-approved; otherwise Internal | Project code resembles an employee ID but identifies no person |
| PUB-TN-001 and PUB-TN-002 | Public | Explicitly approved marketing content |

## Classification decision method

Ask these questions in order:

1. Has the content been formally approved for public release?
2. Does it identify or link to a patient, employee, financial record, security matter, or restricted business process?
3. Does it contain healthcare context tied to an identifiable patient or patient record?
4. Who has a legitimate need to know?
5. What harm could result from external access or broad internal access?
6. Is the proposed label based on business context, or merely on one pattern match?

When uncertain, do not silently downgrade. Preserve the current protection and send the item to the data owner or designated reviewer.

## Phase 3 decision checkpoint

How should `PHI-BD-001`—name, date of birth, email, phone, and MRN, but no diagnosis—be classified?

- **C1 — Highly Confidential – PHI (recommended):** Patient-linked identity and MRN are sufficient for the strongest healthcare handling classification, even though automated detection severity might remain “review.”
- **C2 — Confidential:** Reserve the PHI label for content that also includes diagnosis, treatment, medication, or other explicit clinical information.

This is a business classification decision, not a legal conclusion. Final production taxonomy requires privacy, legal, records, security, and business-owner approval.

### Decision outcome

Selected **C1 — Highly Confidential – PHI**. The detector result remains `review` until context confirms that the MRN belongs to a patient record. Confirmation—not the pattern alone—drives the final business classification.

## Sources

- [Get started with sensitivity labels](https://learn.microsoft.com/en-us/purview/get-started-with-sensitivity-labels)
- [Learn about sensitivity labels](https://learn.microsoft.com/en-us/purview/sensitivity-labels)
- [Automatically apply sensitivity labels](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically)
- [Official SC-401 sensitivity-label exercise](https://microsoftlearning.github.io/SC-401T00-Information-Security-Administrator/Instructions/Labs/Lab1_Ex3_sensitivity_labels.html)
