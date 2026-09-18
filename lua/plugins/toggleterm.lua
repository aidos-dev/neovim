return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				start_in_insert = true,
				close_on_exit = false,
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local PANEL_SIZE = 80

			local terms = {} -- ordered list of { term = Terminal, name = string }
			local current_idx = nil

			local function render_winbar()
				local parts = {}
				for i, t in ipairs(terms) do
					if i == current_idx then
						table.insert(parts, "%#TabLineSel# " .. i .. ":" .. t.name .. " %#WinBar#")
					else
						table.insert(parts, "%#WinBar# " .. i .. ":" .. t.name .. " ")
					end
				end
				local bar = table.concat(parts, "")
				for _, t in ipairs(terms) do
					if t.term.window and vim.api.nvim_win_is_valid(t.term.window) then
						vim.wo[t.term.window].winbar = bar
					end
				end
			end

			local function show_term(idx)
				for i, t in ipairs(terms) do
					if i ~= idx and t.term:is_open() then
						t.term:close()
					end
				end
				terms[idx].term:open(PANEL_SIZE, "vertical")
				current_idx = idx
				render_winbar()
			end

			local function new_term()
				local idx = #terms + 1
				local name = "Terminal " .. idx
				local term = Terminal:new({
					direction = "vertical",
					size = PANEL_SIZE,
					close_on_exit = false,
					on_open = function()
						render_winbar()
					end,
				})
				table.insert(terms, { term = term, name = name })
				show_term(idx)
			end

			vim.keymap.set("n", "<leader>tn", new_term, { desc = "New terminal tab" })

			vim.keymap.set("n", "<leader>t]", function()
				if #terms == 0 then
					return
				end
				show_term((current_idx % #terms) + 1)
			end, { desc = "Next terminal tab" })

			vim.keymap.set("n", "<leader>t[", function()
				if #terms == 0 then
					return
				end
				show_term(((current_idx - 2) % #terms) + 1)
			end, { desc = "Previous terminal tab" })

			vim.keymap.set("n", "<leader>tc", function()
				if current_idx and terms[current_idx] then
					terms[current_idx].term:close()
				end
			end, { desc = "Close terminal panel" })

			vim.keymap.set("n", "<leader>tx", function()
				if not current_idx or not terms[current_idx] then
					return
				end
				terms[current_idx].term:shutdown()
				table.remove(terms, current_idx)

				if #terms == 0 then
					current_idx = nil
					return
				end

				local next_idx = current_idx > #terms and #terms or current_idx
				show_term(next_idx)
			end, { desc = "Close (kill) current terminal tab" })

			vim.keymap.set("n", "<leader>tr", function()
				if not current_idx or not terms[current_idx] then
					return
				end
				vim.ui.input({ prompt = "Rename terminal tab: ", default = terms[current_idx].name }, function(input)
					if input and input ~= "" then
						terms[current_idx].name = input
						render_winbar()
					end
				end)
			end, { desc = "Rename current terminal tab" })

			-- Ctrl+\ is the tty SIGQUIT key and kills the nested shell instead
			-- of leaving terminal mode, so escape via Esc Esc instead.
			vim.api.nvim_create_autocmd("TermOpen", {
				callback = function(args)
					vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = args.buf })
				end,
			})
		end,
	},
}
