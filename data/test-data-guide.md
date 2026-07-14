# Synthetic Test Data Guide

**Evidence label: IMPLEMENTED LOCALLY**

## Safety statement

Every record in this folder is fictional. Names were invented, email addresses use the reserved `.test` domain, phone numbers use the North American fictional `555-01xx` range, and SSN-style values use prefixes that the Social Security Administration does not issue. `4111111111111111` is a widely used payment-industry test number, not a usable payment credential.

Never replace these values with real patient, employee, customer, credential, tenant, or payment data.

## Dataset purposes

### `synthetic-patient-data.csv`

Supports the primary A1/B1 story: a patient spreadsheet stored in SharePoint or OneDrive contains combinations of identity, medical-record, health, and financial-context fields. It includes strong positives, boundary cases, a contextual false-positive candidate, and true negatives.

### `synthetic-employee-data.csv`

Provides secondary employee PII, financial, internal-only, false-positive, and public-marketing examples for later taxonomy and roadmap work. It deliberately remains smaller than the PHI dataset.

## Test case model

| Type | Purpose | Expected analyst action |
|---|---|---|
| `strong_positive` / `employee_pii` / `financial_test` | Multiple corroborating sensitive elements | Match and prioritize |
| `boundary_case` | Incomplete or lower-context sensitive evidence | Review confidence and business context |
| `false_positive_candidate` | Pattern resembles sensitive data but context contradicts it | Tune or document an exception; do not blindly block |
| `true_negative` / `public_marketing` | Public or operational content without protected data | Do not match |

## Field rationale

| Field | Why included | Control expectation | False-positive concern |
|---|---|---|---|
| Patient name + date of birth | Corroborates identity | Raises confidence when paired with medical data | Names and dates occur in ordinary documents |
| Medical record number | Organization-specific patient identifier | Candidate custom sensitive information type | Generic ticket or campaign codes can share the pattern |
| SSN-style value | Exercises structured PII detection | Sensitive match in appropriate context | Any nine-digit value can resemble an SSN |
| Diagnosis and medication | Adds healthcare context | Supports PHI classification | Medical terms occur in training and public education |
| Email and phone | Identity/contact context | Raises confidence in combination | Shared aliases are not necessarily personal data |
| Payment test number | Exercises financial pattern detection | Sensitive match | Test and example values can generate intended false positives |
| Public marketing text | Negative control | Must remain Public and unblocked | Broad keyword rules might incorrectly flag healthcare words |

## Purview interpretation boundary

**DESIGNED FOR PURVIEW** — A future authorized implementation would compare built-in sensitive information types, named entities, and a custom medical-record-number definition. Purview sensitive information types can combine patterns with corroborating evidence and confidence levels. The local analyzer built later will be a demonstration detector, not an emulation or validation of Microsoft's classification engine.

No result in these CSV files proves that Microsoft Purview would match the same item.

## Expected test outcomes

| Case | Expected local result | Reason |
|---|---|---|
| PHI-TP-001 through 003 | High-risk match | Patient identity, MRN, and clinical context co-occur |
| PHI-BD-001 and 002 | Manual review | Some corroborating fields are absent |
| PHI-FP-001 | Review or suppress | MRN-like campaign code lacks patient context |
| PHI-TN-001 and 002 | No match | Public/operational negative controls |
| EMP-TP-001 and 002 | Match | Employee PII or financial test data |
| EMP-BD-001 and EMP-FP-001 | Review | Identifier does not establish a person by itself |
| PUB-TN-001 and 002 | No match | Approved public content |

## Local validation

From the repository root, run:

```powershell
$patients = Import-Csv .\data\synthetic-patient-data.csv
$employees = Import-Csv .\data\synthetic-employee-data.csv

$patients.Count
$employees.Count
$patients | Group-Object case_type | Select-Object Name, Count
$employees | Group-Object case_type | Select-Object Name, Count
```

Confirm that all nonblank email addresses use `example.test`:

```powershell
Import-Csv .\data\*.csv |
    Where-Object { $_.email -and $_.email -notlike '*@example.test' }
```

Expected output for the second command: no rows.

## Production testing rule

Production testing must never use real sensitive data merely to prove a policy works. Use approved synthetic fixtures, isolated test identities, documented expected outcomes, and authorized locations. Real data increases privacy, breach, retention, discovery, and access-control risk and can turn a control test into an incident.

## Phase 2 decision checkpoint

Decide whether the later local analyzer should treat a standalone MRN-like value as:

- **Option 1 — Review (recommended):** require clinical or identity context for a high-risk result.
- **Option 2 — High risk:** treat any organization-specific MRN pattern as sufficient for a high-risk result.

This decision affects false positives, missed detections, and the later DLP confidence design.

## Phase 2 outcome

- Selected: **Option 1 — Review**.
- Rationale: A technical pattern match is evidence, while risk determination requires identity, clinical, sharing, permission, and exposure context.
- Validation: 8 patient cases and 6 employee/public cases parsed successfully; no duplicate test IDs or nonreserved email domains were found.
- Evidence: Case coverage, safety validation, and representative positive, boundary, false-positive, and negative screenshots are cataloged in `screenshots/README.md`.
- Knowledge demonstrated: False-positive candidates test precision; pattern detection is distinct from risk determination; public rows act as negative controls for operational usability.
