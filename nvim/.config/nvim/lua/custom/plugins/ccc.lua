return {
	'uga-rosa/ccc.nvim',
	opts = {
		-- Your preferred settings
		-- Example: enable highlighter
		highlighter = {
			auto_enable = true,
			lsp = true,
		},
	},
	config = {
		vim.keymap.set('n', '<leader>cc', '<cmd>CccPick<CR>', { desc = 'Color Picker' }),
	}
}
