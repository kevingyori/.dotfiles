-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Cursor blinking
vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}, ",")

-- vim.g.kitty_navigator_enable_stack_layout = 1
-- vim.g.kitty_navigator_no_mappings = 1
