# Local Automation

## Evidence boundary

**IMPLEMENTED LOCALLY** applies only to executions against the synthetic CSV files and sanitized sample JSON.

The tools do not reproduce Microsoft Purview classification, prove deployment, or produce tenant telemetry. `Export-PurviewConfiguration.ps1` contains a guarded read-only Live mode for future authorized use, but Live mode was not executed in this lab.

## Prerequisites

- Windows PowerShell 5.1 or later for the PowerShell scripts
- Python 3.11 or later for the analyzer and unit tests
- No third-party Python packages
- `ExchangeOnlineManagement` only for future authorized Live export mode

## Python analyzer and local DLP simulator

Run from the repository root:

```powershell
python .\automation\Analyze-SensitiveData.py --sharing-state external
```

Expected behavior:

- Loads both synthetic CSV files.
- Detects MRN, synthetic SSN, payment test number, identity, employee, and clinical indicators.
- Requires MRN + identity + clinical context for automated High.
- Sends partial MRN combinations to Review.
- Models D1 block-with-justified-override only for externally shared High cases.
- Writes sanitized JSON and Markdown reports under `output/python-analysis/`.

Run the unit tests:

```powershell
python -m unittest discover -s .\automation\tests -v
```

Important code blocks:

1. Compiled patterns define narrow synthetic indicators.
2. `analyze_row` separates detection, classification suggestion, risk, and DLP action.
3. `load_rows` rejects missing or duplicate test IDs.
4. `build_report` includes only case IDs and indicator names—not raw sensitive-looking values.
5. `write_report` creates recruiter-readable JSON and Markdown evidence.

Failure scenarios:

- Missing input file → exit 1 with a clear message.
- Missing or duplicate case ID → exit 1.
- Invalid sharing state → command-line validation error.
- Unexpected test result → unit-test failure; do not change expectations merely to make tests pass.

Rollback: generated output is disposable and ignored by Git. Delete `output/python-analysis/` and rerun; source datasets remain unchanged.

## PowerShell sanitized export

Run tested Sample mode:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\automation\Export-PurviewConfiguration.ps1 -Mode Sample
```

It reads `automation/samples/purview-configuration.sample.json` and writes sanitized JSON and CSV inventories under `output/powershell-export/`.

Live mode requires all of the following and remains untested:

- Explicit tenant-owner authorization
- Appropriate licensing and least-privileged roles
- `ExchangeOnlineManagement`
- The deliberate `-Mode Live -AllowLiveReadOnly` switches
- Property mapping validation against current cmdlets

The script uses read-only `Get-*` cmdlets, omits identities and tenant IDs, and disconnects in `finally`.

## PowerShell configuration validation

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\automation\Test-PurviewConfiguration.ps1
```

Checks:

- Four expected enabled labels and correct priority
- E1 PHI-only encryption
- P1 pilot publishing policy
- Healthcare DLP policy enabled in Simulation
- SharePoint/OneDrive-only scope
- External-sharing condition represented

Exit codes:

- `0`: validation passed
- `1`: input or execution error
- `2`: one or more design controls failed

Reports are written under `output/powershell-validation/`.

Rollback: validation is read-only. Remove generated output and correct the sample/design source through review; never “fix” production configuration automatically with this script.

## Sanitization rules

Never export or commit:

- Tenant IDs, object IDs, subscription IDs, or domains
- User email addresses or external-recipient identities
- Tokens, credentials, secrets, or session data
- Raw file content or matched sensitive values
- Unredacted SharePoint or OneDrive URLs

