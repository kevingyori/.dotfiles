return {
  {
    "ThePrimeagen/git-worktree.nvim",
    setup = function()
      require("telescope").load_extension("git_worktree")
    end,
  },
}
