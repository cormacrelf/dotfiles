set nocompatible
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

" Source the ~/.vimrc, for compat reasons.
source ~/.vimrc

colorscheme gotham
let g:airline_theme = "gotham"
runtime! plugin/python_setup.vim

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l

