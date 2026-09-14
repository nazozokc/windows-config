-- Purpose: performance settings. Windows-only: OpenGL front-end.

local M = {}

function M.apply(config)
	config.max_fps = 120
	config.animation_fps = 1

	-- OpenGL avoids the slow software-rendering path on Windows.
	config.front_end = "OpenGL"

	config.scrollback_lines = 10000
	config.scroll_to_bottom_on_input = true
end

return M
