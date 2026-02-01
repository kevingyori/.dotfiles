return {
  {
    "ThePrimeagen/harpoon",
    -- branch = "harpoon2",
    lazy = true,
    keys = {
      { "<leader>j", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', desc = "Switch to 1st harpoon" },
      { "<leader>k", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', desc = "Switch to 2nd harpoon" },
      { "<leader>l", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', desc = "Switch to 3rd harpoon" },
      { "<leader>;", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', desc = "Switch to 4th harpoon" },
      { "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = "Add file to harpoon" },
      { "<leader>hh", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Open Harpoon menu" },
      -- {"<leader>j", "<cmd>lua require('harpoon'):list().select(1)"},
      -- {"<leader>k", "<cmd>lua require('harpoon'):list().select(2)"},
      -- {"<leader>l", "<cmd>lua require('harpoon'):list().select(3)"},
      -- {"<leader>;", "<cmd>lua require('harpoon'):list().select(4)"},
      -- {"<leader>a", "<cmd>lua require('harpoon'):toggle_quick_menu()<cr>"},
      -- {"<leader>h", "<cmd>lua require('harpoon'):toggle_quick_menu()<cr>"},
    },
  },
}
