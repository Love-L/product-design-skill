[CmdletBinding()]
param(
    [string]$Browser = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$diagramDir = Join-Path $repoRoot "docs\diagrams"
$assetDir = Join-Path $repoRoot "docs\assets"

if (-not (Test-Path -LiteralPath $diagramDir)) {
    throw "Diagram source directory not found: $diagramDir"
}

New-Item -ItemType Directory -Force -Path $assetDir | Out-Null

if (-not $Browser) {
    $candidates = @(
        "C:\Program Files\Google\Chrome\Application\chrome.exe",
        "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
        "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
        "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
    )
    $Browser = $candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
}

if (-not $Browser -or -not (Test-Path -LiteralPath $Browser)) {
    throw "Chrome or Edge not found. Pass -Browser <path>."
}

$diagrams = @(
    @{ Name = "hero";         Width = 1200; Height = 620  },
    @{ Name = "five-lenses";  Width = 1200; Height = 1020 },
    @{ Name = "workflow";     Width = 1200; Height = 880  },
    @{ Name = "architecture"; Width = 1200; Height = 880  },
    @{ Name = "session";      Width = 1200; Height = 760  }
)

foreach ($diagram in $diagrams) {
    $html = Join-Path $diagramDir "$($diagram.Name).html"
    $png = Join-Path $assetDir "$($diagram.Name).png"

    if (-not (Test-Path -LiteralPath $html)) {
        throw "Missing diagram source: $html"
    }

    $url = "file:///" + ($html -replace "\\", "/")

    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    & $Browser `
        --headless=new `
        --disable-gpu `
        --hide-scrollbars `
        --force-device-scale-factor=2 `
        --window-size="$($diagram.Width),$($diagram.Height)" `
        --screenshot="$png" `
        $url 2>&1 | Out-Null
    $ErrorActionPreference = $previousPreference

    if (-not (Test-Path -LiteralPath $png)) {
        throw "Failed to render $($diagram.Name)"
    }

    Write-Host "Rendered docs/assets/$($diagram.Name).png"
}

Write-Host ""
Write-Host "Done. Commit docs/assets/*.png if the diagrams changed."
