# windows-config

Windows 用設定ファイルの管理リポジトリ。

## セットアップ

```powershell
# 1. scoop 導入 + パッケージ一括インストール
powershell -ExecutionPolicy Bypass -File install.ps1

# 2. 設定ファイルの symlink 作成
powershell -ExecutionPolicy Bypass -File link.ps1
```

### インストールされるパッケージ

komorebi / whkd / neovim / fzf / ripgrep / fd / bat / eza / zoxide

### symlink 構成

| リポジトリ内 | リンク先 |
|---|---|
| `komorebi/komorebi.json` | `~\.config\komorebi\komorebi.json` |
| `komorebi/komorebi.bar.json` | `~\.config\komorebi\komorebi.bar.json` |
| `komorebi/applications.json` | `~\applications.json` |
| `whkd/whkdrc` | `~\.config\whkd\whkdrc` |
| `wezterm/wezterm.lua` | `~\.config\wezterm\wezterm.lua` |
| `wezterm/config/` | `~\.config\wezterm\config` |
| `nvim/` | `%LOCALAPPDATA%\nvim` |

### 注意

- `link.ps1` の symlink 作成には **開発者モード** または **管理者権限** が必要
- 既存の実体ファイル/ディレクトリは `リンク先.bak-<日時>` に退避してから置き換える（上書き削除しない）
- 自動起動: komorebi / whkd はスタートアップに登録するか、`komorebic start` を使用