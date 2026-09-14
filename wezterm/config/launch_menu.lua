-- Purpose: launch menu entries for quick-starting common sessions.
-- Accessible via the command palette (Ctrl+Shift+P → "Launch").
-- Windows-only: pwsh, WSL, and default shell.

local M = {}

function M.apply(config)
	local home = os.getenv("USERPROFILE") or os.getenv("HOME") or ""

	config.launch_menu = {
		{ label = "pwsh", args = { "pwsh" } },
		{ label = "WSL", args = { "wsl.exe" } },
		{ label = "Default shell", args = {} },
		{ label = "Windows Config", cwd = home .. "/ghq/github.com/nazozokc/windows-config" },
	}
end

return M
