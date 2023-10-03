-- Kanagawa theme
return {
	'rebelot/kanagawa.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme kanagawa-dragon")
		vim.keymap.set('n', '<leader>td', '<cmd>colorscheme kanagawa-dragon<cr>')
		vim.keymap.set('n', '<leader>tl', '<cmd>colorscheme kanagawa-lotus<cr>')
	end
}
