return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	opts = {
		check_ts = true,
		ts_config = {
			lua = { 'string', 'source' },     -- it will not add pair on that treesitter node
			javascript = { 'template_string' },
			-- java = false,-- don't check treesitter on java
		},
		disable_filetype = { "TelescopePrompt" },
		fast_wrap = {},
	},
}
