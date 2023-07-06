let g:git_branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
function s:SetBranch()
  let g:git_branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatusLineGit()
  return strlen(g:git_branch) > 0 ? '[Git('.g:git_branch.')]' : ''
endfunction

autocmd FocusGained,ShellCmdPost * :call <SID>SetBranch()

