# Project Walkthrough

## Core positioning

> I already had experience with Microsoft 365, secure AI and healthcare-data workflows, classification quality, IAM, automation, reporting, and technical operations. I built this lab to gain direct, hands-on experience connecting those foundations to Microsoft Purview controls.

## 30-second version

“I built a healthcare data-security and Copilot-readiness lab around Microsoft Purview. Because I did not have an authorized tenant, I separated the evidence into locally implemented automation, detailed Purview designs, and a simulated investigation. I analyzed 14 synthetic cases, passed seven Python tests and twelve PowerShell configuration checks, designed PHI labels and SharePoint/OneDrive DLP, and translated the results into an investigation playbook and 30/60/90-day roadmap. The project gave me defensible hands-on implementation experience without claiming production Purview deployment.”

## 2-minute version

“The scenario is a fictional healthcare technology company preparing for Microsoft 365 Copilot. Its core risks are patient-linked data, inappropriate external sharing, stale or broad access, and over-retained AI evaluation data.

I started with licensing and authorization. The developer sandbox was unavailable and I had no approved work tenant, so I chose a hybrid model. I used only synthetic data and labeled every artifact as implemented locally, designed for Purview, or simulated investigation.

I created a four-level taxonomy and made Highly Confidential – PHI the only initially encrypted label. I designed a small publishing pilot and a SharePoint/OneDrive DLP policy that begins in simulation and later blocks high-confidence external sharing with a business-justified override.

For practical evidence, I built a Python detector and DLP simulator around 14 positive, boundary, false-positive, employee, financial, and negative-control cases. Seven unit tests passed. I also built PowerShell export and configuration-validation scripts; the sanitized sample passed twelve checks with zero failures.

I then investigated a fictional external-sharing event, carefully separating a detection from confirmed access or exposure. Finally, I created lifecycle, Copilot-readiness, executive reporting, and NIST/ISO mapping artifacts. My main production recommendation is to review repository permissions before a limited Copilot pilot. I would validate all designs in an authorized tenant using simulation, least privilege, change control, and real telemetry.”

## 5-minute version

### 1. Problem and evidence boundary

“Contoso Care Assist stores patient-support, transcription-evaluation, employee, and business information across Microsoft 365 and wants to prepare for Copilot. I had no authorized tenant, so the first design decision was an honest evidence model: local implementation, Purview design, and simulated investigation.”

Show: README evidence model and architecture.

### 2. Classification and protection

“I defined Public, Internal, Confidential, and Highly Confidential – PHI. I did not classify every MRN-like string as High automatically. High requires identity, MRN, and clinical context; incomplete combinations go to review. That choice improves precision while still treating identifiable patient records conservatively during human handling.”

“For the label pilot, I encrypt only PHI. I publish to a small role-diverse group so I can test usability. The DLP policy covers SharePoint and OneDrive external sharing, begins in simulation, and progresses to block with justified override after false-positive tuning.”

Show: taxonomy, label design, DLP matrix, and false-positive fixture.

### 3. Local execution

“The Python analyzer processed fourteen synthetic cases. It produced three High, three Medium, five None, and three Review outcomes. Seven tests passed. The PowerShell sample export contained four labels, one publishing policy, and one DLP policy; the validator passed twelve checks.”

“The scripts sanitize output, avoid credentials, and fail safely. Live PowerShell mode is guarded, read-only, and explicitly untested.”

Show: validation results and clean terminal evidence.

### 4. Investigation reasoning

“The simulated case begins with a DLP-like signal, but I do not call that an exposure. I would correlate the matched content, label, sharing configuration, recipient, access events, download evidence, timing, and scope. Severity depends on the evidence. Containment might revoke the link and preserve logs; root cause must explain why the control or process failed, not merely restate that a rule matched.”

Show: investigation case and playbook.

### 5. AI readiness and business response

“Copilot respects the user's existing permissions, so license removal does not remediate overshared SharePoint data. I require owner-approved permission reviews before pilot access. The roadmap starts with ownership and access baselines, then controlled labels and DLP simulation, then evidence-gated Copilot expansion.”

“The project does not prove tenant deployment or compliance. It proves that I can reason about Purview control design, build and test supporting automation, preserve evidence boundaries, and communicate a prioritized implementation plan.”

Show: executive summary, roadmap, and limitations.

## 10-minute version

Use the five-minute sequence, then add:

1. **Architecture:** explain Entra identity, Microsoft 365 data stores, Purview control plane, Copilot inherited access, and the local evidence boundary.
2. **Test engineering:** compare strong positive, boundary, false-positive candidate, and negative control; explain recall versus precision.
3. **Label lifecycle:** distinguish label creation, publication, manual/recommended/automatic application, encryption, and container behavior.
4. **DLP operations:** cover locations, conditions, external-recipient logic, policy tips, alerts, override justification, rollout stages, rollback, and success metrics.
5. **Forensics:** distinguish content detection, availability, sharing, access, download, confirmed exposure, severity, and root cause.
6. **Automation:** explain input validation, risk logic, sanitized output, tests, error handling, PowerShell Sample versus guarded Live mode, and why no credentials are stored.
7. **Lifecycle:** distinguish retention from deletion, retention policies from labels, legal hold, disposition review, and data minimization.
8. **AI readiness:** discuss permissions, unlabeled data, DSPM recommendations, DLP for AI interactions, audit, pilot gates, training, and incident response.
9. **Reporting:** show how technical findings became business impact, owners, target dates, dependencies, metrics, and validation evidence.
10. **Framework mapping:** explain that NIST/ISO alignment organizes evidence but does not prove compliance, certification, or maturity.

Close with: “In an authorized tenant, I would validate the designs through a small pilot, capture sanitized configuration and telemetry evidence, tune detection and user impact, and only then recommend wider enforcement or Copilot expansion.”

## Recommended live demo order

1. README — evidence boundary and demonstrated results.
2. Architecture — system and trust boundaries.
3. Phase 2 screenshots — test engineering and safe data.
4. Validation results — local execution proof.
5. DLP test matrix — policy reasoning and tuning.
6. Simulated case — investigation judgment.
7. Executive summary and roadmap — business communication.
8. Honest limitations — credible close.

Keep the GitHub tabs open in this order. Do not live-run code unless the interviewer asks; screenshots and recorded results reduce demo risk.
