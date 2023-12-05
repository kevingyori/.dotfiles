-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Alternate file with <leader>o
vim.keymap.set("n", "<leader>o", "<cmd>e#<cr>", { desc = "Alternate file" })
