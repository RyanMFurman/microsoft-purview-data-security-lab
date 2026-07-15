# Screenshot Evidence Register

Only sanitized evidence belongs in this folder.

## Evidence rules

- **IMPLEMENTED LOCALLY** — terminal output, local test results, and generated reports.
- **DESIGNED FOR PURVIEW** — diagrams or specifications, never images implying deployment.
- **SIMULATED INVESTIGATION** — clearly identified fictional evidence.

Never commit tenant IDs, real domains, user identities, tokens, credentials, personal paths, session details, or real sensitive data.

## Synthetic-data evidence

All files in this table are **IMPLEMENTED LOCALLY**.

| File | What it proves | What it does not prove |
|---|---|---|
| `phase-2-case-coverage.png` | Both CSV files load and contain the planned case categories | Purview detection or policy execution |
| `phase-2-safety-validation.png` | No populated email uses a nonreserved domain and no test ID is duplicated | Microsoft classifier coverage |
| `phase-2-phi-tp-001.png` | A strong-positive fixture combines identity, MRN, SSN-style, and clinical context | A live PHI finding |
| `phase-2-phi-bd-001.png` | A boundary fixture contains identity and MRN context without diagnosis | A confirmed high-risk event |
| `phase-2-phi-fp-001.png` | An MRN-like value can appear in nonpatient context | A real false-positive alert |
| `phase-2-phi-tn-001.png` | A public negative control contains no patient identifier or clinical record | A live DLP nonmatch |

## Current automation evidence

| Evidence | Status | Boundary |
|---|---|---|
| Scenario-level Python analyzer | GitHub Actions reruns all 14 row-level scenarios | Demonstration detector, not Purview |
| Seven Python unit tests | GitHub Actions reruns on pushes and pull requests | Local logic only |
| `phase-7-powershell-sample-export.png` | Shows four labels, one publishing policy, and one DLP policy in Sample mode | Not a tenant export |
| `phase-7-powershell-validation.png` | Shows 12 passes and 0 failures for the correct sample | Not live policy enforcement |
| Intentionally invalid PowerShell sample | GitHub Actions requires four failures and exit code 2 | Sanitized negative fixture, not a tenant configuration |

The older Python screenshots were removed when the implementation changed from a global external-sharing default to explicit row-level `sharing_state`. Retaining those screenshots would have advertised stale action totals. The workflow and `automation/validation-results.md` are the current repeatable evidence.

## Neutral terminal setup

Before any optional capture:

```powershell
Set-Location "$HOME\OneDrive\Documents\Playground\microsoft-purview-data-security-lab"
function prompt { "PS PURVIEW-LAB> " }
Clear-Host
```

## Optional current Python capture

```powershell
python .\automation\Analyze-SensitiveData.py |
    Select-String 'Analyzed|Risk counts|Action counts'
```

Expected summary:

```text
Analyzed 14 synthetic cases.
Risk counts: {'high': 3, 'medium': 3, 'none': 5, 'review': 3}
Action counts: {'allow': 9, 'audit_and_review': 3, 'block_with_business_justified_override': 2}
```

## Optional negative-path capture

```powershell
$negativeOutput = powershell -NoProfile -ExecutionPolicy Bypass `
    -File .\automation\Test-PurviewConfiguration.ps1 `
    -ConfigurationPath .\automation\samples\purview-configuration.invalid.sample.json
$negativeExit = $LASTEXITCODE
$negativeOutput | Select-String 'Pass:'
"EXIT_CODE=$negativeExit"
```

Expected result: `Pass: 8; Fail: 4` and `EXIT_CODE=2`. GitHub Actions performs the same exit-code assertion automatically.

## Redaction checklist

- Use the neutral `PS PURVIEW-LAB>` prompt.
- Hide Windows usernames and personal paths.
- Show no tenant ID, object ID, real domain, SharePoint URL, user identity, token, credential, or session detail.
- Show only synthetic `example.test` data if data is visible.
- Do not present failed commands as successful evidence.
- Make the evidence boundary and expected result readable.

## Portfolio presentation boundary

The public README, Mermaid source, and referenced image assets were verified after publication. GitHub presentation proves publication only; it does not prove Microsoft 365 tenant deployment or telemetry.
