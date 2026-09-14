return {
	"R32/i-leave-ime.nvim",
	event = "InsertEnter",
	config = function()
		require("i-leave-ime").enable()
	end,
}