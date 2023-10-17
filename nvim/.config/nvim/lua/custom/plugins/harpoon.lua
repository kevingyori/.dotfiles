return {
	'theprimeagen/harpoon',
	config = function()
		local mark = require('harpoon.mark')
		local ui = require('harpoon.ui')

		-- Set up the harpoon markers
		vim.keymap.set('n', '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<cr>',
			{ desc = 'Add file to harpoon' })

		vim.keymap.set('n', '<leader>h', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
			{ desc = 'Open Harpoon menu' })

		vim.keymap.set('n', '<leader>j', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',
			{ desc = 'Switch to 1st harpoon' })
		vim.keymap.set('n', '<leader>k', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',
			{ desc = 'Switch to 2nd harpoon' })
		vim.keymap.set('n', '<leader>l', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',
			{ desc = 'Switch to 3rd harpoon' })
		vim.keymap.set('n', '<leader>;', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',
			{ desc = 'Switch to 4th harpoon' })

		vim.keymap.set('n', '<C-<>', '<cmd>lua require("harpoon.ui").nav_prev()<cr>',
			{ desc = 'Navigate to prev harpoon' })
		vim.keymap.set('n', '<leader>J', '<cmd>lua require("harpoon.ui").nav_next()<cr>',
			{ desc = 'Navigate to next harpoon' })
	end,
}
