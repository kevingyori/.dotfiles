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
	config = function()
		vim.keymap.set('n', '<leader>cc', '<cmd>CccPick<CR>', { desc = 'Color Picker' })
	end
}
