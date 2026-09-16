-- Purpose: performance settings. Windows-only: WebGpu (DX12) front-end.

local M = {}

function M.apply(config)
	-- The terminal only redraws when content changes, so a low max_fps buys
	-- almost nothing on battery but adds up to one frame of input latency.
	-- 60 keeps key -> screen response snappy.
	config.max_fps = 60
	config.animation_fps = 1

	-- DX12 via WebGpu is the fast path on modern Windows.
	-- OpenGL was the old default and is heavily driver-dependent.
	config.front_end = "WebGpu"

	config.scrollback_lines = 10000
	config.scroll_to_bottom_on_input = true
end

return M
