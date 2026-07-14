# DLP Test Matrix

**Evidence label: DESIGNED FOR PURVIEW**

No row represents a real Purview match or alert. Expected outcomes are specifications that will drive local Phase 7 simulation logic and a future authorized tenant test.

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

## Acceptance criteria

- Every expected high-confidence fixture is detected by the later local simulator.
- `PHI-FP-001` and public negatives are never automatically blocked as confirmed PHI.
- External sharing changes action; sensitivity alone does not prove exfiltration.
- Overrides always require a business justification and review.
- Unscannable content receives an explicit handling decision.
