return {
	'numToStr/Comment.nvim',
	opts = {
	},
	config = function()
		require('Comment').setup {
			ignore = '^$',
			pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

			padding = true,
			sticky = true,
			mappings = false,
			toggler = {
				line = 'gcc',
				block = 'gbc',
			},
			opleader = {
				line = 'gc',
				block = 'gb',
			},
			extra = {
				eol = 'auto',
				above = '',
				below = '',
			},
			post_hook = function()
				require('ts_context_commentstring.internal').update_commentstring()
			end,
		}
	end,
}
