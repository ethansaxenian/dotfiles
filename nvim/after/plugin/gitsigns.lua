if not pcall(require, "gitsigns") then
  return
end

require("gitsigns").setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk)
