return {
	'sainnhe/gruvbox-material',
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		--
		background = 'hard'
	},
	config = function()
		vim.cmd [[colorscheme gruvbox-material]]
	end
}
