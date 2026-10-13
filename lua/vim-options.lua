
vim.g.mapleader = " "

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
vim.wo.cursorline = true -- highlight the current cursor line

-- pane navigation (<C-h/j/k/l>) comes from vim-tmux-navigator

-- terminal (tabs via toggleterm)
vim.opt.shell = '/bin/bash'
