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

-- Toggle CodeCompanionCLI (supports two separate keymappings to trigger)
local cc_cli_opts = { noremap = true, silent = true, desc = "AI: Toggle CodeCompanion CLI" }
local cc_cli_toggle_fn = function()
  require("codecompanion.interactions.cli").toggle()
end
vim.keymap.set({ "n", "v" }, "<leader>ccc", cc_cli_toggle_fn, cc_cli_opts)
vim.keymap.set({ "n", "v" }, "<C-A-/>", cc_cli_toggle_fn, cc_cli_opts)

-- Prompt CodeCompanionCLI from within the editor
vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
  return require("codecompanion").cli({ prompt = true })
end, { desc = "AI: Prompt the CLI agent (submit using ⌃⏎)" })

-- Add focused context to CodeCompanionCLI
vim.keymap.set({ "n", "v" }, "<leader>cca", function()
  return require("codecompanion").cli("#{this}")
end, { desc = "AI: Add context to the CLI agent" })

-- Add current file in CodeCompanionCLI from within the editor
vim.keymap.set({ "n", "v" }, "<leader>ccf", function()
  return require("codecompanion").cli("#{buffer}")
end, { desc = "AI: Add file to the CLI agent" })
