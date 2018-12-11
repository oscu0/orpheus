" autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
au BufRead,BufNewFile *.m set filetype=mma
autocmd FileType mma setlocal commentstring=(*\ %s\ *)
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
" autocmd! VimEnter * Minimap
augroup filetypedetect
    au BufRead,BufNewFile *.wms set filetype=mma
augroup END
autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup python
    autocmd FileType python set colorcolumn=72,79,132
augroup END
filetype plugin indent on
" autocmd! VimEnter * ColorHighlight
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.xml,*.mhtml'
let g:colorizer_auto_filetype='css,html,xml,mhtml,js,jsx'
let g:formatdef_jsx='"js-beautify -e4x"'
let g:formatters_javascript_jsx=['jsx']
let g:formatters_jsx=['jsx']
let g:jsx_ext_required = 0
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,ucs-bom
set nobackup
set noswapfile
set softtabstop=4 shiftwidth=4 expandtab
set spell
set spelllang=en_us,de_de,ru_ru
set timeoutlen=1000 ttimeoutlen=50

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0


