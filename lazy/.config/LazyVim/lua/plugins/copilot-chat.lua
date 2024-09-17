return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "gpt-4o",
      prompts = {
        CritiqueMyCode = {
          prompt = "Please review the following code and provide suggestions for improvements, focusing on readability, efficiency, and best practices. Note that I don't want the code to be too DRY.",
          mapping = "<leader>acmc",
          description = "Critique my code",
          selection = require("CopilotChat.select").visual,
        },
      },
    },
  },
}
