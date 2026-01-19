---@module 'lazy'
---@type LazySpec
return {
  {
    "github/copilot.vim",
    lazy = true,
    cmd = "Copilot",
    init = function()
      -- don't autosuggest with copilot - only when <M-\> is pressed
      vim.g.copilot_filetypes = { ["*"] = false }
    end,
  },
}
