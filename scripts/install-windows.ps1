param(
    [string]$CursorSkillsPath = "$HOME\.cursor\skills",
    [string]$CodexSkillsPath = "$HOME\.codex\skills",
    [string]$AgentsSkillsPath = "$HOME\.agents\skills"
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SharedSkillsPath = Join-Path $RepoRoot "shared\skills"

if (-not (Test-Path $SharedSkillsPath)) {
    throw "Shared skills directory not found: $SharedSkillsPath"
}

function Install-Skills {
    param(
        [string]$ToolName,
        [string]$TargetPath
    )

    Write-Host ""
    Write-Host "Installing skills for $ToolName..."
    Write-Host "Target: $TargetPath"
    Write-Host ""

    New-Item -ItemType Directory -Force -Path $TargetPath | Out-Null

    Get-ChildItem -Path $SharedSkillsPath -Directory | ForEach-Object {
        $skillName = $_.Name
        $source = $_.FullName
        $destination = Join-Path $TargetPath $skillName

        if (Test-Path $destination) {
            $existing = Get-Item $destination

            if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                $target = $existing.Target

                if ($target -eq $source) {
                    Write-Host "[OK] $skillName already linked"
                }
                else {
                    Write-Warning "[SKIP] $skillName is already linked somewhere else"
                    Write-Warning "       Current: $target"
                    Write-Warning "       Expected: $source"
                }
            }
            else {
                Write-Warning "[SKIP] $skillName already exists at $destination"
            }

            return
        }

        try {
            New-Item `
                -ItemType Junction `
                -Path $destination `
                -Target $source `
                -ErrorAction Stop | Out-Null

            Write-Host "[LINKED] $skillName"
        }
        catch {
            Write-Warning "[ERROR] Could not create junction for $skillName"
            Write-Warning $_.Exception.Message
        }
    }
}

Install-Skills `
    -ToolName "Agents" `
    -TargetPath $AgentsSkillsPath

Install-Skills `
    -ToolName "Cursor" `
    -TargetPath $CursorSkillsPath

Install-Skills `
    -ToolName "Codex" `
    -TargetPath $CodexSkillsPath

Write-Host ""
Write-Host "Installation complete."
Write-Host ""
Write-Host "Shared source:"
Write-Host "  $SharedSkillsPath"
Write-Host ""
Write-Host "Agents:"
Write-Host "  $AgentsSkillsPath"
Write-Host ""
Write-Host "Cursor:"
Write-Host "  $CursorSkillsPath"
Write-Host ""
Write-Host "Codex:"
Write-Host "  $CodexSkillsPath"
