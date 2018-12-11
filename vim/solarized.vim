" set termguicolors
set t_Co=16
nnoremap <silent> <F12> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap <silent> <C-F12> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
colorscheme solarized
set bg=dark
let g:solarized_termtrans=0
let g:airline_theme='solarized'
" let g:solarized_termcolors=256
