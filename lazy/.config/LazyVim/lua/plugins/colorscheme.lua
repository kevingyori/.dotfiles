return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      -- flavour = "auto" -- will respect terminal's background
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline

      -- *bold* *underline* *undercurl*
      -- *underdouble* *underdotted*
      -- *underdashed* *inverse* *italic*
      -- *standout* *strikethrough* *altfont*
      -- *nocombine*
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      -- color_overrides = {},
      highlight_overrides = {
        all = function(C)
          return {
            TSString = { fg = C.peach },
            -- TSLiteral = { link = "String" },
            TSStringEscape = { fg = C.peach },
            TSStringRegex = { fg = C.peach },
            ["@string"] = { link = "TSString" },
            ["@string.escape"] = { link = "TSStringEscape" },
            ["@string.regex"] = { link = "TSStringRegex" },
            ["@string.special"] = { link = "TSStringSpecial" },
            ["@boolean"] = { fg = C.yellow },
            -- TSStringSpecial = { link = "SpecialChar" },
          }
        end,
      },
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },
  {
    -- nord
    {
      "nordtheme/vim",
      priority = 1000,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
