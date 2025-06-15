--- @module 'lazy'
--- @type LazySpec
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
    init = function()
      local gitsigns = require("gitsigns")

      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
      vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
      vim.keymap.set("n", "<leader>hq", gitsigns.setqflist)
    end,
  },
}
