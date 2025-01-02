return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },

      completion = {
        ghost_text = {
          enabled = true,
        },

        menu = {
          draw = {
            treesitter = { "lsp", "buffer", "path", "snippets" },
            gap = 1,
            columns = {
              { "label" },
              { "label_description" },
              { "kind" },
              { "source_name" },
            },
          },
        },
      },

      sources = {
        cmdline = {},
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { link = "Special" })
      vim.api.nvim_set_hl(0, "BlinkCmpSource", { link = "Comment" })
    end,
  },
}
