return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
    },
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "html",
        "go",
        "gomod",
        "gosum",
        "json",
        "lua",
        "python",
        "templ",
        "toml",
        "tsx",
        "typescript",
        "javascript",
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
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
