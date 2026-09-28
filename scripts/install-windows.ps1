param(
    [string]$CursorRulesPath = "$HOME\.cursor\rules"
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$Source = Join-Path $RepoRoot "cursor\rules"

if (-not (Test-Path $Source)) {
    throw "Cursor rules source directory not found: $Source"
}

New-Item -ItemType Directory -Force -Path $CursorRulesPath | Out-Null
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

Get-ChildItem -Path $Source -Filter "*.mdc" | ForEach-Object {
    $destination = Join-Path $CursorRulesPath $_.Name

    if (Test-Path $destination) {
        $backup = "$destination.backup-$timestamp"
        Copy-Item $destination $backup
        Write-Host "Backed up $destination -> $backup"
    }

    Copy-Item $_.FullName $destination
    Write-Host "Installed $($_.Name)"
}

Write-Host "Cursor rules installed in $CursorRulesPath"
