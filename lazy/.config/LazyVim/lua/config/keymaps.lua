-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Alternate file with <leader>o
vim.keymap.set("n", "<leader>o", "<cmd>e#<cr>", { desc = "Alternate file" })
vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover Documentation" })

-- disable auto dark mode
-- vim.keymap.set(
--   "n",
--   "<leader>td",
--   "<cmd>lua require('auto-dark-mode').disable()<cr>",
--   { desc = "Toggle auto dark mode" }
-- )

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- vim.keymap.set("n", "C-h", "<CMD>KittyNavigateLeft<CR>", { desc = "Navigate left", silent = true })
-- vim.keymap.set("n", "C-j", "<CMD>KittyNavigateDown<CR>", { desc = "Navigate down", silent = true })
-- vim.keymap.set("n", "C-k", "<CMD>KittyNavigateUp<CR>", { desc = "Navigate up", silent = true })
-- vim.keymap.set("n", "C-l", "<CMD>KittyNavigateRight<CR>", { desc = "Navigate right", silent = true })
