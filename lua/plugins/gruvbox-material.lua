return {
	"f4z3r/gruvbox-material.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox-material").setup({
			terminal_colors = true,
		--	transparent_mode = true,
			background = {
				transparent = true,      -- set the background to transparent
			},
			overrides = {
				--["@lsp.type.method"] = { fg = "#426b5d" },
				--["@comment.lua"] = { bg = "#000000" },
			},
		})
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
