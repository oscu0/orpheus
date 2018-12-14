" UltiSnips triggering
" imap jj <Esc>
" let g:UltiSnipsExpandTrigger = '<C-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
" let g:UltiSnipsJumpForwardTrigger = '<C-j>'
" map <Esc>[Z <s-tab>
" map <silent> <F12> :exec 'colorscheme' (g:colors_name ==# 'Tomorrow') ? 'Tomorrow-Night-Bright' : 'Tomorrow'<CR>
nmap <S-Space> <Plug>(ac-smooth-scroll-c-b)
nmap <Space> <Plug>(ac-smooth-scroll-c-f)
nmap <silent> <PageDown> <Plug>(ac-smooth-scroll-c-f)
nmap <silent> <PageUp> <Plug>(ac-smooth-scroll-c-b)
nnoremap <C-`> :buffers<CR>:buffer<Space>
" noremap <silent> <PageDown> :call comfortable_motion#flick(-200)<CR>
" noremap <silent> <PageUp> :call comfortable_motion#flick(200)<CR>
" ounmap <Esc>[Z
cnoreabbrev fixTabs "%s/       / "
let g:vebugger_leader='<Leader>d'
map gn :bn<cr>
map gp :bp<cr>
" nmap <S-Space> <C-b>
" nmap <Space> <C-f>
nnoremap <leader>g :GitGutterSignsToggle<CR>
nnoremap <leader>l :Autoformat<CR>
nnoremap <leader>m :SignatureToggle<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>t :TagbarToggle<CR>
" nnoremap <leader>t :TlistSync<CR>:TlistToggle<CR>
nnoremap n nzz
noremap <leader>f :NERDTreeToggle<CR>
noremap <leader>a :ToggleBool<CR>
