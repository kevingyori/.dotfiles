return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
		},
		win_options = {
			signcolumn = "yes:1",
		},
		keymaps = {
			["<C-h>"] = "<CMD>KittyNavigateLeft<CR>",
			["<C-l>"] = "<CMD>KittyNavigateRight<CR>",
			["<S-l>"] = "actions.select",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
