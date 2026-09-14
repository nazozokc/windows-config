# Purpose: Create symbolic links from this repo to the standard config locations on Windows.
# Usage:  powershell -ExecutionPolicy Bypass -File link.ps1
# Note:   Requires Developer Mode enabled or Administrator privileges.

$repo = $PSScriptRoot
$config = Join-Path $env:USERPROFILE ".config"

function New-Link {
    param(
        [string]$Link,
        [string]$Target
    )
    New-Item -ItemType SymbolicLink -Force -Path $Link -Target $Target | Out-Null
    Write-Host "linked: $Link -> $Target" -ForegroundColor Green
}

# komorebi
New-Item -ItemType Directory -Force -Path (Join-Path $config "komorebi") | Out-Null
New-Link -Link (Join-Path $config "komorebi\komorebi.json") -Target (Join-Path $repo "komorebi\komorebi.json")
New-Link -Link (Join-Path $config "komorebi\komorebi.bar.json") -Target (Join-Path $repo "komorebi\komorebi.bar.json")
# komorebi.json が参照するパス（app_specific_configuration_path）
New-Link -Link (Join-Path $env:USERPROFILE "applications.json") -Target (Join-Path $repo "komorebi\applications.json")

# whkd
New-Item -ItemType Directory -Force -Path (Join-Path $config "whkd") | Out-Null
New-Link -Link (Join-Path $config "whkd\whkdrc") -Target (Join-Path $repo "whkd\whkdrc")

# wezterm
New-Item -ItemType Directory -Force -Path (Join-Path $config "wezterm") | Out-Null
New-Link -Link (Join-Path $config "wezterm\wezterm.lua") -Target (Join-Path $repo "wezterm\wezterm.lua")
New-Link -Link (Join-Path $config "wezterm\config") -Target (Join-Path $repo "wezterm\config")

# nvim（フォルダごとリンク）
New-Link -Link (Join-Path $env:LOCALAPPDATA "nvim") -Target (Join-Path $repo "nvim")

Write-Host "Done." -ForegroundColor Green