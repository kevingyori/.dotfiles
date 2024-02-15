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
    sections = {
      lualine_y = { "fileformat", "filetype" },
      lualine_z = {},
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
