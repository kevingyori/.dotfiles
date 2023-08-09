if vim.g.vscode then
  -- VSCode extension
  vim.g.mapleader = " "
  vim.opt.clipboard:append("unnamedplus")
  vim.keymap.set("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
  vim.keymap.set("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")
  vim.keymap.set("n", "<leader>g", "<Cmd>call VSCodeNotify('scm')<CR>")
else
  -- ordinary Neovim
end
