set hidden
set noerrorbells
set undolevels=1000
set grepprg=grep\ -nH\ $*
set ignorecase
set noincsearch
set smartcase
set autoread
au CursorHold * checktime
set autochdir
set scrolloff=2
set sidescrolloff=2
set autowrite
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set noautoindent
set smartindent
set softtabstop=4
set clipboard=unnamed
set iminsert=0
set imsearch=0
let g:autopep8_disable_show_diff=1
let g:ale_sign_warning = '--'
let g:ale_sign_error = '--'
let g:ale_linters = {
      \   'python': ['flake8'],
      \}

let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
" let g:SuperTabDefaultCompl1tionType = "<c-n>"
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = custom_path . '.ycm_extra_conf.py'
"
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>', '<Tab>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>', '<S-Tab>', '<[Z>']
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_disable_for_files_larger_than_kb = 0
let g:ycm_path_to_python_interpreter = 'python3'
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
" let g:gofmt_on_save=0
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,ucs-bom,prc
" set fileencodings=ucs-bom,utf8,prc
set noswapfile
set nobackup
filetype plugin indent on
let g:polyglot_disabled = ['latex']
let g:matchup_override_vimtex = 1
set timeoutlen=1000 ttimeoutlen=50
command! -nargs=1 FZFS call fzf#run(fzf#wrap({
            \ 'source'  : 'mdfind -onlyin ~ <q-args>',
            \ 'options' : '--color=16 -m --prompt "Spotlight> "'
            \ }))
