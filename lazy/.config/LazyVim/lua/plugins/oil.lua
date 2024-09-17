return {
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name:match("^%.git")
            or name:match("^%.hg")
            or name == "node_modules"
            or name == ".."
            or name == ".DS_Store"
        end,
      },
      win_options = {
        signcolumn = "yes:1",
        wrap = true,
      },
      keymaps = {
        ["<C-h>"] = "<CMD>KittyNavigateLeft<CR>",
        ["<C-l>"] = "<CMD>KittyNavigateRight<CR>",
        ["<S-l>"] = "actions.select",
      },
    },
  },
}
