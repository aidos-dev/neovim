return {
	"ellisonleao/gruvbox.nvim",
	config = function()
		require("gruvbox").setup({
			terminal_colors = false,
			transparent_mode = true,
		})
		vim.cmd.colorscheme "gruvbox"
	end
}
