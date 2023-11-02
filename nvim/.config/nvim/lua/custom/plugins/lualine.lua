----------------------------------------- [[ Configure lualine ]] -----------------------------------------
--  local theme = require('lualine.themes.zenbones')
--  theme.normal.c.bg = 'none'
-- theme.normal.b.bg = 'none'
-- theme.insert.b.bg = 'none'
-- theme.visual.b.bg = 'none'
-- theme.replace.b.bg = 'none'
-- theme.command.b.bg = 'none'
-- theme.inactive.b.bg = 'none'

-- require('lualine').setup {
-- 	options = {
-- 		theme = 'gruvbox_material',
-- 		icons_enabled = false,
-- 		component_separators = '|',
-- 		section_separators = '',
-- 		sections = {
-- 			lualine_a = { 'mode' },
-- 			lualine_b = { 'branch', 'diff', 'diagnostics' },
-- 			lualine_c = { 'filename' },
-- 			lualine_x = { 'fileformat', 'filetype' },
-- 		},
-- 	},
-- 	icons_enabled = false,
-- 	component_separators = '|',
-- 	section_separators = '',
-- }

-- options = { theme  = custom_gruvbox },
--


-- vim.cmd [[colorscheme rosebones require 'customBones']]

return {

	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			theme = 'auto',
			globalstatus = true,
			icons_enabled = false,
			component_separators = '|',
			section_separators = '',
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename' },
				lualine_x = { 'fileformat', 'filetype' },
			},
		},
	},
}
