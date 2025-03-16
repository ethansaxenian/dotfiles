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
            score_offset = -10,
          },
        },
      },

      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },

      completion = {
        keyword = { range = "full" },

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
    },
  },
}
