" Source ~/.vimrc, vim-plug {{{
if has('win32') || has ('win64')
  let $VIM_HOME = ~/AppData/Local/nvim
else
  let $VIM_HOME = $HOME."/.config/nvim"
endif

let $VIM_INIT = $VIM_HOME.'/init.vim'
let $VIM_VIMRC = $VIM_HOME.'/vimrc.vim'
let $VIM_PLUG = $VIM_HOME.'/plug.vim'

" Source the ~/.vimrc
source $VIM_VIMRC

nnoremap <leader>Vs  :so $VIM_INIT<cr>
nnoremap <leader>Ve  :e $VIM_VIMRC<cr>
nnoremap <leader>Vn  :e $VIM_INIT<cr>
nnoremap <leader>Vp  :e $VIM_PLUG<cr>
if has('win32')
    nnoremap <leader>Ve  :e $VIM_VIMRC<cr>
endif

runtime! python_setup.vim


autocmd BufRead *.vim,.*vimrc set foldenable foldmethod=marker foldlevel=0

" }}}
" colorscheme, appearance {{{

colorscheme base16-dracula
let g:airline_theme = "dracula"
set background=dark
let g:two_firewatch_italics=1

set titlestring=nvim:\ %f\ %a%r%m

if has('termguicolors')
    set termguicolors
endif
if has('guicursor')
    set guicursor
endif

" }}}
" Embedded terminal {{{

" Handy shortcuts for switching away from the terminal window
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l

" }}}
" LanguageClient / LanguageServer {{{
"
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio']
    \ }

" do this where you want deoplete
autocmd FileType typescript call deoplete#enable()
autocmd FileType javascript call deoplete#enable()
autocmd FileType rust call deoplete#enable()
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer']

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gK :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F12> :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" }}}
" Denite.vim {{{

" Change mappings.
call denite#custom#map(
			\ 'insert',
			\ '<C-n>',
			\ '<denite:move_to_next_line>',
			\ 'noremap'
			\)
call denite#custom#map(
			\ 'insert',
			\ '<C-p>',
			\ '<denite:move_to_previous_line>',
			\ 'noremap'
			\)

" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
			\ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" }}}
