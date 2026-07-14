"""Unit tests for the local synthetic-data analyzer."""

from __future__ import annotations

import importlib.util
import sys
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
SCRIPT_PATH = PROJECT_ROOT / "automation" / "Analyze-SensitiveData.py"
SPEC = importlib.util.spec_from_file_location("analyze_sensitive_data", SCRIPT_PATH)
assert SPEC and SPEC.loader
MODULE = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = MODULE
SPEC.loader.exec_module(MODULE)


class AnalyzerTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.rows = MODULE.load_rows(
            [
                PROJECT_ROOT / "data" / "synthetic-patient-data.csv",
                PROJECT_ROOT / "data" / "synthetic-employee-data.csv",
            ]
        )
        cls.findings = {
            item.test_case_id: item
            for item in (MODULE.analyze_row(row, "external") for row in cls.rows)
        }

    def test_all_fourteen_cases_load(self) -> None:
        self.assertEqual(14, len(self.rows))

    def test_strong_phi_is_high_and_blocked_with_override(self) -> None:
        finding = self.findings["PHI-TP-001"]
        self.assertEqual("high", finding.risk)
        self.assertEqual("Highly Confidential – PHI", finding.classification)
        self.assertEqual("block_with_business_justified_override", finding.dlp_action)

    def test_boundary_cases_require_review(self) -> None:
        self.assertEqual("review", self.findings["PHI-BD-001"].risk)
        self.assertEqual("review", self.findings["PHI-BD-002"].risk)

    def test_mrn_campaign_code_is_not_high(self) -> None:
        self.assertEqual("review", self.findings["PHI-FP-001"].risk)
        self.assertNotEqual(
            "block_with_business_justified_override",
            self.findings["PHI-FP-001"].dlp_action,
        )

    def test_public_negative_is_allowed(self) -> None:
        finding = self.findings["PHI-TN-001"]
        self.assertEqual("none", finding.risk)
        self.assertEqual("allow", finding.dlp_action)

    def test_employee_and_financial_test_rows_are_confidential(self) -> None:
        self.assertEqual("Confidential", self.findings["EMP-TP-001"].classification)
        self.assertEqual("Confidential", self.findings["EMP-TP-002"].classification)

    def test_internal_context_does_not_trigger_external_block(self) -> None:
        patient_row = next(row for row in self.rows if row["test_case_id"] == "PHI-TP-001")
        finding = MODULE.analyze_row(patient_row, "internal")
        self.assertEqual("high", finding.risk)
        self.assertEqual("allow", finding.dlp_action)


if __name__ == "__main__":
    unittest.main()
