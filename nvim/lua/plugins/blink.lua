return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = "rafamadriz/friendly-snippets",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
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
      sources = {
        min_keyword_length = function(ctx)
          -- only applies when typing a command, doesn't apply to arguments
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
            return 2
          end
          return 0
        end,
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { link = "Comment" })
      vim.api.nvim_set_hl(0, "BlinkCmpSource", { link = "Comment" })
    end,
  },
}
