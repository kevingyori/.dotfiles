return {
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 5000,
  -- },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- {
  --   "tinted-theming/base16-vim",
  --   lazy = false,
  --   priority = 5000,
  --   config = function()
  --     local cmd = vim.cmd
  --     local g = vim.g
  --     local current_theme_name = os.getenv("BASE16_THEME")
  --     if current_theme_name and g.colors_name ~= "base16-" .. current_theme_name then
  --       cmd("let base16colorspace=256")
  --       cmd("colorscheme base16-" .. current_theme_name)
  --     end
  --   end,
  -- },
  -- {
  --   "RRethy/nvim-base16",
  --   lazy = false,
  --   priority = 50000,
  --   enabled = true,
  --   config = function()
  --     require("base16-colorscheme").with_config({
  --       telescope = false,
  --       indentblankline = true,
  --       notify = true,
  --       ts_rainbow = true,
  --       cmp = true,
  --       illuminate = true,
  --     })
  --   end,
  -- },
  -- { "kvrohit/mellow.nvim" },
  -- { "nyoom-engineering/oxocarbon.nvim" },
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   config = {
  --     update_interval = 1000,
  --     set_dark_mode = function()
  --       vim.g.gruvbox_material_background = "hard"
  --       vim.api.nvim_set_option("background", "dark")
  --       vim.cmd("colorscheme gruvbox-material")
  --     end,
  --     set_light_mode = function()
  --       vim.g.gruvbox_material_background = "hard"
  --       vim.api.nvim_set_option("background", "light")
  --       vim.cmd("colorscheme gruvbox-material")
  --     end,
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
