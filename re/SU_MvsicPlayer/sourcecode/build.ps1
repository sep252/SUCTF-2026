param(
  [ValidateSet("native", "dir", "nsis", "portable")]
  [string]$Mode = "dir",
  [switch]$SkipInstall,
  [switch]$SkipNative
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Invoke-Step {
  param([string]$Command)
  Write-Host "[run] $Command"
  cmd /c $Command
  if ($LASTEXITCODE -ne 0) {
    throw "Command failed: $Command"
  }
}

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $projectRoot
try {
  if (-not $SkipInstall) {
    if (-not (Test-Path "node_modules")) {
      Invoke-Step "npm install"
    } else {
      Write-Host "[skip] node_modules exists, skip npm install"
    }
  }

  if (-not $SkipNative) {
    Invoke-Step "npm run build:native"
  }

  switch ($Mode) {
    "native" {
      Write-Host "[ok] native build done"
    }
    "dir" {
      Invoke-Step "npx electron-builder --win dir --x64"
    }
    "nsis" {
      Invoke-Step "npx electron-builder --win nsis --x64"
    }
    "portable" {
      Invoke-Step "npx electron-builder --win portable --x64"
    }
  }

  Write-Host "[ok] build finished (mode=$Mode)"
}
finally {
  Pop-Location
}
