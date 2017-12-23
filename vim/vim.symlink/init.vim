" Source ~/.vimrc, vim-plug {{{
if has('win32') || has ('win64')
  let $VIM_HOME = $HOME."/AppData/Local/nvim"
else
  let $VIM_HOME = $HOME."/.config/nvim"
endif

let $VIM_INIT = $VIM_HOME.'/init.vim'
let $VIM_VIMRC = $VIM_HOME.'/vimrc.vim'
let $VIM_PLUG = $VIM_HOME.'/plug.vim'
let $VIM_G_INIT = $VIM_HOME.'/ginit.vim'

" Source the ~/.vimrc
source $VIM_VIMRC

nnoremap <leader>Vs  :so $VIM_INIT<cr>
nnoremap <leader>Ve  :e $VIM_VIMRC<cr>
nnoremap <leader>Vn  :e $VIM_INIT<cr>
nnoremap <leader>Vp  :e $VIM_PLUG<cr>
nnoremap <leader>Vg  :e $VIM_G_INIT<cr>

runtime! python_setup.vim


autocmd BufRead *.vim,.*vimrc set foldenable foldmethod=marker foldlevel=0


set path+=src " for using gf on app/models/blah where app is really src/app

" }}}
" colorscheme, appearance {{{

" let g:two_firewatch_italics=0
" colorscheme two-firewatch
" let g:airline_theme = "twofirewatch"
" set background=dark
colorscheme gruvbox
let g:airline_theme = "gruvbox"
set background=dark

so $VIM_HOME/hybrid-spelling.vim

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
" Typescript {{{

function! Typescript()
  JsPreTmpl html
  syn clear foldBraces
  setlocal indentkeys+=0.
  setl foldmethod=marker foldmarker=#region,#endregion
  " let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
endfunction
augroup TYPESCRIPT
  autocmd!
  autocmd FileType typescript execute Typescript()
augroup END

" }}}
" LanguageClient / LanguageServer {{{
"
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio.cmd'],
    \ 'typescript': ['javascript-typescript-stdio.cmd'],
    \ }
    " \ 'typescript': ['typescript-language-server.cmd', '--stdio']

" do this where you want deoplete
autocmd FileType typescript call deoplete#enable()
autocmd FileType javascript call deoplete#enable()
autocmd FileType rust call deoplete#enable()

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer']
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

command! CompletionToggle call deoplete#toggle() 


autocmd FileType typescript setlocal signcolumn=yes
let g:LanguageClient_diagnosticsDisplay = {
        \ 1: {
            \"name": "Error",
            \"texthl": "ALEError",
            \"signText": ">>",
            \"signTexthl": "ALEErrorSign",
            \},
        \2: {
            \"name": "Warning",
            \"texthl": "ALEWarning",
            \"signText": "!",
            \"signTexthl": "ALEWarningSign",
        \},
        \3: {
            \"name": "Information",
            \"texthl": "ALEInfo",
            \"signText": "i",
            \"signTexthl": "ALEInfoSign",
        \},
        \4: {
            \"name": "Hint",
            \"texthl": "ALEInfo",
            \"signText": "?",
            \"signTexthl": "ALEInfoSign",
        \},
    \}

if !hlexists('ALEError')
    highlight link ALEError SpellBad
endif

if !hlexists('ALEStyleError')
    highlight link ALEStyleError ALEError
endif

if !hlexists('ALEWarning')
    highlight link ALEWarning SpellCap
endif

if !hlexists('ALEStyleWarning')
    highlight link ALEStyleWarning ALEWarning
endif

if !hlexists('ALEInfo')
    highlight link ALEInfo ALEWarning
endif



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

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
" call denite#custom#var('file_rec/git', 'command',
"             \ ['rg', '--files', '--path-separator=/', '.'])
call denite#custom#var('file_rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard', '.'])

nnoremap <silent> <C-p> :<C-u>Denite
            \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
" nnoremap <silent> <C-p> :<C-u>Denite file_rec/git<CR>

call denite#custom#option('_', 'highlight_mode_insert', 'WildMenu')
call denite#custom#option('_', 'highlight_matched_range', 'None')
call denite#custom#option('_', 'highlight_matched_char', 'Underlined')

nnoremap <c-b> :Denite buffer<cr>

" }}}
" IDE-style mappings to language server {{{

nnoremap <silent> <s-f12> :Denite references<cr>
nnoremap <silent> <f11> :Denite documentSymbol<cr>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gK :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F12> :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <c-.> :call LanguageClient_textDocument_codeAction()<CR>

" }}}
" {{{ Terraform

function! Terraform()
    setlocal commentstring=#%s
    " we want nmap so it can use gl
    nmap <leader>= mgvi{gl=`g
    nnoremap gK T"f_l"tyt":!start https://www.terraform.io/docs/providers/aws/r/<C-r>t.html<cr>
    command! Vars above split %:h/variables.tf
    command! Out below split %:h/outputs.tf
    command! Main below split %:h/main.tf
    " opens the main file for a module
    command! -nargs=1 Mod execute 'edit' fnamemodify("modules/".<f-args>."/main.tf", ":p")
endfunc
augroup TERRAFORM
    autocmd!
    autocmd FileType terraform execute Terraform()
augroup END

function! Angular()
    command! Ts above split %:r.ts
    command! Html below split %:r.html
    command! Css below split %:r.scss
    " opens the main file for a module
    " command! -nargs=1 Mod execute 'edit' fnamemodify("modules/".<f-args>."/main.tf", ":p")
    " nnoremap gK T"f_l"tyt":!start https://www.terraform.io/docs/providers/aws/r/<C-r>t.html<cr>
    nmap <leader>= mgvi{gl=`g
endfunc
augroup ANGULAR
    autocmd!
    autocmd FileType typescript execute Angular()
    autocmd FileType html execute Angular()
    autocmd FileType css execute Angular()
augroup END

" }}}
" Neomake {{{

let g:neomake_typescript_enabled_makers = ['tslint']
call neomake#configure#automake('')

" }}}
" {{{

autocmd BufRead *.xaml setf xml

" }}}
