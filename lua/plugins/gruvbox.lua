return {
	"ellisonleao/gruvbox.nvim",
	config = function()
		require("gruvbox").setup({
			terminal_colors = true,
			transparent_mode = true,
			overrides = {
				--["@lsp.type.method"] = { fg = "#426b5d" },
				--["@comment.lua"] = { bg = "#000000" },
			},
		})
		--vim.cmd.colorscheme("gruvbox")
	end,
}
