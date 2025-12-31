local function augroup(name)
  return vim.api.nvim_create_augroup("augroup_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
  pattern = "*",
  callback = function()
    -- Only refresh if the client supports it
    local client = vim.lsp.get_clients({ bufnr = 0 })[1]
    if client and client.supports_method("textDocument/codeLens") then
      vim.lsp.codelens.refresh({ bufnr = 0 })
    end
  end,
})

