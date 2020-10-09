let b:ale_fixers = [
            \   'remove_trailing_lines',
            \   'isort',
            \   'ale#fixers#generic_python#BreakUpLongLines',
            \   'yapf',
            \]


" Quick run via <F5>
nnoremap <F5> :AsyncRun time python3 % <CR>

" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 15
