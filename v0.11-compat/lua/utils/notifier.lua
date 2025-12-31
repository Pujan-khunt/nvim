local M = {}
local ns = vim.api.nvim_create_namespace("custom-notifier")
local win = nil

function M.notify(msg, level, opts)
  opts = opts or {}
  local lines = {}

  -- Close existing window
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end

  if type(msg) == "string" then
    lines = { msg }
  else
    if type(msg) == "table" then
      local lines_str = vim.inspect(msg)       -- Outputs a single string with lines seperated with newlines('\n')
      lines_str = lines_str:gsub("\r\n", "\n") -- Normalize line endings to just \n first

      -- Append a '\n' if not already done to capture the last line
      if lines_str:sub(-1) ~= "\n" then
        lines_str = lines_str .. "\n"
      end

      -- Separate lines_str using '\n' as the delimiter
      -- nvim_buf_set_lines_str doesn't except string with new line characters
      for line in lines_str:gmatch("(.-)\n") do
        table.insert(lines, line)
      end
    end
  end

  -- Create floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_extmark(buf, ns, 0, 0, {
    hl_group = level == vim.log.levels.ERROR and "DiagnosticError" or "DiagnosticInfo",
  })

  local config = {
    style = "minimal",
    relative = "editor",
    width = 100,
    height = #lines,
    row = vim.o.lines,
    col = vim.o.columns,
    border = "rounded",
    zindex = 100,
  }
  win = vim.api.nvim_open_win(buf, false, config)

  -- Auto-close after 3s (use opts.timeout if provided)
  vim.defer_fn(function()
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
      win = nil
    end
  end, opts.timeout or 3000)
end

-- Override vim.notify if enabled
if vim.g.custom_notifier == true or vim.g.custom_notifier == 1 then
  vim.notify = M.notify
end

return M
