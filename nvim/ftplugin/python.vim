setlocal foldmethod=indent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

let b:undo_ftplugin = '|setlocal foldmethod< tabstop< shiftwidth< softtabstop< expandtab<'

autocmd BufWritePre * :PyrightOrganizeImports
