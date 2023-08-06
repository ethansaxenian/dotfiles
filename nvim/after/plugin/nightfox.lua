if not pcall(require, "nightfox") then
  return
end

require("nightfox").setup({
  palettes = {
    nightfox = {
      -- swap background and statusline colors
      bg1 = "#131a24",
      bg0 = "#192330",
    },
  },
})
