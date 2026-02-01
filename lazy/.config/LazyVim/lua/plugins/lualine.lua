local custom_gruvbox = require("lualine.themes.gruvbox")

-- Set background to nil for all modes
custom_gruvbox.normal.b.bg = nil
custom_gruvbox.normal.c.bg = nil
custom_gruvbox.insert.b.bg = nil
custom_gruvbox.insert.c.bg = nil
custom_gruvbox.visual.b.bg = nil
custom_gruvbox.visual.c.bg = nil
custom_gruvbox.replace.b.bg = nil
custom_gruvbox.replace.c.bg = nil
custom_gruvbox.command.b.bg = nil
custom_gruvbox.command.c.bg = nil
custom_gruvbox.inactive.b.bg = nil
custom_gruvbox.inactive.c.bg = nil

return {
  "nvim-lualine/lualine.nvim",
  -- See `:help lualine.txt`
  opts = {
    options = {
      globalstatus = true,
      icons_enabled = false,
      component_separators = "|",
      section_separators = "",
    },
    theme = "custom_gruvbox",
    sections = {
      lualine_c = {
        -- LazyVim.lualine.root_dir(),
        -- { icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      },
      lualine_y = { "filetype" },
      lualine_z = {},
      lualine_x = {},
      -- lualine_y = {
      --   { "progress", separator = " ", padding = { left = 1, right = 0 } },
      --   { "location", padding = { left = 0, right = 1 } },
      -- },
      -- lualine_z = {
      --   function()
      --     return " " .. os.date("%R")
      --   end,
      -- },
    },
  },
}
