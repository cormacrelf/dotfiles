" Equivalent but termguicolors is only in HEAD neovim (and vim)
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2
if has('termguicolors')
    set termguicolors
endif

let g:python_host_prog='/usr/local/bin/python3'

set rtp+=$HOME/.vim " so that we still have autoloads from Vim

" Source the ~/.vimrc, for compat reasons.
source ~/.vimrc

" Neovim overrides

nunmap <leader>Vs
nnoremap <leader>Vs :so ~/.config/nvim/init.vim<cr>

set background=dark
let g:two_firewatch_italics=1
colorscheme gotham
let g:airline_theme = "gotham"
runtime! plugin/python_setup.vim

set titlestring=nvim:\ %f\ %a%r%m

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l

