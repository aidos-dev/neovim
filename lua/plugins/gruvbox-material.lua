return {
	"f4z3r/gruvbox-material.nvim",
	config = function()
		require("gruvbox-material").setup({
			terminal_colors = true,
			transparent_mode = true,
			overrides = {
				--["@lsp.type.method"] = { fg = "#426b5d" },
				--["@comment.lua"] = { bg = "#000000" },
			},
		})
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
