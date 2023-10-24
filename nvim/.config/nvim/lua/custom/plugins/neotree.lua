return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup(
			{
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
					},
					-- open at the current file
					follow_current_file = {
						enabled = true,
					},
				},
				window = {
					width = 30,
					mappings = {
						["l"] = "open",
					},
				},
			}
		)
	end
}
