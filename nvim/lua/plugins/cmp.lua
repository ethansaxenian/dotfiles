return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "andersevenrud/cmp-tmux",
    },
    opts = function()
      local cmp = require("cmp")

      return {
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "tmux" },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
              tmux = "[TMUX]",
            })[entry.source.name]
            return vim_item
          end,
        },
      }
    end,
  },
}
