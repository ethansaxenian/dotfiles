local function git()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end

  local head = git_info.head
  local added = git_info.added and (" +" .. git_info.added) or ""
  local changed = git_info.changed and (" ~" .. git_info.changed) or ""
  local removed = git_info.removed and (" -" .. git_info.removed) or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end

  return table.concat({
    head,
    "%#GitSignsAdd#",
    added,
    "%#GitSignsChange#",
    changed,
    "%#GitSignsDelete#",
    removed,
    "%#StatusLine#",
  })
end

function Statusline()
  return table.concat({
    "%2.2n ",
    "%.50F ",
    "%h%m%r%w ",
    git(),
    " %{strlen(&ft)?&ft:'none'} ",
    "%=",
    vim.diagnostic.status(),
    " %(%l/%L,%c%V%) %P ",
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "GitSignsUpdate",
  group = vim.api.nvim_create_augroup("statusline_git", {}),
  command = "redrawstatus",
})

vim.o.statusline = "%{%v:lua.Statusline()%}"
