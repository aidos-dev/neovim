return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require("telescope.builtin")
			require("telescope").setup({
				pickers = {
					find_files = {
						find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
					},
					grep_string = {
						additional_args = {'--hidden'}
					},
					live_grep = {
						additional_args = {'--hidden'}
					}
				}
			})

			vim.keymap.set('n', '<leader>pv', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		end
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup ({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {
						}
					}
				}
			})
			require("telescope").load_extension("ui-select")

		end
	},
}

