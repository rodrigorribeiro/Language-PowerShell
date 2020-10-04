<#

.SYNOPSIS
PowerShell read local .evtx file and generate json file.

.DESCRIPTION
PowerShell loop to read local .evtx files and generate json files.
Use this script to read and generate json with most recent date and time, after that you can ingest data into SIEM to reproduce and test rules.
Author: Rodrigo Ribeiro
Date: 2020.10.02
 
.PARAMETER In
Path to recurse read through to find EVTX files.

.PARAMETER Out
Path to the output files after process.

.EXAMPLE
.\evtx2json.ps1

.EXAMPLE
.\evtx2json.ps1 -In "..\example.evtx" -Out "..\example.json"

.EXAMPLE
.\evtx2json.ps1 -Help
#>

param(
	[string]$In,
	[string]$Out,
	[switch]$Help
)

Write-Host "------------------------------------------------"
Write-Host "|    " -NoNewline
Write-Host "evtx2json - Replay a lot of EVTX!" -NoNewline -ForegroundColor DarkGreen
Write-Host "        |"
Write-Host "------------------------------------------------"

## Check if -Help
If ($Help) {get-help $PSScriptRoot\evtx2json.ps1 -Detailed; exit}

If (!$In -or !$Out) {get-help $PSScriptRoot\evtx2json.ps1 -Detailed; exit}

## Read EVTX file
Write-Host "[" -NoNewline
Write-Host "-" -NoNewline -ForegroundColor DarkCyan
Write-Host "] Starting to read EVTX file: " -NoNewline
Write-Host "$In" -ForegroundColor DarkCyan
#$evtx = Get-WinEvent -Path $In | ConvertTo-Json | ConvertFrom-Json
$evtx = Get-WinEvent -Path $In | ConvertTo-Json | ConvertFrom-Json

## Get date time now in UTC format
Write-Host "[" -NoNewline
Write-Host "-" -NoNewline -ForegroundColor DarkCyan
Write-Host "] Getting date time in UTC format."
$Time = Get-Date
$NowDate=$Time.ToUniversalTime()

$i=1

$evtx_count = $evtx.count
Write-Host "[" -NoNewline
Write-Host "-" -NoNewline -ForegroundColor DarkCyan
Write-Host "] Total events: $evtx_count"

foreach ($evtx_events in $evtx) {

	$evtx_events = ($evtx_events | ConvertTo-Json | ConvertFrom-Json)

	## Replace date time in json object
	$evtx_events.TimeCreated = $NowDate
	Write-Host "[" -NoNewline
	Write-Host "+" -NoNewline -ForegroundColor DarkGreen
	Write-Host "] Processing: $i/$evtx_count - " -NoNewline
	Write-Host ([math]::round(($i / $evtx_count) * 100)) -NoNewline -ForegroundColor DarkCyan
	Write-Host "%" -ForegroundColor DarkCyan

	## Write file output
	Add-Content -Path $Out -Value ($evtx_events | ConvertTo-Json -Compress)

	$i++
}

## Read EVTX file
Write-Host "[" -NoNewline
Write-Host "-" -NoNewline -ForegroundColor DarkCyan
Write-Host "] Write file output: " -NoNewline
Write-Host "$Out" -ForegroundColor DarkCyan