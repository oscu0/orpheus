" colorscheme base16-solarized-light
set bg=light
set scrolloff=2
set sidescrolloff=2
" set guifont=Source\ Code\ Pro:h13
" set guifontwide=Source\ Code\ Pro:h13
set guifont=CMU\ TypeWriter\ Text:h14
set guifontwide=CMU\ TypeWriter\ Text:h14
set mouse=a
" macmenu File.New\ Tab key=<nop>
" macmenu File.Close key=<nop>
" map <D-w> :bd<cr>
" imap <D-w> :bd<cr>
" map <D-t> :enew<cr>
" imap <D-t> :enew<cr>

set macmeta
map <D-M-l> :Autoformat<cr>
imap <D-M-l> :Autoformat<cr>
map <C-Tab> gt<cr>
imap <C-Tab> gt<cr>
map <C-S-Tab> gT<cr>
imap <C-S-Tab> gT<cr>
if has("gui_macvim")
    source $CUSTOM_PATH/vim/darwin_mapping.vim
endif

set guioptions=Pgrkme!
set guicursor+=a:blinkon500-blinkoff500
" let g:airline#extensions#tabline#show_buffers = 0
" let g:airline#extensions#tabline#show_tabs = 0
" let g:airline#extensions#tabline#enabled = 0
let g:pymode_python = 'python3'
let g:ycm_server_python_interpreter='/usr/local/bin/python3'
set cursorline
let NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeMapOpenInTabSilent = '<2-LeftMouse>'

