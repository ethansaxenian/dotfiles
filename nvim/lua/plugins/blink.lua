--- @module 'lazy'
--- @module 'blink.cmp'
--- @module 'blink-cmp-tmux'

--- @type LazySpec
return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "ethansaxenian/blink-cmp-tmux",
        -- dir = "~/projects/blink-cmp-tmux/",
        -- name = "blink-cmp-tmux",
        -- dev = true,
      },
    },

    --- @type blink.cmp.Config
    opts = {
      sources = {
        default = {
          "lazydev",
          "tmux",
          "lsp",
          "path",
          "snippets",
          "buffer",
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
            --- @type blink-cmp-tmux.Opts
            opts = {
              panes = "session",
            },
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
      cmdline = {
        keymap = { preset = "inherit" },
      },
    },
  },
}
