return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = "rafamadriz/friendly-snippets",
    opts = {
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
      sources = { cmdline = {} },
    },
    init = function()
      vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { link = "Special" })
      vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { link = "Comment" })
      vim.api.nvim_set_hl(0, "BlinkCmpSource", { link = "Comment" })
    end,
  },
}
