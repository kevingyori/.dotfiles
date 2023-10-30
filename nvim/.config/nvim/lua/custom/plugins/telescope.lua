-- Fuzzy Finder (files, lsp, etc)
return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require('telescope').setup {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					hidden = true,
				},
				oldfiles = {
					hidden = true,
				},
			},
		}

		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')

		-- See `:help telescope.builtin`
		vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers,
			{ desc = '[F]ind existing [B]uffers' })
		vim.keymap.set('n', '<leader>f/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 20,
				previewer = false,
			})
		end, { desc = '[/] Fuzzily search in current buffer' })

		-- vim.keymap.set('n', 'f', '', { desc = 'Telescope' })
		vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files,
			{ desc = 'Search [G]it [F]iles' })
		vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches,
			{ desc = 'Search [G]it [B]ranches' })
		vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits,
			{ desc = 'Search [G]it [C]ommits' })
		vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status,
			{ desc = 'Search [G]it [S]tatus' })
		vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
		vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
		vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string,
			{ desc = '[F]ind current [W]ord' })
		vim.keymap.set('n', '<leader>fs', require('telescope.builtin').live_grep, { desc = '[F]ind by [S]tring' })
		vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics,
			{ desc = '[F]ind [D]iagnostics' })
		vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]esume' })
		vim.keymap.set('n', '<leader>ft', require('telescope.builtin').colorscheme,
			{ desc = '[F]ind [T]hemes' })
		vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles,
			{ desc = '[F]ind [O]ldfiles' })
	end
}
