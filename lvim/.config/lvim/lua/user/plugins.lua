-- Additional Plugins
lvim.plugins = {
  "mbbill/undotree",
  "rebelot/kanagawa.nvim",
  {
    "mcchrish/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
  },
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- disable_background = true,
        -- disable_float_background = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- transparent_background = false,
        -- nord_disable_background = true,
        -- nord_bold = false,
      })
    end,
  },
  -- {
  --   "shaunsingh/nord.nvim",
  --   config = function()
  --     require("nord").setup({
  --       -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --       -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  --       transparent_background = false,
  --     })
  --   end,
  -- },
  -- "savq/melange-nvim",
  -- "catppuccin/nvim",
  -- "AlexvZyl/nordic.nvim",
  "savq/melange-nvim",
  "shaunsingh/nord.nvim",
  "xiyaowong/transparent.nvim",
  -- {
  -- 	"stevearc/dressing.nvim",
  -- 	lazy = true,
  -- 	config = function()
  -- 		require("user.dress").config()
  -- 	end,
  -- 	-- enabled = lvim.builtin.dressing.active,
  -- 	-- enabled = true
  -- 	event = "BufWinEnter",
  -- },
  "sainnhe/gruvbox-material",
  "olivercederborg/poimandres.nvim",
  "bluz71/vim-moonfly-colors",
  "ellisonleao/gruvbox.nvim",
  "LunarVim/synthwave84.nvim",
  "roobert/tailwindcss-colorizer-cmp.nvim",
  "lunarvim/github.nvim",
  -- "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- "christianchiarulli/nvim-ts-rainbow",
  -- "mfussenegger/nvim-jdtls",
  -- "karb94/neoscroll.nvim",
  -- "opalmay/vim-smoothie",
  "j-hui/fidget.nvim",
  -- "christianchiarulli/nvim-ts-autotag",
  "windwp/nvim-ts-autotag",
  "kylechui/nvim-surround",
  "ThePrimeagen/harpoon",
  "MattesGroeger/vim-bookmarks",
  "NvChad/nvim-colorizer.lua",
  "ghillb/cybu.nvim",
  "moll/vim-bbye",
  "folke/todo-comments.nvim",
  "windwp/nvim-spectre",
  "f-person/git-blame.nvim",
  -- "ruifm/gitlinker.nvim",
  -- "mattn/vim-gist",
  "mattn/webapi-vim",
  "folke/zen-mode.nvim",
  "lvimuser/lsp-inlayhints.nvim",
  "lunarvim/darkplus.nvim",
  -- "lunarvim/templeos.nvim",
  "kevinhwang91/nvim-bqf",
  -- "is0n/jaq-nvim",
  -- "hrsh7th/cmp-emoji",
  -- "ggandor/leap.nvim",
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  "nacro90/numb.nvim",
  "TimUntersberger/neogit",
  "sindrets/diffview.nvim",
  -- "simrat39/rust-tools.nvim",
  -- "olexsmir/gopher.nvim",
  -- "leoluz/nvim-dap-go",
  -- "mfussenegger/nvim-dap-python",
  "jose-elias-alvarez/typescript.nvim",
  "mxsdev/nvim-dap-vscode-js",
  "petertriho/nvim-scrollbar",
  "karb94/neoscroll.nvim",
  -- "renerocksai/telekasten.nvim",
  -- "renerocksai/calendar-vim",
  -- {
  --   "saecki/crates.nvim",
  --   version = "v0.3.0",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("crates").setup {
  --       null_ls = {
  --         enabled = true,
  --         name = "crates.nvim",
  --       },
  --     }
  --   end,
  -- },
  "MunifTanjim/nui.nvim",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    --    dependencies = {
    --     -- which key integration
    --    {
    --     "folke/which-key.nvim",
    --    opts = function(_, opts)
    --     if require("lazyvim.util").has("noice.nvim") then
    --      opts.defaults["<leader>sn"] = { name = "+noice" }
    --   end
    --        end,
    --     },
    --   },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = false,
      },
    },
    -- stylua: ignore
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc =
        "Redirect Cmdline"
      },
      {
        "<leader>snl",
        function() require("noice").cmd("last") end,
        desc =
        "Noice Last Message"
      },
      {
        "<leader>snh",
        function() require("noice").cmd("history") end,
        desc =
        "Noice History"
      },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      {
        "<leader>snd",
        function() require("noice").cmd("dismiss") end,
        desc =
        "Dismiss All"
      },
      {
        "<c-f>",
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll forward",
        mode = {
          "i", "n", "s" }
      },
      {
        "<c-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll backward",
        mode = {
          "i", "n", "s" }
      },
    },
  },
  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  -- "jackMort/ChatGPT.nvim",
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
      })
    end,
  },
  -- TODO - don't use this fork
  { "christianchiarulli/telescope-tabs", branch = "chris" },
  "monaqa/dial.nvim",
  {
    "0x100101/lab.nvim",
    build = "cd js && npm ci",
  },
  {
    "zbirenbaum/copilot.lua",
    -- cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- {
  --   "tzachar/cmp-tabnine",
  --   event = "InsertEnter",
  --   build = "./install.sh",
  -- },

  -- "MunifTanjim/nui.nvim",
  -- "Bryley/neoai.nvim",
  -- {
  --   "folke/noice.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     require("noice").setup()
  --   end,
  -- },

  -- https://github.com/jose-elias-alvarez/typescript.nvim
  -- "rmagatti/auto-session",
  -- "rmagatti/session-lens"
}
