call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug '/usr/local/opt/fzf'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'JuliaEditorSupport/julia-vim' ", {'for': 'julia'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Xuyuanp/nerdtree-git-Plugin', {'on': 'NERDTreeToggle'}
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterSignsToggle'}
Plug 'altercation/vim-colors-solarized'
Plug 'alvan/vim-closetag'
Plug 'andymass/vim-matchup'
Plug 'bling/vim-airline'
Plug 'bothyhead/delphi', {'for': ['pascal', 'delphi']}
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'chrisbra/Colorizer'
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'chriskempson/base16-vim'
Plug 'gcollura/vim-masm', { 'for': 'asm' }
Plug 'godlygeek/tabular'
Plug 'idanarye/vim-vebugger'
Plug 'jalvesaq/nvim-r', {'for': 'r'}
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'jiangmiao/auto-pairs'
Plug 'kshenoy/vim-signature', { 'on': 'SignatureToggle' }
Plug 'lervag/vimtex', { 'for': [ 'latex', 'plaintex' ]}
Plug 'majutsushi/tagbar'
Plug 'mxw/vim-jsx', {'for': ['javascript']}
Plug 'Nopik/vim-nerdtree-direnter', {'on': 'NERDTreeToggle'}
Plug 'octref/rootignore'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'rizzatti/dash.vim', {'on': ['Dash', 'DashKeywords']}
Plug 'rsmenon/vim-mathematica', { 'for': 'mma' }
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-classpath', {'for': ['java']}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tshirtman/vim-cython', { 'for': ['python', 'cython'] }
if v:version + has('patch584') >= 704
    Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clang-completer --js-completer --go-completer --rust-completer' }
endif
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/django.vim', {'for': ['python', 'css', 'html']}
Plug 'vim-scripts/taglist.vim'
Plug 'w0rp/ale'
Plug 'wincent/command-t', {'on' : 'CommandT', 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
call plug#end()
