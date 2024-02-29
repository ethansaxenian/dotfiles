local function _FzfFiles()
  local is_git = os.execute("git rev-parse --is-inside-work-tree 2>/dev/null")
  if is_git == 0 then
    vim.cmd("GFiles --cached --others --exclude-standard")
  else
    vim.cmd("Files")
  end
end

vim.g.fzf_layout = { window = { width = 1, height = 1 } }
vim.g.fzf_preview_window = { "right,50%", "ctrl-p" }

vim.keymap.set("n", "<leader>b", vim.cmd.Buffers)
vim.keymap.set("n", "<leader>h", function()
  vim.cmd("History:")
end)
vim.keymap.set("n", "<leader>f", _FzfFiles)
vim.keymap.set("n", "<leader>F", function()
  vim.cmd("Files ~")
end)
vim.keymap.set("n", "<leader>rg", vim.cmd.RG)
vim.keymap.set("n", "<leader>sh", vim.cmd.Help)

return {
  "junegunn/fzf",
  "junegunn/fzf.vim",
}
