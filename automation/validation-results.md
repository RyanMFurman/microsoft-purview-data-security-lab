# Phase 7 Local Validation Results

**Evidence label: IMPLEMENTED LOCALLY**

Execution date: 2026-07-14

These results were produced locally against synthetic CSV files and a sanitized sample JSON configuration. They are not Microsoft Purview results or tenant telemetry.

## Python analysis

Command:

```powershell
python .\automation\Analyze-SensitiveData.py
```

Result:

```text
Analyzed 14 synthetic cases.
Sharing-state mode: per scenario
Sharing-state counts: internal=6, external=8
Risk counts: high=3, medium=3, none=5, review=3
Action counts: allow=9, audit_and_review=3, block_with_business_justified_override=2
Exit code: 0
```

## Python unit tests

Command:

```powershell
python -m unittest discover -s .\automation\tests -v
```

Result:

```text
7 tests passed
Exit code: 0
```

Covered behavior:

- Fourteen unique cases load.
- Every case has a valid row-level sharing state, and the standard run produces exactly two modeled block actions.
- External strong PHI receives High plus the D1 modeled action.
- `PHI-TP-003` remains High sensitivity but is allowed by the external-sharing rule because its scenario is internal.
- The optional CLI override can deliberately replace scenario-level sharing state.
- Boundary cases remain Review.
- MRN campaign false-positive candidate is not High.
- Public negative control is allowed.
- Employee/financial test rows map to Confidential.
- Internal sharing does not trigger the external-block action.

## PowerShell sanitized export

Command:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\automation\Export-PurviewConfiguration.ps1 -Mode Sample
```

Result:

```text
Labels: 4
Publishing policies: 1
DLP policies: 1
Exit code: 0
```

## PowerShell configuration validation

Command:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\automation\Test-PurviewConfiguration.ps1
```

Result:

```text
Pass: 12
Fail: 0
Exit code: 0
```

Validated controls:

- Expected label names and priority
- PHI-only encryption decision E1
- Pilot publishing decision P1
- DLP policy presence and enabled state
- Simulation mode
- SharePoint and OneDrive locations only
- External-sharing condition

## PowerShell negative-path validation

Command:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass `
    -File .\automation\Test-PurviewConfiguration.ps1 `
    -ConfigurationPath .\automation\samples\purview-configuration.invalid.sample.json
```

Result:

```text
Pass: 8
Fail: 4
Exit code: 2
```

The validator correctly rejected disabled PHI encryption, DLP enforcement instead of simulation, Exchange added to the initial SharePoint/OneDrive scope, and a disabled external-sharing condition. This is an intentionally invalid synthetic fixture, not a tenant configuration.

## Defects found and corrected during validation

1. Dynamic Python module loading did not register the module before processing the dataclass. The test loader now registers the module in `sys.modules`.
2. Windows PowerShell 5.1 evaluated `$PSScriptRoot` too early in parameter defaults. Defaults are now resolved after parameter binding from `$MyInvocation.MyCommand.Path`.
3. Windows PowerShell 5.1 initially rendered the en dash incorrectly. JSON input now explicitly uses UTF-8, while the script constructs the en dash without relying on source-file encoding.

These corrections demonstrate why execution evidence is stronger than untested code.
