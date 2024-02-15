return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = true,
    keys = {
      { "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
      { "<C-j>", "<Cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
      { "<C-k>", "<Cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
      { "<C-l>", "<Cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
    },
  },
}
