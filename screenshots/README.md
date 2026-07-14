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

## Phase 12 evidence audit

| Area | Artifact exists | Visual evidence | Status |
|---|---|---|---|
| Synthetic case coverage and safety | CSVs, guide, validation commands | Six sanitized screenshots | Complete |
| Classification and Purview policy designs | Taxonomy, label, publishing, DLP, lifecycle, AI plans | GitHub-rendered Markdown is sufficient | Complete as design; no tenant screenshot expected |
| Architecture | Markdown overview and Mermaid source | GitHub README Mermaid rendering | Verify after final push |
| Python analysis | Source, tests, recorded results | Clean analysis and 7-test terminal captures | Complete |
| PowerShell sample export and validation | Source, sanitized sample, recorded results | Clean sample-export and 12/12 validation captures | Complete |
| Investigation | Playbook and fictional case | Markdown is explicitly simulated | Complete as simulation; optional rendered capture |
| Executive reporting | Four reports | GitHub-rendered Markdown | Verify after final push |
| NIST/ISO mapping | Selective crosswalk | GitHub-rendered Markdown | Verify after final push |
| Live Purview configuration and telemetry | None | None | Intentionally unavailable; never fabricate |

## Required final captures

Run from the repository root after setting the neutral prompt:

```powershell
Set-Location "$HOME\OneDrive\Documents\Playground\microsoft-purview-data-security-lab"
function prompt { "PS PURVIEW-LAB> " }
Clear-Host
```

### Capture A — Python analysis

**Evidence label:** IMPLEMENTED LOCALLY
**Filename:** `phase-7-python-analysis.png`

```powershell
python .\automation\Analyze-SensitiveData.py --sharing-state external |
    Select-String 'Analyzed|Risk counts|Action counts'
```

Expected summary:

```text
Analyzed 14 synthetic cases.
Risk counts: {'high': 3, 'medium': 3, 'none': 5, 'review': 3}
Action counts: {'allow': 5, 'audit_and_review': 6, 'block_with_business_justified_override': 3}
```

### Capture B — Python tests

**Evidence label:** IMPLEMENTED LOCALLY
**Filename:** `phase-7-python-tests.png`

```powershell
python -m unittest discover -s .\automation\tests -v
```

Expected result: seven tests and `OK`.

### Capture C — PowerShell sample export

**Evidence label:** IMPLEMENTED LOCALLY
**Filename:** `phase-7-powershell-sample-export.png`

```powershell
powershell -NoProfile -ExecutionPolicy Bypass `
    -File .\automation\Export-PurviewConfiguration.ps1 -Mode Sample |
    Select-String 'Labels:'
```

Expected result: four labels, one publishing policy, one DLP policy, with Sample mode clearly visible.

### Capture D — PowerShell validation

**Evidence label:** IMPLEMENTED LOCALLY
**Filename:** `phase-7-powershell-validation.png`

```powershell
powershell -NoProfile -ExecutionPolicy Bypass `
    -File .\automation\Test-PurviewConfiguration.ps1 |
    Select-String 'Pass:'
```

Expected result: `Pass: 12`, `Fail: 0`.

### Capture E — GitHub final rendering

**Evidence label:** PORTFOLIO PRESENTATION (derived from mixed, labeled evidence)
**Filename:** `phase-12-github-readme.png`

After the final push, open the repository homepage and capture the title, evidence boundary, demonstrated-results table, and rendered architecture. This proves publication and presentation only; it does not prove tenant deployment.

## Redaction checklist for every capture

- Neutral `PS PURVIEW-LAB>` prompt; no Windows username or personal path.
- No tenant ID, object ID, real domain, SharePoint URL, user identity, token, credential, or session detail.
- No unrelated browser tabs, bookmarks, notifications, desktop content, or account avatar.
- Only synthetic `example.test` data where data is visible.
- Expected success output and evidence boundary are readable.
- Failed commands are not presented as successful evidence.
- Summary filters hide locally generated absolute output paths; keep the full unfiltered results in `automation/validation-results.md`.

## Optional captures

- `phase-12-investigation-case.png`: rendered fictional case with **SIMULATED INVESTIGATION** visible.
- `phase-12-executive-summary.png`: headline risk, evidence boundary, and recommendations.
- `phase-12-nist-iso-mapping.png`: mapping title plus noncompliance disclaimer.

Optional images improve a live walkthrough but are not substitutes for the required local-execution captures.

## Phase 7 evidence captured

All four files are **IMPLEMENTED LOCALLY** and were supplied after the user executed the documented commands.

| File | What it proves | What it does not prove |
|---|---|---|
| `phase-7-python-analysis.png` | The local analyzer processed 14 synthetic cases and produced the documented risk and modeled-action totals | Microsoft Purview classification or DLP execution |
| `phase-7-python-tests.png` | All seven local unit tests passed, including boundary, false-positive, negative-control, and sharing-context behavior | Production classifier accuracy or coverage |
| `phase-7-powershell-sample-export.png` | Sample mode processed four labels, one publishing policy, and one DLP policy | A connection to or export from a Microsoft tenant |
| `phase-7-powershell-validation.png` | The sanitized sample configuration passed 12 design checks with zero failures | Live policy deployment, propagation, or enforcement |

The captures use the neutral `PS PURVIEW-LAB>` prompt and show no personal path, tenant identifier, credential, or production telemetry.
