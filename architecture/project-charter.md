# Project Charter

**Evidence label: DESIGNED FOR PURVIEW**

## Purpose

Create an interview-defensible design and local implementation that demonstrates analyst reasoning for Microsoft Purview data security, governance, investigation, and AI readiness without claiming tenant execution.

## Business problem

Contoso Care Assist stores fictional patient-support records, AI transcription-evaluation files, employee records, financial information, and public marketing material across conceptual Microsoft 365 workloads. Inconsistent classification and broad sharing could expose sensitive information, while a planned Copilot pilot could amplify existing access problems.

## In scope

- Exchange Online, SharePoint, OneDrive, and Teams control designs
- Entra identity and least-privilege dependencies
- Sensitivity labels, DLP, lifecycle, audit, investigation, and AI-readiness designs
- Local synthetic-data detection and configuration validation
- Executive and technical reporting

## Out of scope

- Live tenant configuration, telemetry, enforcement, eDiscovery, Insider Risk, Communications Compliance, or DSPM operation
- Endpoint DLP deployment
- Legal conclusions, HIPAA certification, ISO certification, or NIST conformance claims
- Real PHI, PII, credentials, tenant identifiers, or company data

## Deliverables

The repository structure defined in the project README and status file, with locally executable automation, policy specifications, simulated investigation evidence, reports, and interview explanations.

## Constraints

- Complete an interview-ready minimum viable project in one day.
- Prefer high-value, defensible evidence over broad but shallow coverage.
- Treat official SC-401 labs as procedural references, not proof of execution.

## Success criteria

1. Every artifact has a clear evidence status.
2. Synthetic test cases distinguish expected matches, nonmatches, and false-positive risks.
3. At least one Python analyzer and one PowerShell validator execute successfully locally.
4. Label, DLP, lifecycle, and investigation designs include scope, mode, validation, tuning, and rollback.
5. Architecture and reports trace business risks to controls and evidence.
6. The owner can explain each major decision and limitation without overstating experience.

