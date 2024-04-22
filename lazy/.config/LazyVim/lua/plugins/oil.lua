return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = "<CMD>KittyNavigateLeft<CR>",
        ["<C-l>"] = "<CMD>KittyNavigateRight<CR>",
      },
    },
  },
}
