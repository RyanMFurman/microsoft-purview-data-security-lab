#!/usr/bin/env python3
"""Local demonstration detector for synthetic Purview lab data.

Evidence label: IMPLEMENTED LOCALLY

This script is not Microsoft Purview and does not reproduce Microsoft's
classification engine. It emits only case identifiers and indicator names;
raw sensitive-looking test values are deliberately excluded from reports.
"""

from __future__ import annotations

import argparse
import csv
import json
import re
from collections import Counter
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Iterable

MRN_PATTERN = re.compile(r"\bMRN-HCA-\d{6}\b", re.IGNORECASE)
SYNTHETIC_SSN_PATTERN = re.compile(r"\b(?:000|666|9\d{2})-\d{2}-\d{4}\b")
PAYMENT_TEST_PATTERN = re.compile(r"\b4111111111111111\b")
CLINICAL_TERMS = {
    "albuterol",
    "asthma",
    "diabetes",
    "glucose",
    "hypertension",
    "lisinopril",
    "medication",
    "metformin",
    "migraine",
    "patient",
    "sumatriptan",
    "treatment",
}


@dataclass(frozen=True)
class Finding:
    test_case_id: str
    case_type: str
    indicators: tuple[str, ...]
    risk: str
    classification: str
    dlp_action: str
    explanation: str


def _combined_text(row: dict[str, str]) -> str:
    return " ".join(value or "" for value in row.values())


def _has_identity(row: dict[str, str]) -> bool:
    identity_fields = (
        "patient_name",
        "date_of_birth",
        "email",
        "phone",
    )
    return any((row.get(field) or "").strip() for field in identity_fields)


def analyze_row(row: dict[str, str], sharing_state: str) -> Finding:
    text = _combined_text(row)
    lowered = text.lower()
    indicators: list[str] = []

    has_mrn = bool(MRN_PATTERN.search(text))
    has_ssn = bool(SYNTHETIC_SSN_PATTERN.search(text))
    has_payment = bool(PAYMENT_TEST_PATTERN.search(text))
    has_clinical = any(term in lowered for term in CLINICAL_TERMS)
    has_identity = _has_identity(row)
    has_employee_id = bool((row.get("employee_id") or "").strip())

    if has_mrn:
        indicators.append("mrn_pattern")
    if has_ssn:
        indicators.append("synthetic_ssn_pattern")
    if has_payment:
        indicators.append("payment_test_number")
    if has_clinical:
        indicators.append("clinical_context")
    if has_identity:
        indicators.append("identity_context")
    if has_employee_id:
        indicators.append("employee_id")

    # Conservative default: automated High requires MRN, clinical context,
    # and identity context. Partial combinations go to Review so that the
    # detector does not turn a pattern match into a confirmed incident.
    if has_mrn and has_clinical and has_identity:
        risk = "high"
        classification = "Highly Confidential – PHI"
        explanation = "MRN, clinical context, and patient identity coexist."
    elif has_mrn:
        risk = "review"
        classification = "Review required"
        explanation = "MRN pattern lacks all corroborating signals required for automated High."
    elif has_ssn or has_payment:
        risk = "medium"
        classification = "Confidential"
        explanation = "Synthetic PII or financial test indicator detected."
    elif has_employee_id and has_identity:
        risk = "medium"
        classification = "Confidential"
        explanation = "Employee identifier and identity context coexist."
    else:
        risk = "none"
        classification = (
            "Public" if row.get("case_type") in {"public_marketing", "true_negative"} else "Internal"
        )
        explanation = "No configured high-confidence sensitive combination detected."

    if sharing_state == "external" and risk == "high":
        dlp_action = "block_with_business_justified_override"
    elif sharing_state == "external" and risk in {"review", "medium"}:
        dlp_action = "audit_and_review"
    else:
        dlp_action = "allow"

    return Finding(
        test_case_id=row.get("test_case_id", "UNKNOWN"),
        case_type=row.get("case_type", "unknown"),
        indicators=tuple(indicators),
        risk=risk,
        classification=classification,
        dlp_action=dlp_action,
        explanation=explanation,
    )


def load_rows(paths: Iterable[Path]) -> list[dict[str, str]]:
    rows: list[dict[str, str]] = []
    seen_ids: set[str] = set()
    for path in paths:
        if not path.is_file():
            raise FileNotFoundError(f"Input file not found: {path}")
        with path.open(newline="", encoding="utf-8-sig") as handle:
            for row in csv.DictReader(handle):
                case_id = (row.get("test_case_id") or "").strip()
                if not case_id:
                    raise ValueError(f"Missing test_case_id in {path}")
                if case_id in seen_ids:
                    raise ValueError(f"Duplicate test_case_id: {case_id}")
                seen_ids.add(case_id)
                rows.append(row)
    return rows


def build_report(findings: list[Finding], sharing_state: str) -> dict[str, object]:
    return {
        "evidence_label": "IMPLEMENTED LOCALLY",
        "engine": "Local demonstration detector; not Microsoft Purview",
        "sharing_state": sharing_state,
        "total_cases": len(findings),
        "risk_counts": dict(sorted(Counter(item.risk for item in findings).items())),
        "action_counts": dict(sorted(Counter(item.dlp_action for item in findings).items())),
        "findings": [asdict(item) for item in findings],
    }


def write_report(report: dict[str, object], output_dir: Path) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    json_path = output_dir / "sensitive-data-analysis.json"
    markdown_path = output_dir / "sensitive-data-summary.md"
    json_path.write_text(json.dumps(report, indent=2, ensure_ascii=False), encoding="utf-8")

    lines = [
        "# Local Sensitive-Data Analysis",
        "",
        "**Evidence label: IMPLEMENTED LOCALLY**",
        "",
        "> Demonstration detector only; results are not Microsoft Purview findings.",
        "",
        f"- Sharing state: `{report['sharing_state']}`",
        f"- Total cases: {report['total_cases']}",
        f"- Risk counts: `{json.dumps(report['risk_counts'], sort_keys=True)}`",
        f"- Action counts: `{json.dumps(report['action_counts'], sort_keys=True)}`",
        "",
        "| Case | Risk | Classification | DLP action | Indicators |",
        "|---|---|---|---|---|",
    ]
    for finding in report["findings"]:  # type: ignore[index]
        indicators = ", ".join(finding["indicators"]) or "none"
        lines.append(
            f"| {finding['test_case_id']} | {finding['risk']} | "
            f"{finding['classification']} | {finding['dlp_action']} | {indicators} |"
        )
    markdown_path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def parse_args() -> argparse.Namespace:
    project_root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--input",
        nargs="+",
        type=Path,
        default=[
            project_root / "data" / "synthetic-patient-data.csv",
            project_root / "data" / "synthetic-employee-data.csv",
        ],
        help="One or more synthetic CSV inputs.",
    )
    parser.add_argument(
        "--sharing-state",
        choices=("internal", "external"),
        default="external",
        help="Modeled sharing context used for the local DLP action.",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=project_root / "output" / "python-analysis",
        help="Generated report directory (ignored by Git).",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        rows = load_rows(args.input)
        findings = [analyze_row(row, args.sharing_state) for row in rows]
        report = build_report(findings, args.sharing_state)
        write_report(report, args.output_dir)
    except (OSError, ValueError) as exc:
        print(f"ERROR: {exc}")
        return 1

    print(f"Analyzed {len(findings)} synthetic cases.")
    print(f"Risk counts: {report['risk_counts']}")
    print(f"Action counts: {report['action_counts']}")
    print(f"Reports: {args.output_dir.resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

