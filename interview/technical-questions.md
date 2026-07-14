# Technical Interview Questions

## 1. How would you design a DLP policy without disrupting the business?

Start with the business requirement, data, locations, external-recipient condition, exceptions, and owners. Use simulation first, test true positives and negative controls, review false positives and overrides, tune thresholds, communicate policy tips, and progress enforcement in a small pilot with rollback criteria. A technical match alone does not determine business risk.

## 2. What is the difference between creating and publishing a sensitivity label?

Creating defines the label and its protection behavior. Publishing makes selected labels available to scoped users and groups through a label policy. Manual application is a user action; recommended labeling prompts the user; automatic labeling applies based on configured conditions and licensing. A label that is created but not published is generally unavailable to users.

## 3. Do container labels label every file in a SharePoint site or Team?

No. Container settings govern the site, group, or Team—for example privacy or external-sharing behavior. They do not automatically apply the same sensitivity label and file-level protection to every document stored inside.

## 4. How do you distinguish detection from exposure?

A detection shows content matched technical logic. I next determine whether the content was available to an unintended party, explicitly shared, accessed, previewed, downloaded, or further distributed. Confirmed exposure requires corroborating evidence such as permissions, sharing links, audit events, and recipient activity—not merely a DLP match.

## 5. How would you use content search or eDiscovery?

After authorization and scoping, identify custodians, workloads, dates, keywords, identifiers, and preservation needs. Build narrow searches, validate samples, document query changes, preserve chain of custody, and export only when authorized. eDiscovery is for defensible identification, preservation, review, and export; it is not a substitute for incident triage or broad unrestricted searching.

## 6. When are Insider Risk Management and Communication Compliance relevant?

Insider Risk correlates configured signals into risk indicators for authorized privacy-aware investigation; it does not prove malicious intent. Communication Compliance evaluates in-scope communications against configured policies and requires appropriate reviewers, privacy safeguards, and escalation processes. Both require licensing, roles, governance approval, and real telemetry; neither was operated in this lab.

## 7. What does DSPM for AI contribute?

DSPM for AI can provide posture visibility, recommendations, and investigation context for AI-related data risks depending on licensing and connected services. I would review recommendations and establish the evidence baseline before activation or remediation. In this lab, I designed the workflow but did not observe DSPM recommendations or AI telemetry.

## 8. Why review permissions before deploying Microsoft 365 Copilot?

Copilot operates within a user's existing access. It can make already-accessible information easier to find and synthesize, but it does not repair stale groups, broad links, or unnecessary permissions. Removing a Copilot license also does not remediate the underlying SharePoint or OneDrive access.

## 9. How do you manage false positives?

Keep strong-positive, boundary, false-positive-candidate, and true-negative cases. Inspect what actually matched, the surrounding context, confidence, location, sharing state, and user impact. Tune conditions or exceptions narrowly, measure override behavior, and retain human review for ambiguous combinations. Never weaken a rule only to make a test pass.

## 10. Why start a DLP policy in simulation?

Simulation provides evidence about match volume, precision, workload scope, exceptions, user impact, and alert operations before enforcement. Progression should have measurable exit criteria. Simulation does not prove that blocking will behave perfectly, so a controlled enforcement pilot is still required.

## 11. What did the PowerShell automation demonstrate?

Sample mode exported a sanitized model containing four labels, one publishing policy, and one DLP policy. The validator checked label priority, PHI-only encryption, pilot publishing, DLP mode, locations, and external-sharing logic; twelve checks passed. Guarded Live mode uses read-only `Get-*` operations but was not executed and requires authorization, roles, modules, and current property validation.

## 12. How would you use KQL in this role?

I would use the query language supported by the specific Microsoft service—for example keyword and property conditions in eDiscovery or KQL in Microsoft Sentinel if Purview or Microsoft 365 signals were routed there. I would begin with a narrow user, workload, event type, and time range; validate field names and sample results; expand carefully; and record the final query. This lab contains query design concepts but no live KQL execution or tenant data.

Example conceptual Sentinel query—not executed:

```kusto
CloudAppEvents
| where Timestamp between (datetime(2026-07-01) .. datetime(2026-07-02))
| where Application in ("Microsoft SharePoint Online", "Microsoft OneDrive for Business")
| where ActionType has_any ("Sharing", "AnonymousLink", "FileDownloaded")
| project Timestamp, ActionType, Application, AccountDisplayName, ObjectName
```

Production use requires the actual connected table schema, authorized identifiers, and validated event semantics.

## 13. How do retention, deletion, retention labels, and legal hold differ?

Retention preserves content for a required period; deletion removes content when allowed. A retention policy applies broadly by location or population, while a retention label can apply record-specific behavior at item level. A legal hold preserves potentially relevant content for a matter and can override normal deletion. Final schedules require legal, privacy, records, security, and business approval.

## 14. How do you report a technical finding to executives?

State the evidence-backed risk, business impact, recommended action, priority, accountable owner, dependencies, target date, success metric, and validation evidence. Separate observed facts from design risk. In this project, unreviewed patient-data access before Copilot is the headline priority, but it is explicitly described as unverified without tenant telemetry.

## 15. Does the NIST/ISO mapping prove compliance?

No. It is a selective evidence crosswalk. Compliance or certification requires organizational scope, applicable requirements, accountable control owners, a risk assessment and treatment process, live implementation evidence, operating-effectiveness testing, and appropriate independent validation.

## 16. You lack production Purview experience. Why should we hire you?

“I would not represent this lab as production experience. I bring Microsoft 365 administration, IAM, secure healthcare and AI workflows, classification-quality analysis, automation, troubleshooting, and executive reporting. I built and executed this lab to connect those foundations to Purview control design and analyst workflows. I can explain every decision, show the local test evidence, identify what remains unvalidated, and describe exactly how I would move into an authorized pilot safely.”

## Questions to ask the interviewer

- Which Purview capabilities and licenses are currently deployed versus planned?
- What are the highest-risk data locations and business processes?
- How are policy simulation, exceptions, overrides, and tuning governed today?
- What evidence sources are available for investigations, and how are cases handed between teams?
- How is Copilot readiness being coordinated across data owners, Entra, SharePoint, privacy, legal, and security?
- What would successful delivery in the first 30, 60, and 90 days look like?
