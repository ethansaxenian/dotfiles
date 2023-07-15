require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "vim", "vimdoc", "go" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
