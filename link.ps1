# Purpose: Create symbolic links from this repo to the standard config locations on Windows.
# Usage:  powershell -ExecutionPolicy Bypass -File link.ps1
# Note:   Requires Developer Mode enabled or Administrator privileges.
#         既存の実体ファイル/ディレクトリは `リンク先.bak-<タイムスタンプ>` に退避してから置き換える。

$repo = $PSScriptRoot
$config = Join-Path $env:USERPROFILE ".config"

function New-Link {
    param(
        [string]$Link,
        [string]$Target
    )

    $item = Get-Item -Path $Link -Force -ErrorAction SilentlyContinue
    if ($null -ne $item) {
        if ($item.LinkType) {
            # 既存の symlink/junction は張り直す（リンク自体だけ削除し、中身には触れない）
            if ($item.PSIsContainer) {
                [System.IO.Directory]::Delete($Link, $false)
            } else {
                [System.IO.File]::Delete($Link)
            }
        } else {
            # 実体ファイル/ディレクトリはバックアップに退避してから置き換える
            $backup = "$Link.bak-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Rename-Item -Path $Link -Destination $backup
            Write-Host "backed up: $Link -> $backup" -ForegroundColor Yellow
        }
    }

    try {
        New-Item -ItemType SymbolicLink -Force -Path $Link -Target $Target | Out-Null
        Write-Host "linked: $Link -> $Target" -ForegroundColor Green
    } catch {
        Write-Host "failed: $Link -> $Target ($($_.Exception.Message))" -ForegroundColor Red
    }
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