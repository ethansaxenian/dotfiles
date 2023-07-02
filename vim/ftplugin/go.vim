let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 1

setlocal foldmethod=indent
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal noexpandtab

let b:undo_ftplugin = '|setlocal foldmethod< tabstop< shiftwidth< softtabstop< expandtab<'
