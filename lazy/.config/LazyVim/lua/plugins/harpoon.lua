return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>j", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', desc = "Switch to 1st harpoon" },
      { "<leader>k", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', desc = "Switch to 2nd harpoon" },
      { "<leader>l", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', desc = "Switch to 3rd harpoon" },
      { "<leader>;", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', desc = "Switch to 4th harpoon" },
      { "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = "Add file to harpoon" },
      { "<leader>h", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Open Harpoon menu" },
    },
  },
}
