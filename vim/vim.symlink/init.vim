" vim: set foldlevel=1 :
" you need this before rtp+=ing any themes, otherwise they configure
" themselves with 256 colors, or maybe Airline does
set termguicolors

" Source ~/.vimrc, vim-plug {{{
" vim roots {{{
if has('win32') || has ('win64')
  let $VIM_HOME = $HOME."/AppData/Local/nvim"
else
  let $VIM_HOME = $HOME."/.config/nvim"
endif
let $VIM_INIT = $VIM_HOME.'/init.vim'
let $VIM_VIMRC = $VIM_HOME.'/vimrc.vim'
let $VIM_PLUG = $VIM_HOME.'/plug.vim'
let $VIM_G_INIT = $VIM_HOME.'/ginit.vim'
if !exists("$VIM_CONFIG")
  let $VIM_CONFIG = $VIM_HOME.'/config.vim'
endif

nnoremap <leader>Ve  :e $VIM_VIMRC<cr>
nnoremap <leader>Vn  :e $VIM_INIT<cr>
nnoremap <leader>Vp  :e $VIM_PLUG<cr>
nnoremap <leader>Vg  :e $VIM_G_INIT<cr>
" }}}

" Source the ~/.vimrc
source $VIM_VIMRC
runtime! python_setup.vim
" after because vimrc also maps this
nnoremap <leader>Vs  :so $VIM_INIT<cr>

" }}}
" colorscheme, appearance {{{

let g:github_colors_soft = 1
let g:github_colors_block_diffmark = 1
let g:airline_theme = "github"
let g:lightline.colorscheme = "github"
colorscheme github
unmap <f5>
nnoremap <f5> :call github_colors#toggle_soft()<cr>

set titlestring=nvim:\ %f\ %a%r%m

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
  setl indentkeys+=0.
  setl foldmethod=marker foldmarker=#region,#endregion
  setl signcolumn=yes

  " let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
endfunction
augroup TYPESCRIPT
    autocmd!
    autocmd FileType typescript execute Typescript()
augroup END

" }}}
" LanguageClient-neovim / LSP {{{
if g:cormacrelf.LanguageClient

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = "location"
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = $HOME.'/.config/nvim/settings.json'
let g:LanguageClient_completionPreferTextEdit = 1

let g:LanguageClient_serverCommands = {
      \ 'cpp': ['ccls', '--log-file=/tmp/ccls.log'],
      \ 'c': ['ccls', '--log-file=/tmp/ccls.log'],
      \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
      \ 'go': ['go-langserver']
      \ }
let g:LanguageClient_rootMarkers = {
      \ 'typescript': ['tsconfig.json']
      \ }

if executable('typescript-language-server') && executable('tsserver')
  let  g:LanguageClient_serverCommands.typescript = [
        \'typescript-language-server', '--stdio',
        \'--tsserver-path=tsserver']
        " \+ [ '--tsserver-log-file', '/tmp/tsserver-log', '--tsserver-log-verbosity', 'verbose',
        " \]
  " let  g:LanguageClient_serverCommands.typescript = [
  "       \'javascript-typescript-stdio', '--logfile', '/tmp/js-ts-log'
  "       \]
endif

" only enable the mappings for filetypes that have an lsp associated with them
func! LSP()
  " IDE-style mappings to language server
  nnoremap <buffer> <silent> <F11> :call LanguageClient_textDocument_references()<cr>
  nnoremap <buffer> <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <buffer> <silent> gK :call LanguageClient_textDocument_hover()<CR>
  nnoremap <buffer> <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <buffer> <silent> <F12> :call LanguageClient_textDocument_definition()<CR>
  nnoremap <buffer> <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  nnoremap <buffer> <silent> g. :call LanguageClient_textDocument_codeAction()<CR>
endfunc
augroup LSP
  au!
  for lang in keys(g:LanguageClient_serverCommands)
    exec "au Filetype ".lang." call LSP()"
  endfor
augroup END

" diagnostics display {{{
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
endif
" }}}
" ncm2 {{{
if g:cormacrelf.ncm2
  " --- required ---

  " enable ncm2 for all buffer
  autocmd BufEnter * call ncm2#enable_for_buffer()

  " note that must keep noinsert in completeopt, the others is optional
  set completeopt=noinsert,menuone,noselect

  " --- optional ---

  " auto trigger
  au TextChangedI * call ncm2#auto_trigger()

  " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
  inoremap <c-c> <ESC>

  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new
  " line.
  " inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

  " Use <TAB> to select the popup menu:
  inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<tab>"
  inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " --- using ultisnips ---

  if g:cormacrelf.snippets
    " Press enter key to trigger snippet expansion
    " The parameters are the same as `:help feedkeys()`
    inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
    inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " c-j c-k for moving in snippet
    let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
    let g:UltiSnipsJumpForwardTrigger = "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
    let g:UltiSnipsRemoveSelectModeMappings = 0
  endif

endif

" https://github.com/SirVer/ultisnips/issues/593
if g:cormacrelf.snippets
  augroup ultisnips_no_auto_expansion
    au!
    au VimEnter * au! UltiSnips_AutoTrigger
  augroup END
endif

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

" }}}
" Angular{{{

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

" let g:neomake_typescript_enabled_makers = ['tslint']
" call neomake#configure#automake('')

" }}}
" Goyo {{{

function! s:goyo_enter()
  " silent !tmux set status off
  " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set showmode
  set scrolloff=2
  " set showbreak=↪\ \ \ 
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=2
  set showbreak=
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}
" Coq {{{

function! Coq()
    command! Coq call CoqLaunch()
    call coquille#FNMapping()
    if &background == 'dark'
        hi CheckedByCoq ctermbg=10 guibg='#2F4C40'
        hi SentToCoq ctermbg=12 guibg='#53B087'
    else
        hi CheckedByCoq ctermbg=10 guibg='#90ee90'
        hi SentToCoq ctermbg=12 guibg=LimeGreen
    endif
endfunction
augroup COQ
    autocmd!
    autocmd FileType coq execute Coq()
augroup END

" }}}


