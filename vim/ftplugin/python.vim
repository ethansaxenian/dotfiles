let g:python_highlight_operators = 0
let g:python_highlight_all = 1

setlocal foldmethod=indent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal textwidth=88

let b:undo_ftplugin = '|setlocal foldmethod< tabstop< shiftwidth< softtabstop< expandtab< textwidth<'

autocmd BufWritePre <buffer> :CocCommand pyright.organizeimports
