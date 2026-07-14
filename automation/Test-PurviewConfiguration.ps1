#Requires -Version 5.1
<#
.SYNOPSIS
Validates sanitized Purview configuration against the approved lab design.

.DESCRIPTION
Evidence label: IMPLEMENTED LOCALLY.
This script validates JSON; it does not connect to Microsoft 365 or prove that
the represented settings were deployed in a tenant.
#>
[CmdletBinding()]
param(
    [string]$ConfigurationPath,
    [string]$OutputDirectory
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $ConfigurationPath) {
    $ConfigurationPath = Join-Path $scriptRoot 'samples\purview-configuration.sample.json'
}
if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $scriptRoot '..\output\powershell-validation'
}
$findings = [System.Collections.Generic.List[object]]::new()

function Add-Finding {
    param(
        [string]$Severity,
        [string]$Control,
        [string]$Status,
        [string]$Evidence
    )
    $script:findings.Add([pscustomobject]@{
        Severity = $Severity
        Control  = $Control
        Status   = $Status
        Evidence = $Evidence
    })
}

try {
    if (-not (Test-Path -LiteralPath $ConfigurationPath -PathType Leaf)) {
        throw "Configuration file not found: $ConfigurationPath"
    }
    $configuration = Get-Content -LiteralPath $ConfigurationPath -Raw -Encoding UTF8 | ConvertFrom-Json

    $phiLabelName = 'Highly Confidential ' + [char]0x2013 + ' PHI'
    $pilotPolicyName = 'Purview Healthcare Lab ' + [char]0x2013 + ' Pilot Label Policy'
    $expectedLabels = @('Public', 'Internal', 'Confidential', $phiLabelName)
    foreach ($expected in $expectedLabels) {
        $matches = @($configuration.Labels | Where-Object Name -eq $expected)
        if ($matches.Count -eq 1 -and $matches[0].Enabled) {
            Add-Finding 'Info' "Label: $expected" 'Pass' 'Expected enabled label found.'
        }
        else {
            Add-Finding 'High' "Label: $expected" 'Fail' "Expected one enabled label; found $($matches.Count)."
        }
    }

    $orderedNames = @($configuration.Labels | Sort-Object Priority | ForEach-Object Name)
    if (($orderedNames -join '|') -eq ($expectedLabels -join '|')) {
        Add-Finding 'Info' 'Label priority' 'Pass' "Labels progress from Public to $phiLabelName."
    }
    else {
        Add-Finding 'High' 'Label priority' 'Fail' "Observed order: $($orderedNames -join ', ')"
    }

    $phiLabel = @($configuration.Labels | Where-Object Name -eq $phiLabelName)
    if ($phiLabel.Count -eq 1 -and $phiLabel[0].Encryption) {
        Add-Finding 'Info' 'PHI encryption' 'Pass' 'PHI label encryption is enabled in the sample design.'
    }
    else {
        Add-Finding 'High' 'PHI encryption' 'Fail' 'PHI label is missing or encryption is disabled.'
    }

    $unexpectedEncryption = @($configuration.Labels | Where-Object { $_.Name -ne $phiLabelName -and $_.Encryption })
    if ($unexpectedEncryption.Count -eq 0) {
        Add-Finding 'Info' 'E1 encryption scope' 'Pass' 'Only the PHI label uses encryption.'
    }
    else {
        Add-Finding 'Medium' 'E1 encryption scope' 'Fail' "Unexpected encrypted labels: $($unexpectedEncryption.Name -join ', ')"
    }

    $publishing = @($configuration.PublishingPolicies | Where-Object Name -eq $pilotPolicyName)
    if ($publishing.Count -eq 1 -and $publishing[0].Enabled -and $publishing[0].Audience -eq 'Purview-Lab-Pilot-Users') {
        Add-Finding 'Info' 'Pilot publishing policy' 'Pass' 'Expected enabled P1 pilot policy found.'
    }
    else {
        Add-Finding 'High' 'Pilot publishing policy' 'Fail' 'Expected P1 pilot policy is missing, disabled, duplicated, or mis-scoped.'
    }

    $dlp = @($configuration.DlpPolicies | Where-Object Name -eq 'Healthcare Sensitive Data External Sharing Policy')
    if ($dlp.Count -eq 1 -and $dlp[0].Enabled) {
        Add-Finding 'Info' 'Healthcare DLP policy' 'Pass' 'Expected enabled DLP policy found.'
        if ($dlp[0].Mode -eq 'Simulation') {
            Add-Finding 'Info' 'DLP mode' 'Pass' 'Policy begins in simulation mode.'
        }
        else {
            Add-Finding 'High' 'DLP mode' 'Fail' "Expected Simulation; observed $($dlp[0].Mode)."
        }

        $locations = @($dlp[0].Locations)
        $expectedLocations = @('OneDrive', 'SharePoint')
        if ((@($locations | Sort-Object) -join '|') -eq ($expectedLocations -join '|')) {
            Add-Finding 'Info' 'DLP locations' 'Pass' 'DLP scope is limited to SharePoint and OneDrive.'
        }
        else {
            Add-Finding 'High' 'DLP locations' 'Fail' "Observed locations: $($locations -join ', ')"
        }

        if ($dlp[0].ExternalSharingCondition) {
            Add-Finding 'Info' 'External-sharing condition' 'Pass' 'External-sharing condition is represented.'
        }
        else {
            Add-Finding 'High' 'External-sharing condition' 'Fail' 'External-sharing condition is disabled or missing.'
        }
    }
    else {
        Add-Finding 'High' 'Healthcare DLP policy' 'Fail' 'Expected enabled DLP policy not found exactly once.'
    }

    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
    $findings | Export-Csv -LiteralPath (Join-Path $OutputDirectory 'configuration-findings.csv') -NoTypeInformation
    $result = [pscustomobject]@{
        EvidenceLabel = 'IMPLEMENTED LOCALLY'
        Engine        = 'Local JSON configuration validator; not Microsoft Purview'
        Configuration = (Resolve-Path -LiteralPath $ConfigurationPath).Path
        PassCount     = @($findings | Where-Object Status -eq 'Pass').Count
        FailCount     = @($findings | Where-Object Status -eq 'Fail').Count
        Findings      = @($findings)
    }
    $result | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'configuration-findings.json') -Encoding UTF8

    $findings | Format-Table -AutoSize
    Write-Host "Pass: $($result.PassCount); Fail: $($result.FailCount)"
    Write-Host "Reports: $OutputDirectory"
    if ($result.FailCount -gt 0) { exit 2 }
}
catch {
    Write-Error "Configuration validation failed: $($_.Exception.Message)"
    exit 1
}
