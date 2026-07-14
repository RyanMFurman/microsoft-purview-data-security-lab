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
