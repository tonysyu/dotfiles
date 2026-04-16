require("codecompanion").setup({
  display = {
    cli = {
      window = {
        position = "right",
      },
    },
  },
  adapters = {
    acp = {
      claude_code = function()
        -- Requires CLAUDE_CODE_OAUTH_TOKEN env var set to a token generated via `claude setup-token`
        return require("codecompanion.adapters").extend("claude_code", {})
      end,
    },
  },
  interactions = {
    cli = {
      agent = "claude_code",
      agents = {
        claude_code = {
          cmd = "claude",
          args = {},
          description = "Claude Code CLI",
          provider = "terminal",
        },
      },
    },
  },
})

--
-- CodeCompanion keymappings
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
-- Expand 'ccc' into 'CodeCompanionCLI' in the command line
vim.cmd([[cab ccc CodeCompanionCLI]])

-- Toggle CodeCompanionCLI. Create session, if not already created.
vim.keymap.set({ "n", "v" }, "<leader>ccc", function()
  require("codecompanion.interactions.cli").toggle()
end, { noremap = true, silent = true, desc = "AI: Toggle CodeCompanion CLI" })
vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
  return require("codecompanion").cli({ prompt = true })
end, { desc = "AI: Prompt the CLI agent" })
vim.keymap.set({ "n", "v" }, "<leader>cca", function()
  return require("codecompanion").cli("#{this}")
end, { desc = "AI: Add context to the CLI agent" })
