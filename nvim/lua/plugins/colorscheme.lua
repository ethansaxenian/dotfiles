---@module 'lazy'
---@type LazySpec
return {
  {
    "EdenEast/nightfox.nvim",
    opts = {
      -- options = { inverse = { visual = true } },
      palettes = {
        nightfox = {
          -- swap background and statusline colors
          bg1 = "#131a24",
          bg0 = "#192330",
        },
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      disable_italics = true,
    },
  },
}
