# Screenshot Evidence

Store only sanitized evidence here.

Allowed evidence categories:

- **IMPLEMENTED LOCALLY** — terminal output, local test results, and generated reports.
- **DESIGNED FOR PURVIEW** — diagrams or configuration specifications, never screenshots implying deployment.
- **SIMULATED INVESTIGATION** — clearly watermarked fictional evidence.

Never commit tenant IDs, domains, user email addresses, tokens, credentials, session details, or real sensitive data.

## Phase 2 capture checklist

All Phase 2 screenshots use the label **IMPLEMENTED LOCALLY**.

| Suggested filename | Evidence to show | Acceptance criteria |
|---|---|---|
| `phase-2-case-coverage.png` | Patient and employee case-type counts | Both commands succeed; patient total is 8 and employee/public total is 6 |
| `phase-2-safety-validation.png` | Reserved email-domain check and duplicate-ID check | `UNSAFE_EMAILS=0` and `DUPLICATE_IDS=0` are visible |
| `phase-2-data-preview.png` | Sanitized CSV rows or VS Code preview | Strong positive, boundary, false-positive, and negative cases are visible; no personal path or unrelated files |

Before capture, use `Set-Location` to give the PowerShell prompt a neutral label and avoid exposing the Windows username:

```powershell
Set-Location "$HOME\OneDrive\Documents\Playground\microsoft-purview-data-security-lab"
function prompt { "PS PURVIEW-LAB> " }
Clear-Host
```

Do not commit screenshots containing failed commands as successful validation. Troubleshooting screenshots may be retained separately only if they are redacted and clearly described as failures.

## Phase 2 evidence captured

All files below are **IMPLEMENTED LOCALLY** and were supplied after the user executed the validation steps.

| File | What it proves | What it does not prove |
|---|---|---|
| `phase-2-case-coverage.png` | Both CSV files load and contain the planned positive, boundary, false-positive, negative, employee, financial, and public categories | Purview detection or policy execution |
| `phase-2-safety-validation.png` | No populated email uses a nonreserved domain and no test-case ID is duplicated | That every possible synthetic value is recognized by Microsoft Purview |
| `phase-2-phi-tp-001.png` | A strong-positive fixture combines identity, MRN, SSN-style, and clinical context | A live PHI finding |
| `phase-2-phi-bd-001.png` | A boundary fixture contains identity and MRN context without diagnosis | A confirmed high-risk event |
| `phase-2-phi-fp-001.png` | An MRN-like value can occur in nonpatient campaign context | A real false-positive alert |
| `phase-2-phi-tn-001.png` | A public negative control contains no patient identifier or clinical record | A live DLP nonmatch |

The screenshots use the neutral `PS PURVIEW-LAB>` prompt and contain no tenant identifiers or production telemetry.

## Final evidence-audit requirement

Phase 12 must inventory completed and missing evidence across every phase. Any capture that cannot be produced automatically must be presented to the user as an exact command/view, expected result, evidence label, filename, and redaction checklist before the portfolio is declared recruiter-ready.
