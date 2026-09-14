# Purpose: Install scoop itself (if missing) and install all packages at once.
# Usage:  powershell -ExecutionPolicy Bypass -File install.ps1

# scoop 本体の導入（未導入の場合）
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing scoop..." -ForegroundColor Cyan
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# パッケージ一括インストール
$packages = @(
    "komorebi"
    "whkd"
    "neovim"
    "fzf"
    "ripgrep"
    "fd"
    "bat"
    "eza"
    "zoxide"
)

Write-Host "Installing packages..." -ForegroundColor Cyan
scoop install $packages

Write-Host "Done." -ForegroundColor Green