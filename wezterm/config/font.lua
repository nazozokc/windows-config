-- Purpose: font stack and shaping options (1 responsibility: text rendering).
-- Windows-only: fixed font fallback stack.

local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	-- Nerd Font is assumed (icons), and JetBrains Mono is readable at small sizes.
	-- Windows fallbacks: Yu Gothic UI (CJK, ships with OS) + Cascadia Mono (system).
	local font_family = "JetBrainsMono Nerd Font"
	local cjk_fallback = { family = "Yu Gothic UI", weight = "Regular" }
	local system_fallback = { family = "Cascadia Mono", weight = "Regular" }

	config.font = wezterm.font_with_fallback({
		{ family = font_family, weight = "Regular" },
		cjk_fallback,
		system_fallback,
	})

	-- Fixed size keeps layout stable across windows and avoids accidental zoom.
	-- 13 is a practical default for ~96 DPI Linux desktops.
	config.font_size = 13.0

	-- Slightly tighter line height improves information density without touching glyphs.
	config.line_height = 1.05

	-- Keep standard ligatures on; they improve readability of common operators in code.
	config.harfbuzz_features = { "calt", "clig", "liga" }
end

return M
