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
" }}}

" Source the ~/.vimrc
source $VIM_VIMRC

" }}}
" colorscheme, appearance {{{

if has('guicursor')
    set guicursor
endif

" }}}
" Typescript {{{

function! Typescript()
  " JsPreTmpl html
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
      \ 'typescript': ['tsconfig.json'],
      \ 'typescript.tsx': ['tsconfig.json'],
      \ 'typescriptreact': ['tsconfig.json']
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
  
  let g:LanguageClient_serverCommands['typescript.tsx'] = g:LanguageClient_serverCommands.typescript
  let g:LanguageClient_serverCommands['typescriptreact'] = g:LanguageClient_serverCommands.typescript
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
" {{{ Terraform

function! Terraform()
    setlocal commentstring=#%s
    " we want nmap so it can use gl
    nmap <leader>= mgvi{gl=`g
    nnoremap gK T"f_l"tyt":!open https://www.terraform.io/docs/providers/aws/r/<C-r>t.html<cr>
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

hi default CheckedByCoq ctermbg=10 guibg='#90ee90'
hi default SentToCoq ctermbg=12 guibg='#e5e8fa'

function! Coq()
    command! Coq call CoqLaunch()
    call coquille#FNMapping()
    if &background == 'dark'
        " hi CheckedByCoq ctermbg=10 guibg='#2F4C40'
        " hi SentToCoq ctermbg=12 guibg='#53B087'
    else
        " hi CheckedByCoq ctermbg=10 guibg='#90ee90'
        " hi SentToCoq ctermbg=12 guibg='#e5e8fa'
    endif
endfunction
augroup COQ
    autocmd!
    autocmd FileType coq execute Coq()
augroup END

" }}}

if g:cormacrelf.coc " CoC {{{

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd! CursorHold * silent call CocActionAsync('highlight')

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
imap <silent><expr> <C-n> coc#refresh()

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for rename current word
nmap <leader>rf <Plug>(coc-refactor)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> [d <Plug>(coc-diagnostic-prev)

vmap <leader>i  <Plug>(coc-codeaction-selected)
nmap <leader>i  <Plug>(coc-codeaction-selected)
nmap <leader>ii  <Plug>(coc-codeaction)

nmap <leader>.  <Plug>(coc-fix-current)

" inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
let g:coc_snippet_next = '\<c-l>'
let g:coc_snippet_prev = '\<c-k>'

" Use <C-l> to trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> to select text for visual text of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> to jump to forward placeholder, which is default
" let g:coc_snippet_next = '<c-j>'
" Use <C-k> to jump to backward placeholder, which is default
" let g:coc_snippet_prev = '<c-k>'

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

""""""""""""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:expand_jump() abort
  return "\<Plug>(coc-snippets-expand-jump)"
endfunction
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
""""""""""""

""""""""""""
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
""""""""""""

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" vista.vim
let g:vista_default_executive = 'coc'

" coc-jest

" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
" Init jest in current cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')

" lexima.vim

" call lexima#add_rule({'char': '<', 'input_after': '>', 'filetype': 'xml'})
" call lexima#add_rule({'char': '>', 'at': '\%#\>', 'leave': 1, 'filetype': 'xml'})
" call lexima#add_rule({'char': '<BS>', 'at': '\<\%#\$', 'delete': 1, 'filetype': 'xml'})

" }}}
elseif g:cormacrelf.nvim_lsp " {{{

endif " }}}

