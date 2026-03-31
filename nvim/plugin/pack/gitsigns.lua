vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
})

local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
})

vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "gitsigns.preview_hunk" })
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "gitsigns.reset_hunk" })
vim.keymap.set("n", "<leader>hq", gitsigns.setqflist, { desc = "gitsigns.setqflist" })
