exec 'source' custom_path . 'base16.vim'

" function! Render_Only_File(...)
"   let builder = a:1
"   let context = a:2

"   call builder.add_section('file', '!! %F')

"   return 0   " the default: draw the rest of the statusline
"   return -1  " do not modify the statusline
"   return 1   " modify the statusline with the current contents of the builder
" endfunction
" call airline#add_inactive_statusline_func('Render_Only_File')
" let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_close_button = 1
" let g:airline_powerline_fonts = 0


" hi StatusLinePath ctermfg=cterm02 ctermbg=white
" highlight def StatusLinePath ctermbg=18 ctermfg=darkgreen


function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf(
        \ '<W:%d E:%d>',
        \ l:all_non_errors,
        \ l:all_errors
        \)
endfunction

function WasSaved() 
  if bufname('') != ""
    return strftime('%H:%M:%S',getftime(expand('%')))
  else
    return ""
  endif
endfunction

function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
  endfunction
let hostname=ChompedSystem("hostname -f")
let user=ChompedSystem("whoami")

hi StatusLine ctermbg=18
highlight stl ctermfg=03


set statusline=
set statusline+=%#Todo#
set statusline+=%{WasSaved()}
set statusline+=\ 
set statusline+=%#LineNr#
set statusline+=\[
set statusline+=\%#GitGutterChangeDelete#
set statusline+=%{user}
set statusline+=%#LineNr#
set statusline+=@
set statusline+=%#GitGutterAdd#
set statusline+=%{hostname}
set statusline+=\:
set statusline+=%#LineNr#
" set statusline+=%y
" set statusline+=\ 
set statusline+=%#SignifySignChange#
set statusline+=%f
set statusline+=%#LineNr#
set statusline+=\]
set statusline+=%#FoldColumn#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#LineNr#
set statusline+=\ 
set statusline+=%m
set statusline+=%r
set statusline+=\ 
set statusline+=%=
set statusline+=\ 
set statusline+=%#Error#
set statusline+=%{LinterStatus()}
set statusline+=%#LineNR#
set statusline+=\ 
set statusline+=%c:
set statusline+=%l
set statusline+=\ 
set statusline+=%{\"[\".(&fenc==\"\"?&enc:&fenc).\"]\ \"}
set statusline+=%#LineNr#

set laststatus=2

" set noshowmode
" set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup
let term_program = $TERM_PROGRAM
if term_program == 'iTerm.app'
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
set cursorline
if has("mouse")
  set ttyfast
  set mouse=a
end
" set clipboard=unnamed
highlight lCursor guifg=NONE guibg=Cyan
let g:ycm_autoclose_preview_window_after_completion = 1
set background=light
set backspace=indent,eol,start
set breakindent
set colorcolumn=80,132
set expandtab
set grepprg=grep\ -nH\ $*
set guioptions=
set hidden
set history=1000
set ignorecase
set iminsert=0
set imsearch=0
set incsearch
set laststatus=1
set noautoindent
set nohlsearch
set number
set ruler
set scrolloff=0
set shiftwidth=4
set shortmess=atI
set showmatch
set sidescrolloff=0
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitbelow
set splitright
set switchbuf=usetab,newtab
set tabstop=4
set ttimeoutlen=50
set undolevels=1000
set wildignorecase
set wildmenu
set wildmode=list:longest,full
set wrap
syntax enable
