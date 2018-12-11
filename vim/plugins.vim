call plug#begin()
Plug 'VundleVim/Vundle.vim'
if v:version + has('patch584') >= 704
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --js-completer --go-completer --rust-completer' }
endif
Plug 'wincent/command-t', {'on' : 'CommandT', 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'Chiel92/vim-autoformat'
Plug 'janko-m/vim-test'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger'
" Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-git'
Plug 'octref/rootignore'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-classpath', {'for': ['java']}
" Plug 'pangloss/vim-javascript', {'for': ['javascript']}
Plug 'mxw/vim-jsx', {'for': ['javascript']}
Plug 'w0rp/ale'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'rizzatti/dash.vim', {'on': ['Dash', 'DashKeywords']}
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'bothyhead/delphi', {'for': ['pascal', 'delphi']}
Plug 'chriskempson/base16-vim'
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-dadbod'
Plug 'vim-scripts/django.vim', {'for': ['python', 'css', 'html']}
Plug 'JuliaEditorSupport/julia-vim' ", {'for': 'julia'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-Plugin', {'on': 'NERDTreeToggle'}
Plug 'jalvesaq/nvim-r', {'for': 'r'}
Plug 'alvan/vim-closetag'
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-commentary'
Plug 'tshirtman/vim-cython', { 'for': ['python', 'cython'] }
Plug 'tpope/vim-endwise'
" Plug 'jcf/vim-latex', { 'for': 'latex'}
Plug 'lervag/vimtex', { 'for': [ 'latex', 'plaintex' ]}
Plug 'ludovicchabant/vim-gutentags'
Plug 'andymass/vim-matchup'
Plug 'tommcdo/vim-lion'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'skwp/greplace.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'gcollura/vim-masm', { 'for': 'asm' }
Plug 'rsmenon/vim-mathematica', { 'for': 'mma' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'kshenoy/vim-signature', { 'on': 'SignatureToggle' }
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterSignsToggle'}
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
" Plug 'chriskempson/vim-tomorrow-theme'
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
call plug#end()
