call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
packadd! matchit
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-flagship'
Plug 'ervandew/supertab'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'vim-scripts/taglist.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
" Plug 'valloric/youcompleteme'
Plug 'mbbill/undotree'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

let base16colorspace=256  " Access colors present in 256 colorspace
set termguicolors
Plug 'chriskempson/base16-vim'

"Plug 'dense-analysis/ale'

Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-apathy'
Plug 'rsmenon/vim-mathematica'
" let g:mma_highlight_option = "solarized"
Plug 'marrub--/vim-zscript'
Plug 'ryz/vim-zdoom-decorate-syntax'
Plug 'tpope/vim-jdaddy'

call plug#end()
    if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    endif
    " set notermguicolors
    " set wildignorecase
    set backspace=indent,eol,start
    set clipboard=unnamed
    set history=1000
    set incsearch
    set laststatus=1
    set laststatus=2
    set mouse=a
    set nocursorline
    set nohlsearch
    set number
    set ruler
    set scrolloff=2
    set sidescrolloff=2
    set shortmess=atI
    set showmatch
    set softtabstop=4 shiftwidth=4 expandtab
    set splitbelow
    set splitright
    set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,bytval=0x%B,%n%Y%)\%P
    set switchbuf=usetab,newtab
    set t_Co=16
    set ttimeoutlen=50
    set wildmenu
    set wildmode=list:longest,full
    set wrap
    set wrapscan
    silent! set breakindent
    silent! set colorcolumn=80,132
    syntax enable
    set bg=light
    highlight ColorColumn ctermbg=8 guibg=Yellow
    nnoremap n nzz
    nnoremap N Nzz
    cnoreabbrev fixTabs "%s/       / "
    " nnoremap <C-`> :buffers<CR>:buffer<Space>
    map gn :bn<CR>
    map gp :bp<CR>
    map gJ J
    map gS a<CR><ESC>

    imap <C-a> <C-o>^
    imap <C-b> <C-o>h
    imap <C-d> <C-o>x
    imap <C-e> <C-o>$
    imap <C-f> <C-o>l
    " imap <C-h> <C-o>X
    imap <C-k> <C-o>d$
    " imap <C-n> <C-o>j
    " imap <C-p> <C-o>b
    imap <D-BS> <C-o>d^
    imap <D-DEL> <C-o>d$
    imap <M-BS> <C-o>db
    imap <M-DEL> <C-o>dw
    imap <M-b> <C-o>b
    imap <M-d> <C-o>dw
    imap <M-f> <C-o>e
    imap <M-\<> gg
colorscheme base16-solarized-light
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
