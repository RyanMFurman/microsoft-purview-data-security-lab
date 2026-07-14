#Requires -Version 5.1
<#
.SYNOPSIS
Exports a sanitized Purview configuration inventory.

.DESCRIPTION
Evidence label: IMPLEMENTED LOCALLY for Sample mode.
Live mode is read-only design code and was not executed in this lab.
No credentials, tenant IDs, object IDs, user email addresses, or raw content are exported.
#>
[CmdletBinding()]
param(
    [ValidateSet('Sample', 'Live')]
    [string]$Mode = 'Sample',

    [string]$SamplePath,

    [string]$OutputDirectory,

    [switch]$AllowLiveReadOnly
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $SamplePath) {
    $SamplePath = Join-Path $scriptRoot 'samples\purview-configuration.sample.json'
}
if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $scriptRoot '..\output\powershell-export'
}

function ConvertTo-SanitizedInventory {
    param([Parameter(Mandatory)]$Configuration)

    [pscustomobject]@{
        EvidenceLabel = if ($Mode -eq 'Live') { 'LIVE READ-ONLY EXPORT' } else { 'IMPLEMENTED LOCALLY' }
        Source        = if ($Mode -eq 'Live') { 'Authorized tenant read-only inventory' } else { $Configuration.Source }
        Labels        = @($Configuration.Labels | ForEach-Object {
            [pscustomobject]@{
                Name       = $_.Name
                Priority   = $_.Priority
                Scope      = @($_.Scope)
                Encryption = [bool]$_.Encryption
                Enabled    = [bool]$_.Enabled
            }
        })
        PublishingPolicies = @($Configuration.PublishingPolicies | ForEach-Object {
            [pscustomobject]@{
                Name                          = $_.Name
                Enabled                       = [bool]$_.Enabled
                Audience                      = $_.Audience
                Labels                        = @($_.Labels)
                DefaultLabel                  = $_.DefaultLabel
                RequireDowngradeJustification = [bool]$_.RequireDowngradeJustification
                MandatoryLabeling             = [bool]$_.MandatoryLabeling
            }
        })
        DlpPolicies = @($Configuration.DlpPolicies | ForEach-Object {
            [pscustomobject]@{
                Name                     = $_.Name
                Enabled                  = [bool]$_.Enabled
                Mode                     = $_.Mode
                Locations                = @($_.Locations)
                Enforcement              = $_.Enforcement
                ExternalSharingCondition = [bool]$_.ExternalSharingCondition
            }
        })
    }
}

try {
    if ($Mode -eq 'Sample') {
        if (-not (Test-Path -LiteralPath $SamplePath -PathType Leaf)) {
            throw "Sample configuration not found: $SamplePath"
        }
        $configuration = Get-Content -LiteralPath $SamplePath -Raw -Encoding UTF8 | ConvertFrom-Json
    }
    else {
        if (-not $AllowLiveReadOnly) {
            throw 'Live mode requires -AllowLiveReadOnly and explicit authorization for the target tenant.'
        }
        if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
            throw 'ExchangeOnlineManagement is required for Live mode.'
        }

        Import-Module ExchangeOnlineManagement
        Connect-IPPSSession -ShowBanner:$false
        try {
            # Read-only cmdlets. Property mapping must be validated against the
            # authorized tenant and installed module version before use.
            $labels = @(Get-Label | ForEach-Object {
                [pscustomobject]@{
                    Name       = $_.DisplayName
                    Priority   = $_.Priority
                    Scope      = @($_.ContentType)
                    Encryption = [bool]$_.EncryptionEnabled
                    Enabled    = $true
                }
            })
            $publishingPolicies = @(Get-LabelPolicy | ForEach-Object {
                [pscustomobject]@{
                    Name                          = $_.Name
                    Enabled                       = ($_.Mode -ne 'PendingDeletion')
                    Audience                      = 'Sanitized; target identities omitted'
                    Labels                        = @($_.Labels)
                    DefaultLabel                  = $_.Settings.DefaultLabelId
                    RequireDowngradeJustification = $false
                    MandatoryLabeling             = $false
                }
            })
            $dlpPolicies = @(Get-DlpCompliancePolicy | ForEach-Object {
                [pscustomobject]@{
                    Name                     = $_.Name
                    Enabled                  = [bool]$_.Enabled
                    Mode                     = $_.Mode
                    Locations                = @('Validate against policy properties')
                    Enforcement              = 'Validate against associated rules'
                    ExternalSharingCondition = $false
                }
            })
            $configuration = [pscustomobject]@{
                Source             = 'Authorized tenant read-only inventory'
                Labels             = $labels
                PublishingPolicies = $publishingPolicies
                DlpPolicies         = $dlpPolicies
            }
        }
        finally {
            Disconnect-ExchangeOnline -Confirm:$false -ErrorAction SilentlyContinue
        }
    }

    $inventory = ConvertTo-SanitizedInventory -Configuration $configuration
    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
    $jsonPath = Join-Path $OutputDirectory 'purview-configuration.sanitized.json'
    $inventory | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $jsonPath -Encoding UTF8

    $inventory.Labels | Export-Csv -LiteralPath (Join-Path $OutputDirectory 'labels.csv') -NoTypeInformation
    $inventory.PublishingPolicies | Export-Csv -LiteralPath (Join-Path $OutputDirectory 'publishing-policies.csv') -NoTypeInformation
    $inventory.DlpPolicies | Export-Csv -LiteralPath (Join-Path $OutputDirectory 'dlp-policies.csv') -NoTypeInformation

    Write-Host "Sanitized inventory exported to: $OutputDirectory"
    Write-Host "Labels: $($inventory.Labels.Count); Publishing policies: $($inventory.PublishingPolicies.Count); DLP policies: $($inventory.DlpPolicies.Count)"
}
catch {
    Write-Error "Configuration export failed: $($_.Exception.Message)"
    exit 1
}
