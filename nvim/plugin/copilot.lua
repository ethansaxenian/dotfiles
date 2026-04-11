vim.pack.add({
  "https://github.com/github/copilot.vim",
})

-- don't autosuggest with copilot - only when <M-\> is pressed
vim.g.copilot_filetypes = { ["*"] = false }
