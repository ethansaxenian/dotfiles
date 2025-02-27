return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "rafamadriz/friendly-snippets", "andersevenrud/cmp-tmux" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { "lazydev", "tmux", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          tmux = {
            name = "tmux",
            module = "blink.compat.source",
            opts = { label = "" },
          },
        },
      },

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
          },
        },
      },
    },
  },
}
