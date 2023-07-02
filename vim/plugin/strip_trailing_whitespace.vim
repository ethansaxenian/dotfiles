function s:StripTrailingWhitespace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespace()

nnoremap <Plug>StripTrailingWhitespace :<C-U>call <SID>StripTrailingWhitespace()<CR>
