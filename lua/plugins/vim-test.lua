return {
	"vim-test/vim-test",

	dependencies = {
		"preservim/vimux",
	},

	init = function()
		vim.g["test#strategy"] = "vimux"
	end,

	keys = {
		{ "<leader>rt", ":TestNearest<CR>", desc = "Test nearest" },
		{ "<leader>rT", ":TestFile<CR>", desc = "Test file" },
		{ "<leader>ra", ":TestSuite<CR>", desc = "Test suite" },
		{ "<leader>rl", ":TestLast<CR>", desc = "Test last" },
		{ "<leader>rv", ":TestVisit<CR>", desc = "Visit last test file" },
	},
}
