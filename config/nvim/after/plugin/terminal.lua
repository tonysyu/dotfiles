local snacks = require("snacks")

local function focus_terminal(id)
  for _, terminal in ipairs(snacks.terminal.list()) do
    local info = vim.b[terminal.buf].snacks_terminal
    if info and info.id ~= id and terminal:win_valid() then
      terminal:hide()
    end
  end

  snacks.terminal.focus(nil, { count = id })
end

local function new_terminal()
  local next_id = 1
  for _, terminal in ipairs(snacks.terminal.list()) do
    local info = vim.b[terminal.buf].snacks_terminal
    if terminal.cmd == nil and info then
      next_id = math.max(next_id, info.id + 1)
    end
  end
  focus_terminal(next_id)
end

local function cycle_terminal(direction)
  local terminals = snacks.terminal.list()
  table.sort(terminals, function(a, b)
    return vim.b[a.buf].snacks_terminal.id < vim.b[b.buf].snacks_terminal.id
  end)

  local current
  for index, terminal in ipairs(terminals) do
    if terminal.buf == vim.api.nvim_get_current_buf() then
      current = index
      break
    end
  end

  if not current or #terminals < 2 then
    return
  end

  local target = terminals[((current - 1 + direction) % #terminals) + 1]
  for _, terminal in ipairs(terminals) do
    if terminal ~= target and terminal:win_valid() then
      terminal:hide()
    end
  end
  target:show():focus()
end

local function close_terminal()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, terminal in ipairs(snacks.terminal.list()) do
    if terminal.buf == current_buf then
      terminal:close()
      return
    end
  end
end

-- ============================================================================
-- Key mappings
-- ============================================================================

-- Use a count to select a terminal; for example, 2<C-/> opens terminal 2.
vim.keymap.set({ "n", "t" }, "<c-/>", function()
  focus_terminal(vim.v.count1)
end, { desc = "Focus Terminal (prefix command with number to open specific terminal)", silent = true })

vim.keymap.set("n", "<leader>tn", new_terminal, { desc = "New Terminal", silent = true })
vim.keymap.set("t", "<C-\\>t", new_terminal, { desc = "New Terminal", silent = true })
vim.keymap.set("t", "<C-\\>x", close_terminal, { desc = "Close Terminal", silent = true })

vim.keymap.set("t", "<C-\\>n", function()
  cycle_terminal(1)
end, { desc = "Next Terminal", silent = true })

vim.keymap.set("t", "<C-\\>p", function()
  cycle_terminal(-1)
end, { desc = "Previous Terminal", silent = true })
