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
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk)
      vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk)
      vim.keymap.set("n", "<leader>hq", require("gitsigns").setqflist)
    end,
  },
}
