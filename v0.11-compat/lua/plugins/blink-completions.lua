return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  build = 'cargo +nightly build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'none',

      -- Navigation in completion window
      ["<C-j>"] = { 'show', 'select_next', 'fallback' },
      ["<C-k>"] = { 'show', 'select_prev', 'fallback' },

      -- Accept currently selected entry from completion window
      -- Snippet navigation
      ["<C-l>"] = { 'select_and_accept', 'snippet_forward', 'fallback' },
      ["<C-h>"] = { 'snippet_backward', 'fallback' },


      ["<C-m>"] = { 'show_signature', 'hide_signature', 'fallback' },

      -- Documentation navigation
      ["<C-u>"] = { 'scroll_documentation_up', 'fallback' },
      ["<C-d>"] = { 'scroll_documentation_down', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'normal'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      list = { selection = { preselect = true, auto_insert = false } },
      -- menu = { auto_show },
      ghost_text = { enabled = true, show_with_selection = true }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lazydev", 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100
        }
      }
    },

    signature = { enabled = true },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
