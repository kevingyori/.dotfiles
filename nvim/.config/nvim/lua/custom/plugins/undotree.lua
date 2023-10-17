return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>')
		vim.keymap.set('n', '<leader>U', '<cmd>UndotreeFocus<cr>')
	end
}
