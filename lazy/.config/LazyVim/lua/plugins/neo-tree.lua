return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
        -- open at the current file
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        width = 30,
        mappings = {
          ["l"] = "open",
        },
      },
    },
  },
}
