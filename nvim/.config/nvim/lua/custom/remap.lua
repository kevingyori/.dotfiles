-- Close the current buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>', { desc = 'Close buffer' })


-- File explorer nvim-tree
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Exporer' })
-- nnoremap <leader>s :Neotree float git_status<cr>
-- vim.keymap.set('n', '<leader>fj', '<cmd>Neotree float git_status<cr>', { desc = 'Exporer' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
-- vim.keymap.set('n', '<leader>q', '<cmd>Confirm "quit vim"<cr>', { desc = 'Quit' })


-- Window keymaps
vim.keymap.set('n', '<leader>wh', '<cmd>split<cr>', { desc = 'Hsplit window' })
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'Vsplit window' })

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Resize window up' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Resize window down' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize +2<cr>', { desc = 'Resize window left' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize -2<cr>', { desc = 'Resize window right' })

-- Better navigation between windows
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate left' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate down' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate up' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate right' })

-- Better indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Move selected line / block of text in visual mode
vim.keymap.set('x', 'K', ':move \'<-2<CR>gv-gv', { desc = 'Move line/block up' })
vim.keymap.set('x', 'J', ':move \'>+1<CR>gv-gv', { desc = 'Move line/block down' })

-- stay in place when going up and down
vim.keymap.set('n', 'C-d', 'C-dzz', { desc = 'Move down half page' })
vim.keymap.set('n', 'C-u', 'C-uzz', { desc = 'Move up half page' })

vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = 'Comment line' })
vim.keymap.set('v', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment line' })

-- Alternate file with <leader>o
vim.keymap.set('n', '<leader>o', '<cmd>e#<cr>', { desc = 'Alternate file' })
