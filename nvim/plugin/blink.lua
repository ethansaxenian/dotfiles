---@module 'blink-cmp-tmux'
---@module 'blink-cmp-env'

vim.pack.add({
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/ethansaxenian/blink-cmp-tmux", name = "blink-cmp-tmux" },
  { src = "https://github.com/ethansaxenian/blink-cmp-env", name = "blink-cmp-env" },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("*"),
  },
})

require("blink.cmp").setup(
  ---@type blink.cmp.Config
  {
    sources = {
      default = {
        "lazydev",
        "tmux",
        "lsp",
        "path",
        "snippets",
        "buffer",
        "env",
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        tmux = {
          name = "tmux",
          module = "blink-cmp-tmux",
          ---@type blink-cmp-tmux.Opts
          opts = {
            panes = "session",
          },
          score_offset = -10,
        },
        env = {
          name = "env",
          module = "blink-cmp-env",
          score_offset = -10,
        },
      },
    },

    snippets = { preset = "luasnip" },

    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },

    completion = {
      accept = {
        auto_brackets = { enabled = false },
      },

      menu = {
        draw = {
          gap = 1,
          columns = {
            { "label" },
            { "label_description" },
            { "kind_icon" },
            { "kind" },
            { "source_name" },
          },
          components = {
            label_description = {
              text = function(ctx)
                -- Add source module to gopls completions
                if ctx.kind == "Module" and ctx.item.detail and ctx.item.client_name == "gopls" then
                  return ctx.label_description .. ctx.item.detail
                end
                return ctx.label_description
              end,
            },
          },
        },
      },
    },

    cmdline = {
      keymap = {
        preset = "cmdline",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
    },
  }
)
