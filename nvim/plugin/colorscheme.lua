vim.pack.add({
  { src = "https://github.com/EdenEast/nightfox.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
})

require("nightfox").setup({
  -- options = { inverse = { visual = true } },
  palettes = {
    nightfox = {
      -- swap background and statusline colors
      bg1 = "#131a24",
      bg0 = "#192330",
    },
  },
})

require("tokyonight").setup({
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  },
})

vim.cmd.colorscheme("tokyonight-night")
