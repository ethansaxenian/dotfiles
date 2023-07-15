function _FzfFiles()
   local is_git = os.execute('git rev-parse --is-inside-work-tree 2>/dev/null')
   if is_git == 0 then
      vim.cmd("GFiles --cached --others")
   else
      vim.cmd("Files")
   end
end

function _AllFiles()
   vim.fn['fzf#vim#files']('~', vim.fn['fzf#vim#with_preview']())
end

vim.keymap.set("n", "<Plug>FzfFiles", _FzfFiles)
vim.keymap.set("n", "<Plug>FzfAllFiles", _AllFiles)
