# DLP Test Matrix

**Evidence label: DESIGNED FOR PURVIEW**

No row represents a real Purview match or alert. The local analyzer validates the project's core detection subset. Advanced sharing, exception, repeated-behavior, human-escalation, and unscannable-content scenarios remain designed test cases for future authorized tenant validation.

| Test | Fixture | Sharing state | Expected rule | Simulation result | Enforcement target | Analyst disposition |
|---|---|---|---|---|---|---|
| DLP-001 | PHI-TP-001 | External | Rule 1 | High match | Block with business-justified override during pilot | Confirmed PHI exposure attempt |
| DLP-002 | PHI-TP-002 | External | Rule 1 | High match | Block with business-justified override during pilot | Confirmed PHI exposure attempt |
| DLP-003 | PHI-TP-003 | Internal only | None for external-sharing rule | No external event | Allow | Sensitive but not externally shared |
| DLP-004 | PHI-BD-001 | External | Rule 1 after contextual classification | High after review | Block with business-justified override during pilot | Confirm patient-record context |
| DLP-005 | PHI-BD-002 | External | Rule 1 or Rule 2 pending classifier confidence | Review | Audit initially | Validate proximity and context |
| DLP-006 | PHI-FP-001 | External | Rule 2 at most | Review, not high | Allow while recorded | False-positive candidate |
| DLP-007 | PHI-TN-001 | External | None | No match | Allow | Public negative control |
| DLP-008 | PHI-TN-002 | Internal only | None | No match | Allow | Internal negative control |
| DLP-009 | PHI-TP-001 | External, approved exception | Rule 1 | High match plus exception | Allow only under approved D1 workflow | Review justification and expiry |
| DLP-010 | PHI-TP-001 | Anonymous link | Rule 1 | Critical external-sharing match | Block without broad exception | Revoke link and investigate |
| DLP-011 | PHI-TP-001 | External, repeated after warning | Rule 1 | Repeat high match | Block/escalate | Investigate repeated behavior |
| DLP-012 | Password-protected/unscannable file | External | Separate unscannable-content condition | Review/high based on policy | Warn or block by approved design | Do not assume safe because scanning failed |

## Required coverage

- True positives
- True negatives
- Boundary cases
- False-positive candidates
- Internal versus external sharing
- Anonymous link
- Approved override
- Repeated behavior
- Unscannable content
- Simulation, warning, override, and blocking outcomes

## Local automation coverage

The Python analyzer directly validates the core fixture and sharing-state behavior represented by DLP-001, DLP-002, DLP-003, DLP-005, DLP-006, DLP-007, and DLP-008. DLP-004 requires a human contextual decision after the analyzer returns Review. DLP-009 through DLP-012 are design-only cases because the local CSV detector does not model an exception registry, anonymous-link telemetry, behavior history, or file-scanning status.

## Local analyzer acceptance criteria

- Every core strong-positive fixture is classified High.
- External strong-positive scenarios receive the modeled block-with-justified-override action.
- Internal `PHI-TP-003` remains High sensitivity but is allowed by the external-sharing rule.
- `PHI-FP-001` and public negatives are never automatically blocked as confirmed PHI.
- External sharing changes action; sensitivity alone does not prove exfiltration.

## Future Purview pilot acceptance criteria

- Approved exceptions require a business justification, owner, scope, and expiry.
- Anonymous links and repeated behavior trigger the designed escalation path.
- Unscannable content receives an explicit handling decision.
- Human-reviewed contextual escalation is documented separately from automated detection.
