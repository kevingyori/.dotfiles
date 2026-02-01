return {
  {
    "folke/noice.nvim",
    opts = {
      views = {
        mini = {
          win_options = {
            winblend = 0,
            -- winhighlight = {
            --   "NoiceMini:Normal"
            -- },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    },
  },
}
