--- @module "lazy"
--- @type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false, -- use the latest parser versions
  build = ":TSUpdate",
  lazy = false,    -- treesitter doesn't support lazy loading
  config = function()
    local ts = require("nvim-treesitter")

    local parsers_loaded = {}
    local parsers_pending = {}
    local parsers_failed = {}

    -- Enable treesitter features for a buffer based on the language
    local function start(buf, lang)
      -- Enable treesitter highlights
      local ok = pcall(vim.treesitter.start, buf, lang)

      -- Enable indentation and folds using treesitter
      if ok then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
      return ok
    end

    local ts_parsers = {
      "astro",
      "bash",
      "comment",
      "css",
      "diff",
      "bash",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "go",
      "html",
      "javascript",
      "json",
      "latex",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
    }

    -- Install treesitter parsers after lazy sets up after initial startup.
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyDone",             -- User autocmd signalled by lazy.nvim about completion of setup at startup
      once = true,
      callback = function()
        ts.install(ts_parsers, { max_jobs = 2 })                   -- no-op if parser is already downloaded
      end
    })


    -- Async parser loading
    -- Async nature is achieved by defering loading logic to main event loop.
    local ns = vim.api.nvim_create_namespace("treesitter.async")
    -- Decoration provider is to used to use schedule_wrap
    vim.api.nvim_set_decoration_provider(ns, {
      on_start = vim.schedule_wrap(function()
        if #parsers_pending == 0 then
          return false
        end
        for _, data in ipairs(parsers_pending) do
          -- Load parsers only for valid buffers
          if vim.api.nvim_buf_is_valid(data.buf) then
            if start(data.buf, data.lang) then
              parsers_loaded[data.lang] = true
            else
              parsers_failed[data.lang] = true
            end
          end
        end
        parsers_pending = {}
      end),
    })

    local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

    local ignore_filetypes = {
      'checkhealth',
      'lazy',
      'mason',
      'snacks_dashboard',
      'snacks_notif',
      'snacks_win',
    }

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      desc = 'Enable treesitter highlighting and indentation (non-blocking)',
      callback = function(event)
        -- Ignore filetypes logic
        if vim.tbl_contains(ignore_filetypes, event.match) then
          return
        end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf

        -- Skip enabling failed parsers
        if parsers_failed[lang] then
          return
        end

        if parsers_loaded[lang] then
          -- Parser already loaded, start immediately (fast path)
          start(buf, lang)
        else
          -- Queue for async loading
          table.insert(parsers_pending, { buf = buf, lang = lang })
        end

        -- Auto-install missing parsers (async, no-op if already installed)
        -- Mostly redudundant due to bulk install after LazyDone User event by lazy.nvim
        -- Still helpful when installing and using new parsers without restarting Neovim
        ts.install({ lang })
      end,
    })
  end
}
