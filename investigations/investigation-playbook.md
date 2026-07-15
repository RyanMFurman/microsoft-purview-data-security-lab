# External Sensitive-Data Investigation Playbook

**Evidence label: DESIGNED FOR PURVIEW**

This playbook describes the workflow an authorized analyst would use. It was not executed against Microsoft 365. Product screens, alert IDs, audit records, users, and telemetry must never be invented or represented as live evidence.

## Investigation lifecycle

Microsoft describes the DLP alert lifecycle as trigger, notify, triage, investigate, remediate, and tune. This playbook translates that lifecycle into an evidence-driven case process.

## 1. Intake and case creation

Record:

- Case identifier and intake timestamp
- Alert source and policy/rule name
- Reporter or automated source
- Assigned analyst and business data owner
- Initial data sensitivity and incident severity separately
- Known affected user, item, workload, and sharing destination
- Evidence-retention requirements

Do not copy raw sensitive values into tickets or email notifications.

## 2. Scope

Define:

- **Actor:** User who initiated the activity
- **Custodian:** User or owner responsible for the source content
- **Data owner:** Business owner authorized to classify and approve access
- **Workloads:** SharePoint, OneDrive, Entra identity, Purview/DLP, and audit sources
- **Time window:** Begin before file creation/upload and extend through containment
- **Related items:** Copies, renamed files, downloads, links, emails, and Teams references
- **Related users:** External target, guests, group members, site owners, and prior recipients

Scope should expand only when evidence supports it.

## 3. Triage questions

1. Does the item actually contain patient-linked healthcare information?
2. Was it merely detected, shared, or actually accessed externally?
3. Was the action blocked, overridden, or allowed?
4. What sharing mechanism was used: named recipient, guest, secure link, or anonymous link?
5. Who had access before and after the event?
6. Is the behavior isolated, repeated, negligent, or apparently malicious?
7. Are there other copies or related activities?

## 4. Evidence sources

| Source | Evidence sought | Required caution |
|---|---|---|
| DLP alert/incident | Policy, rule, match confidence, action, override, user | Alert metadata does not itself prove external access |
| Activity explorer | DLP, label, egress, and file activities | Availability and history depend on licensing and retention |
| Microsoft 365 audit | Sharing, link, access, download, permission, and label events | Distinguish acting user from target user/group |
| SharePoint/OneDrive permissions | Current links, guests, groups, inherited access | Current state might differ from event-time state |
| Content explorer or authorized item review | Confirm sensitive content and label | Requires least-privileged content-viewer authorization |
| Entra ID | Guest identity, group membership, sign-in context | Authentication does not alone prove file access |
| User/data-owner interview | Intent, workflow, authorization, business need | Treat statements as evidence to corroborate, not fact by default |

## 5. Search plan

### Audit activities to consider

- Sharing invitation or shared-file activity
- `AnonymousLinkCreated`
- `SecureLinkCreated`
- `AddedToSecureLink`
- File access, download, modification, deletion, or rename
- Sensitivity label applied, changed, downgraded, or removed
- DLP rule match and override activity where available

Exact activity names and availability must be verified in the authorized tenant's audit activity picker and current Microsoft documentation.

### Designed audit filters

- Date/time window
- SharePoint or OneDrive workload
- Acting user
- Sanitized item identifier or URL
- Sharing and access operations
- External target type or guest identity

### Designed content-search concept

Search for the known synthetic filename, MRN pattern, custodian, and date range. A production search requires legal/privacy authorization, appropriate roles, documented scope, and evidence-handling controls.

### Illustrative Microsoft Purview eDiscovery KQL content query

```text
(filename:"synthetic-patient-data.csv" OR "MRN-HCA-100001")
AND (lastmodifiedtime>=2026-07-14 AND lastmodifiedtime<=2026-07-15)
```

This syntax targets document content and indexed SharePoint/OneDrive properties in a Microsoft Purview eDiscovery search. `FileName` scopes by file name, the quoted MRN is a full-text keyword, and `LastModifiedTime` constrains when the item was changed. It is not a Microsoft Sentinel query or Unified Audit Log query. This example was not executed; a production analyst must confirm the workload, indexed properties, date boundaries, permissions, and returned sample before relying on it.

Source: [Keyword queries and search conditions for eDiscovery](https://learn.microsoft.com/en-us/purview/ediscovery-keyword-queries-and-search-conditions)

## 6. Evidence preservation

- Preserve original alert and audit exports in an access-controlled case location.
- Hash exported files when organizational procedures require integrity verification.
- Record collector, source, time, query, filters, timezone, and export format.
- Work from copies; do not modify originals.
- Use UTC in the authoritative timeline and note local-time conversions.
- Apply case retention or legal hold only with authorized legal/records direction.
- Maintain chain-of-custody notes for evidence transferred between people or systems.

## 7. Exposure determination

Use precise language:

| Evidence state | Permitted conclusion |
|---|---|
| DLP match only | Sensitive-content policy condition matched |
| Sharing attempt blocked; no override | Attempted disclosure was prevented; no external access demonstrated |
| External link created | Content was made externally available; access still requires verification unless anonymous-link risk dictates otherwise |
| External `FileAccessed`/download evidence correlated to target | External access is supported by audit evidence |
| Missing or expired logs | Exposure cannot be determined; state the evidence gap |

Never translate “no evidence found” into “proof that no access occurred.”

## 8. Severity framework

Assess independently:

- Data sensitivity and volume
- External availability and verified access
- Sharing mechanism
- Control outcome: blocked, overridden, or allowed
- User intent and repeated behavior
- Recipient risk and contractual relationship
- Ability to contain
- Evidence confidence

Suggested incident severity:

- **Low:** False positive or no sensitive content; no external availability
- **Medium:** High-sensitivity sharing attempt blocked; no access evidence; isolated behavior
- **High:** Sensitive content externally available, override used, or access uncertain with material exposure potential
- **Critical:** Verified external access/download, large volume, anonymous/public exposure, malicious behavior, or ongoing uncontrolled disclosure

## 9. Containment

- Revoke external and anonymous links.
- Remove unauthorized guests or direct permissions.
- Preserve evidence before destructive remediation where possible.
- Confirm DLP/label state and prevent reshare.
- Notify the data owner, privacy, legal, security, or management according to the severity matrix.
- Isolate related copies if evidence supports expanded scope.
- Avoid disabling an account unless identity or malicious-activity evidence supports it.

## 10. Root-cause analysis

Evaluate:

- User intent and training
- Overshared site or inherited permissions
- Missing or incorrect label
- DLP scope, confidence, exception, or enforcement gap
- Business process lacking an approved external-transfer path
- Excessive group or guest access
- Inadequate data-owner governance

Use “five whys” or a causal tree, but do not end at “user error” when process or control design contributed.

## 11. Remediation and tuning

- Correct permissions and links.
- Confirm classification and label.
- Tune the DLP rule using precise corroboration/proximity.
- Review overrides and repeated behavior.
- Provide targeted user coaching.
- Create an approved de-identification or secure-transfer workflow.
- Expand review to related content only when justified.
- Rerun positive, boundary, false-positive, and negative tests.

## 12. Closure criteria

- Exposure determination is explicit and evidence-backed.
- Containment is validated.
- Data owner accepts classification and remediation.
- Evidence gaps and limitations are documented.
- Root cause addresses people, process, permissions, and technology.
- Rule tuning does not create unacceptable false negatives.
- Owners and due dates are assigned.
- Lessons learned feed policy and training updates.

## Sources

- [Investigate DLP alerts](https://learn.microsoft.com/en-us/purview/dlp-alert-investigation-learn)
- [DLP Alerts dashboard](https://learn.microsoft.com/en-us/purview/dlp-alerts-dashboard-get-started)
- [SharePoint and OneDrive sharing auditing](https://learn.microsoft.com/en-us/purview/audit-log-sharing)
- [Activity explorer](https://learn.microsoft.com/en-us/purview/data-classification-activity-explorer)
- [Official SC-401 hosted instructions](https://microsoftlearning.github.io/SC-401T00-Information-Security-Administrator/)
