-- don't autosuggest with copilot - only when <M-\> is pressed
vim.g.copilot_filetypes = {
  ["*"] = false,
}

return {
  "github/copilot.vim",
}
