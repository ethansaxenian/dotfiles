vim.pack.add({
  "https://github.com/folke/lazydev.nvim",
})

require("lazydev").setup({
  ---@type lazydev.Config
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
