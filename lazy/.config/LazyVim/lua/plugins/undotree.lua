return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>uU", "<cmd>UndotreeToggle<cr>")
  end,
}
