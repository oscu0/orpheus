set bg=light
set t_Co=256
set termguicolors
" colorscheme base16-solarized-light
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  let g:airline_theme="base16"
  hi Normal ctermbg=none
  hi NonText ctermbg=none
endif
