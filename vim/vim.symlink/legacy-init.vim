" vim roots {{{
if has('win32') || has ('win64')
  let $VIM_HOME = $HOME."/AppData/Local/nvim"
else
  let $VIM_HOME = $HOME."/.config/nvim"
endif
let $NEOVIM_LUA_INIT = $VIM_HOME.'/init.lua'
let $NEOVIM_VIMSCRIPT_INIT = $VIM_HOME.'/legacy-init.vim'
let $VIM_VIMRC = $VIM_HOME.'/vimrc.vim'
let $VIM_PLUG = $VIM_HOME.'/plug.vim'
let $VIM_G_INIT = $VIM_HOME.'/ginit.vim'
if !exists("$VIM_CONFIG")
  let $VIM_CONFIG = $VIM_HOME.'/config.vim'
endif
nnoremap <leader>Ve  :e $VIM_VIMRC<cr>
nnoremap <leader>Vn  :e $NEOVIM_VIMSCRIPT_INIT<cr>
nnoremap <leader>Vl  :e $NEOVIM_LUA_INIT<cr>
nnoremap <leader>Vp  :e $VIM_PLUG<cr>
nnoremap <leader>Vg  :e $VIM_G_INIT<cr>
" }}

" Source the ~/.vimrc
source $VIM_VIMRC

" for nvim-lsp
" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

