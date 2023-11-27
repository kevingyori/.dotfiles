if vim.g.vscode then
  -- VSCode extension
  vim.g.mapleader = " "
  vim.opt.clipboard:append("unnamedplus")
  vim.keymap.set("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
  vim.keymap.set("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")
  vim.keymap.set("n", "<leader>g", "<Cmd>call VSCodeNotify('scm')<CR>")
  -- Set scrolloff to 8 lines
  vim.o.scrolloff = 8
else
  -- ordinary Neovim
  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must hap-- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Install package manager
  --    https://github.com/folke/lazy.nvim
  --    `:help lazy.nvim.txt` for more info
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      -- '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  -- NOTE: Here is where you install your plugins.
  --  You can configure plugins using the `config` key.
  --
  --  You can also configure plugins after the setup call,
  --    as they will be available in your neovim runtime.
  require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.



    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.
    require 'kickstart.plugins.autoformat',
    -- require 'kickstart.plugins.debug',

    ----------- my custom plugins

    {
      "uga-rosa/ccc.nvim",
      config = function()
        require("ccc").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
          highlighter = {
            auto_enable = true,
            lsp = true,
          },
        })
      end
    },
    "christoomey/vim-tmux-navigator",

    -- Github theme
    {
      'projekt0n/github-nvim-theme',
      -- lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      -- priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        -- vim.cmd [[colorscheme github_dark_high_contrast]]
      end
    },
    { 'rebelot/kanagawa.nvim' },
    { 'sainnhe/everforest' },
    'EdenEast/nightfox.nvim',
    'folke/tokyonight.nvim',
    'marko-cerovac/material.nvim',
    'nanotech/jellybeans.vim',
    'dracula/vim',
    'sainnhe/sonokai',
    'fenetikm/falcon',
    'olivercederborg/poimandres.nvim',
    'catppuccin/nvim',
    -- zenbones
    -- "mcchrish/zenbones.nvim",
    -- "rktjmp/lush.nvim",
    {
      "nyoom-engineering/oxocarbon.nvim",
      -- lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      -- priority = 1000, -- make sure to load this before all the other start plugins
      -- config = function()
      -- vim.cmd [[colorscheme oxocarbon]]
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      -- end
    },


    -- {
    --   "nvim-telescope/telescope-file-browser.nvim",
    --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    -- },



    -- Auto switch themes based on system setting
    -- {
    --   "f-person/auto-dark-mode.nvim",
    --   config = {
    --     update_interval = 5000,
    --     set_dark_mode = function()
    --       vim.api.nvim_set_option("background", "dark")
    --       vim.cmd("colorscheme kanagawa-dragon")
    --     end,
    --     set_light_mode = function()
    --       vim.api.nvim_set_option("background", "light")
    --       vim.cmd("colorscheme kanagawa-lotus")
    --     end,
    --   },
    -- },


    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    { import = 'custom.plugins' },
  }, {})


  ----------------------------------------- [[ Basic Options ]] -----------------------------------------
  -- See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  -- import 'custom.options'
  require('custom.options')


  ----------------------------------------- [[ Basic Keymaps ]] -----------------------------------------
  require('custom.remap')

  ----------------------------------------- [[ Configure LSP ]] -----------------------------------------


  require("noice").setup({
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
  })



  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('gh', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('<leader>df', vim.lsp.buf.format, '[D]ocument [F]ormat')
  end

  -- mason-lspconfig requires that these setup functions are called in this order
  -- before setting up the servers.
  require('mason').setup()
  require('mason-lspconfig').setup()

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  --
  --  If you want to override the default filetypes that your language server will attach to you can
  --  define the property 'filetypes' to the map in question.
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    astro = {},
    tsserver = {},
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }

  -- Setup neovim lua configuration
  require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end
  }

  ----------------------------------------- [[ Configure nvim-cmp ]] -----------------------------------------
  -- See `:help cmp`
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup {}

  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
  )

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      -- ['<Tab>'] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif luasnip.expand_or_locally_jumpable() then
      --     luasnip.expand_or_jump()
      --   else
      --     fallback()
      --   end
      -- end, { 'i', 's' }),
      -- ['<S-Tab>'] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif luasnip.locally_jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
    formatting = {
      format = require('tailwindcss-colorizer-cmp').formatter,
    },
  }

  -- The line beneath this is called `modeline`. See `:help modeline`
  -- vim: ts=2 sts=2 sw=2 et
end
