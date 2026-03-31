vim.pack.add({
  { src = "https://github.com/EdenEast/nightfox.nvim" },
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

vim.cmd.colorscheme("nightfox")
