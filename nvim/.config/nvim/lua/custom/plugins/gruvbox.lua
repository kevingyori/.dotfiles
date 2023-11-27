return {
	'sainnhe/gruvbox-material',
	lazy = false,        -- make sure we load this during startup if it is your main colorscheme
	priority = 1000,     -- make sure to load this before all the other start plugins
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
