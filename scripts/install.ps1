[CmdletBinding()]
param(
    [ValidateSet("dsh", "claude", "project")]
    [string]$Target = "dsh",

    [string]$ProjectPath = "."
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$source = Join-Path $repoRoot "skills\product-design"

if (-not (Test-Path -LiteralPath $source)) {
    throw "Skill source not found: $source"
}

switch ($Target) {
    "dsh" {
        $destination = Join-Path $HOME ".dsh\skills\product-design"
    }
    "claude" {
        $destination = Join-Path $HOME ".claude\skills\product-design"
    }
    "project" {
        $project = (Resolve-Path -LiteralPath $ProjectPath).Path
        $destination = Join-Path $project ".dsh\skills\product-design"
    }
}

$destination = [System.IO.Path]::GetFullPath($destination)

if (-not ($destination -match '[\\/]product-design$')) {
    throw "Refusing to write to unexpected destination: $destination"
}

if (Test-Path -LiteralPath $destination) {
    Write-Host "Replacing existing installation: $destination"
    Remove-Item -LiteralPath $destination -Recurse -Force
}

$parent = Split-Path -Parent $destination
New-Item -ItemType Directory -Force -Path $parent | Out-Null
Copy-Item -LiteralPath $source -Destination $destination -Recurse -Force

Write-Host ""
Write-Host "Installed product-design -> $destination"
Write-Host "Start a new agent session to load the skill."
