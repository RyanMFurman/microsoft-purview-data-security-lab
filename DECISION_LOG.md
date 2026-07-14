# Decision Log

## DEC-001 — Use a free hybrid implementation rather than a live Microsoft 365 tenant

- **Decision:** Use a free hybrid implementation rather than a live Microsoft 365 tenant.
- **Options considered:** E5 developer sandbox; work tenant; paid tenant or trial; local hybrid simulation.
- **Selected option:** Local hybrid simulation.
- **Reason:** Developer sandbox eligibility was denied, and no authorized production tenant is available.
- **Security benefit:** Eliminates risk to real users, workloads, and sensitive data.
- **Operational risk / limitation:** Live Purview policy deployment and production telemetry cannot be claimed.
- **Mitigation:** Use functional local automation, realistic policy specifications, official Microsoft workflows, detailed testing plans, and explicitly simulated evidence.
- **Interview takeaway:** I evaluated licensing and authorization first, then selected an honest implementation method rather than fabricating access.

## DEC-002 — Require explicit evidence labels

- **Decision:** Label substantive artifacts as **IMPLEMENTED LOCALLY**, **DESIGNED FOR PURVIEW**, or **SIMULATED INVESTIGATION**.
- **Options considered:** Rely on context; label only simulated evidence; label all substantive artifacts.
- **Selected option:** Label all substantive artifacts.
- **Reason:** Reviewers should be able to distinguish execution, design, and simulation immediately.
- **Security benefit:** Improves evidence integrity and prevents misleading claims.
- **Operational risk / limitation:** Adds documentation overhead.
- **Mitigation:** Use the same three labels consistently.
- **Interview takeaway:** I maintained an explicit evidence boundary throughout the project.

## DEC-003 — Start DLP scope with SharePoint and OneDrive

- **Decision:** Limit the initial DLP design to SharePoint and OneDrive.
- **Options considered:** SharePoint and OneDrive; Exchange; Exchange plus SharePoint and OneDrive; Exchange, SharePoint, OneDrive, and Teams.
- **Selected option:** SharePoint and OneDrive first.
- **Reason:** This supports one complete scenario from stored synthetic patient spreadsheet through detection, external-sharing control, investigation, permission review, and Copilot-readiness assessment.
- **Security benefit:** Focuses on PHI exposure, oversharing, and inherited-access risk in collaboration repositories.
- **Operational risk / limitation:** The first implementation does not demonstrate email or Teams controls.
- **Mitigation:** Treat Exchange and Teams as later expansion phases with workload-specific tests.
- **Interview takeaway:** I deliberately narrowed the initial workload scope so I could design, test, tune, and explain one control path deeply before expanding it.

## DEC-004 — Prioritize PHI and patient identifiers

- **Decision:** Make PHI and patient identifiers the initial classification priority.
- **Options considered:** PHI first; PHI, employee PII, and financial data together; broad labels first; AI transcription-evaluation data first.
- **Selected option:** PHI and patient identifiers first.
- **Reason:** PHI is the central scenario risk and provides clear criteria for synthetic positive, negative, boundary, and false-positive tests.
- **Security benefit:** Applies the first detailed controls to the highest-impact information class.
- **Operational risk / limitation:** Employee PII and financial information receive narrower initial treatment.
- **Mitigation:** Include those classes in the four-level taxonomy and roadmap without diluting the primary PHI implementation.
- **Interview takeaway:** I prioritized the highest-impact data and reduced tuning complexity before broadening classification coverage.

## DEC-005 — Treat a standalone MRN pattern as review, not automatically high risk

- **Decision:** Require identity or clinical context before assigning a high-risk result to an MRN-pattern match.
- **Options considered:** Send a standalone MRN match for review; classify every standalone MRN match as high risk.
- **Selected option:** Review a standalone MRN match.
- **Reason:** Pattern detection identifies potential evidence, but accurate risk determination requires context showing that the value represents a patient record rather than a campaign, ticket, training, or example code.
- **Security benefit:** Preserves visibility into possible PHI while using corroborating evidence to prioritize the strongest exposure risks.
- **Operational risk / limitation:** A genuine isolated MRN might initially receive medium severity rather than high severity.
- **Mitigation:** Retain the event for review, combine it with identity and clinical indicators, and monitor false-negative test cases before changing the threshold.
- **Interview takeaway:** I separated technical detection from contextual risk determination instead of treating every pattern match as a confirmed incident.

## DEC-006 — Classify confirmed patient-linked identity plus MRN as Highly Confidential – PHI

- **Decision:** Classify `PHI-BD-001` as Highly Confidential – PHI after review confirms that its MRN belongs to a patient record.
- **Options considered:** Highly Confidential – PHI; Confidential.
- **Selected option:** Highly Confidential – PHI.
- **Reason:** Confirmed patient-linked identity and an MRN require the strongest business handling even without diagnosis, medication, or treatment information.
- **Security benefit:** Reduces the chance that administrative patient records receive weaker sharing and access controls.
- **Operational risk / limitation:** Administrative records may receive higher-friction handling.
- **Mitigation:** Require contextual confirmation so MRN-shaped campaign, ticket, training, and example codes are not automatically treated as patient records.
- **Interview takeaway:** Detector confidence can remain “review” while the final, context-informed business classification becomes Highly Confidential – PHI.

## DEC-007 — Encrypt Highly Confidential – PHI only in the initial design

- **Decision:** Limit initial label encryption to Highly Confidential – PHI.
- **Options considered:** Encrypt PHI only; encrypt Confidential and PHI; defer encryption.
- **Selected option:** E1 — Encrypt Highly Confidential – PHI only.
- **Reason:** Patient-linked data warrants persistent protection, while broader encryption would add collaboration and support complexity before the design is tested.
- **Security benefit:** Centrally assigned usage rights restrict PHI-labeled content to approved users or groups even after a file leaves its repository.
- **Operational risk / limitation:** Encryption can affect coauthoring, offline access, application compatibility, recovery, and authorized external workflows.
- **Mitigation:** Pilot with synthetic content, centrally controlled groups, documented recovery ownership, and explicit access tests.
- **Interview takeaway:** I applied the highest-friction control to the highest-risk class first and separated content usage rights from administrative RBAC roles.

## DEC-008 — Publish labels to a role-diverse pilot group

- **Decision:** Publish the initial label policy to a small group representing administration, investigation, ownership, and standard-user workflows.
- **Options considered:** Role-diverse pilot; administrators and analysts only; all users.
- **Selected option:** P1 — Role-diverse pilot group.
- **Reason:** A mixed pilot produces more representative usability, access, downgrade, and support evidence without tenant-wide impact.
- **Security benefit:** Limits blast radius while testing both privileged and ordinary user behavior.
- **Operational risk / limitation:** Pilot findings might not represent every department or application.
- **Mitigation:** Document gaps and expand by business unit only after success criteria are met.
- **Interview takeaway:** I tested policy administration and end-user behavior before proposing broad publication.

## DEC-009 — Use block with business-justified override during initial DLP enforcement

- **Decision:** Use block with business-justified override for the first enforced pilot stage.
- **Options considered:** D1 block with business-justified override; D2 block without override.
- **Selected option:** D1 — Block with business-justified override.
- **Reason:** The initial rollout needs evidence about false positives and legitimate workflows while still interrupting risky external sharing.
- **Security benefit:** Users must stop and justify the action, and high-confidence attempts remain visible for analyst review.
- **Operational risk / limitation:** Users might misuse overrides or normalize warning bypass.
- **Mitigation:** Alert on each high-confidence override, review justification, track repeated behavior, prohibit broad domain exceptions, and move proven scenarios to no-override blocking.
- **Interview takeaway:** I used progressive enforcement to balance PHI protection, business continuity, and evidence-driven tuning.

## DEC-010 — Assign Medium severity to the prevented PHI-sharing attempt

- **Decision:** Assign Medium incident severity while retaining Highly Confidential – PHI data sensitivity.
- **Options considered:** S1 Medium; S2 High.
- **Selected option:** S1 — Medium.
- **Reason:** The simulated DLP control blocked the action, no override was used, and no external permission, link, access, or download was demonstrated.
- **Security benefit:** Preserves a meaningful response to attempted PHI disclosure while reserving High/Critical escalation for stronger exposure or impact evidence.
- **Operational risk / limitation:** Incomplete telemetry could conceal access or related behavior.
- **Mitigation:** Document evidence coverage, search permissions and access sources, and escalate if a link, override, external access, scale, repetition, or malicious intent is found.
- **Interview takeaway:** I scored data sensitivity separately from incident severity and stated evidence limitations rather than making an unsupported breach conclusion.

## DEC-011 — Require three corroborating categories for automated High

- **Decision:** Require MRN, identity context, and clinical context before the local detector assigns automated High.
- **Options considered:** T1 require all three categories; T2 require MRN plus either identity or clinical context.
- **Selected option:** T1 — MRN plus identity plus clinical context.
- **Reason:** Automated High is defined by the combination of patient-record, identity, and clinical evidence; partial combinations should remain visible for review.
- **Security benefit:** Reduces false-positive automatic blocking while preserving ambiguous matches for analyst evaluation.
- **Operational risk / limitation:** Genuine patient records with incomplete fields might not receive automated High.
- **Mitigation:** Route partial combinations to Review, retain evidence, test false negatives, and allow contextual human classification.
- **Interview takeaway:** I encoded a conservative, explainable threshold and tested boundary behavior instead of treating every pattern match as confirmed PHI.

## DEC-012 — Retain raw patient-linked AI evaluation data for 90 days

- **Decision:** Retain raw or patient-linked AI transcription-evaluation data for 90 days after evaluation completion.
- **Options considered:** R1 90 days; R2 one year; R3 project closure plus owner-defined period.
- **Selected option:** R1 — 90 days.
- **Reason:** The shorter period supports data minimization while leaving a defined window for validation and correction.
- **Security benefit:** Reduces the volume of patient-linked evaluation data available through compromise, oversharing, or unintended AI reuse.
- **Operational risk / limitation:** Less time is available for retrospective analysis.
- **Mitigation:** Preserve approved de-identified aggregate metrics and methodology longer; require documented exceptions or holds for raw-data extensions.
- **Interview takeaway:** I tied retention to purpose and minimized raw AI evaluation data instead of retaining it indefinitely.

## DEC-013 — Require owner-approved permission reviews before Copilot pilot access

- **Decision:** Gate Copilot pilot access on completed, owner-approved permission reviews for users and repositories.
- **Options considered:** G1 permission review before access; G2 broad launch followed by remediation.
- **Selected option:** G1 — Permission review before access.
- **Reason:** Copilot can make already-accessible SharePoint and OneDrive content easier to locate and synthesize, amplifying broad or stale permissions.
- **Security benefit:** Reduces inherited-access exposure before AI use begins.
- **Operational risk / limitation:** Slows pilot onboarding and requires owner participation.
- **Mitigation:** Limit the first pilot to five users and reviewed repositories, use a standard access-review checklist, and timebox owner approval.
- **Interview takeaway:** I treated Copilot readiness as an access-governance program rather than a license deployment.

## DEC-014 — Lead executive reporting with unreviewed patient-data access before Copilot

- **Decision:** Use unreviewed SharePoint/OneDrive access before Copilot as the executive headline risk.
- **Options considered:** X1 unreviewed access before Copilot; X2 external PHI sharing; X3 lack of live Purview capability.
- **Selected option:** X1 — Unreviewed access before Copilot.
- **Reason:** It connects patient-data protection, IAM, collaboration repositories, Purview controls, and AI readiness without claiming that excessive access was observed.
- **Security benefit:** Prioritizes permission remediation before AI can accelerate discovery of already-accessible content.
- **Operational risk / limitation:** The risk is unverified because the lab has no tenant telemetry.
- **Mitigation:** State evidence status explicitly and require owner-approved access reviews and baseline metrics before pilot expansion.
- **Interview takeaway:** I translated an unverified technical risk into an evidence-gated executive priority without presenting it as a production finding.

## DEC-015 — Use evidence-level framework mapping without maturity scoring

- **Decision:** Limit Phase 11 to selected evidence-level mappings between project artifacts, NIST CSF 2.0 outcomes, and ISO/IEC 27001/27002 control concepts.
- **Options considered:** M1 evidence-level mapping; M2 fictional maturity scoring; M3 full compliance matrix.
- **Selected option:** M1 — Evidence-level mapping.
- **Reason:** The lab contains useful local execution, control designs, and simulated investigation evidence, but no live organizational data or operating-effectiveness history.
- **Security benefit:** Makes evidence gaps visible and directs future validation toward live configuration, access, telemetry, ownership, and effectiveness records.
- **Operational risk / limitation:** The selective crosswalk cannot establish certification, compliance, or enterprise control maturity.
- **Mitigation:** State limitations per mapping row and require organizational, legal, risk, control-owner, and independent validation.
- **Interview takeaway:** I used frameworks to organize defensible evidence without turning a portfolio lab into an unsupported compliance claim.
