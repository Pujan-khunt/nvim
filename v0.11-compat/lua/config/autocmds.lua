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
  group = augroup("auto_refresh_codelens"),
  pattern = "*",
  callback = function()
    -- Only refresh if the client supports it
    local client = vim.lsp.get_clients({ bufnr = 0 })[1]
    if client and client.supports_method("textDocument/codeLens") then
      vim.lsp.codelens.refresh({ bufnr = 0 })
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_keybinds"),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "No lsp client with id=" .. args.data.client_id)
    local bufnr = args.buf
    local builtin = require("telescope.builtin")

    local function map(mode, keybind, command, description)
      vim.keymap.set(mode, keybind, command, { desc = description, buffer = bufnr })
    end

    if client:supports_method("textDocument/definition") then
      map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
    end

    if client:supports_method("textDocument/declaration") then
      map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to Declaration")
    end

    if client:supports_method("textDocument/implementation") then
      map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to Implementation")
    end

    if client:supports_method("textDocument/typeDefinition") then
      map("n", "go", vim.lsp.buf.type_definition, "LSP: Go to Type Definition")
    end

    if client:supports_method("textDocument/references") then
      map("n", "gr", builtin.lsp_references, "LSP: Go to References")
    end

    if client:supports_method("textDocument/hover") then
      map("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")
    end

    if client:supports_method("textDocument/signatureHelp") then
      map("i", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature Help")
      map("n", "M", vim.lsp.buf.signature_help, "LSP: Signature Help")
    end

    if client:supports_method("textDocument/rename") then
      map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
    end

    if client:supports_method("textDocument/codeAction") then
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
    end

    if client:supports_method("textDocument/formatting") and vim.lsp.config["lua_ls"].settings.Lua.format.enable == true then
      map("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "LSP: Format Buffer")
    end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

      -- Keybind to toggle them
      map("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
          { bufnr = bufnr }
        )
      end, "LSP: Toggle Inlay Hints")
    end

    -- 5. Diagnostics (Standard Vim features, usually bound on attach)
    map("n", "[d", vim.diagnostic.goto_prev, "Diagnostic: Go to previous")
    map("n", "]d", vim.diagnostic.goto_next, "Diagnostic: Go to next")
    map("n", "<leader>of", vim.diagnostic.open_float, "Diagnostic: Show line diagnostics")
    map("n", "<leader>ol", vim.diagnostic.setloclist, "Diagnostic: Open location list")
  end,
})
