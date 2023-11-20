if not pcall(require, "nvim-treesitter") then
  return
end

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "dockerfile",
    "go",
    "gomod",
    "gosum",
    "json",
    "lua",
    "python",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
      include_surrounding_whitespace = true,
    },
  },
})
