vim.api.nvim_create_user_command("Copilot", function()
  vim.pack.add({
    "https://github.com/github/copilot.vim",
  })

  -- don't autosuggest with copilot - only when <M-\> is pressed
  vim.g.copilot_filetypes = { ["*"] = false }
end, {})
