set nocompatible

" Base {{{

" Vim home {{{
if $VIM_HOME == ''
    if has('win32') || has ('win64')
        let $VIM_HOME = $HOME."/AppData/Local/nvim"
    else
        let $VIM_HOME = $HOME."/.vim"
    endif
endif
let $VIM_INIT = $VIM_HOME.'/init.vim'
let $VIM_VIMRC = $VIM_HOME.'/vimrc.vim'
let $VIM_PLUG = $VIM_HOME.'/plug.vim'
let $VIM_G_INIT = $VIM_HOME.'/ginit.vim'
if !exists("$VIM_CONFIG")
  let $VIM_CONFIG = $VIM_HOME.'/config.vim'
endif
" }}}
" Shells {{{
" this goes before plug#begin so git can work
" Bash vs CMD on windows
if has("win32") || has("win64") || has("win16")
    "I do other stuff in here...
    imap <c-v> <c-o>:set paste<cr><c-r>+<c-o>:set nopaste<cr>
    "Then only inside this if block for windows, I test the shell value
    "On windows, if called from cygwin or msys, the shell needs to be changed to cmd.exe
    if &shell=~#'bash$'
        set shell=$COMSPEC " sets shell to correct path for cmd.exe
    endif

    " actually just use powershell
    " set shell=powershell
    " set shellcmdflag=-command
endif

command! PlugInstallCmd set shell=bash shellcmdflag=-c | PlugInstall

" use a POSIX compatible shell if you're on fish
if &shell =~# 'fish$'
    set shell=sh
endif
" }}}

" get g:cormacrelf to adapt vim init script to situations
source $VIM_CONFIG

filetype off
call plug#begin($VIM_HOME.'/plugged')
    so $VIM_PLUG
call plug#end()
filetype plugin indent on
syntax on

" Startup {{{
" do this first so any yank mappings still cache
" call yankstack#setup()

if filereadable($VIM_HOME."/private.vim")
    so ~/.vim/private.vim
endif

if !has('nvim')
  set viminfo+=n$VIM_HOME/viminfo
else
  " Do nothing here to use the neovim default
  " or do soemething like:
  " set viminfo+=n~/.shada
endif
" }}}
" }}}

" Settings {{{
" Lightline config {{{

" Airline {{{
if exists('g:airline_detect_iminsert')
    let g:airline_left_sep  = ''
    let g:airline_right_sep = ''
    " Airline WordCount extension
    let b:toggled_ws_once = 1
    " let g:airline_section_y = '%{WordCount()}w'
    let g:airline#extensions#whitespace#enabled = 0
    call airline#parts#define_function('wordcount', 'WordCount')
    call airline#parts#define_condition('wordcount', 'exists("b:wc_enabled") && b:wc_enabled == 1')
    let g:airline_section_y = airline#section#create(['ffenc', ' ', 'wordcount'])
    map <leader>wS :AirlineToggleWhitespace<CR>
endif
" }}}

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype', 'wordcount' ] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \   'fileformat': 'LightlineFileformat',
            \   'filetype': 'LightlineFiletype',
            \   'wordcount': 'LightlineWordCount',
            \ } }

func! s:fname()
  return winwidth(0) > 70 ? expand('%') : expand('%:t')
endfunc
func! LightlineFilename()
  return expand('%:t') =~# 'FZF$' ? 'fzf' :
        \ &buftype == 'quickfix' ? 'quickfix' :
        \ expand('%:t') !=# '' ? s:fname() : '[No Name]'
endfunc
func! LightlineFileformat()
  return winwidth(0) > 90 ? &fileformat : ''
endfunc
func! LightlineFiletype()
  return winwidth(0) > 90 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunc

func! LightlineWordCount()
  if exists("b:wc_enabled") && b:wc_enabled | return string(WordCount()) . 'w' | endif
  return ""
endfunc

" }}}

" 24-bit schemes are set in nvim/gvim's respective configs.
" both source this first, so we don't want to set the scheme twice (clearing
" isn't perfect)
if !(has("nvim") || has("gui_running"))
    set background=light
    set term=xterm-256color
    if $TERM =~ '^\(rxvt\|screen\)\(\|-.*\)'
        set notermguicolors
    elseif $TERM =~ '^\(xterm\|tmux\|alacritty\)\(\|-.*\)'
        set termguicolors
    endif

    colorscheme github
    let g:airline_theme='github'
    let g:lightline.colorscheme = 'github'
endif
nnoremap <f5> :call github_colors#toggle_soft()<cr>

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

set noswapfile
set modeline
set modelines=3
set thesaurus+=$HOME/lib/mthesaur.txt
set path+=include " for headers
set path+=src " for using gf on app/models/blah where app is really src/app

" UI {{{

set ruler                           " show the cursor position all the time
set noshowcmd                       " don't display incomplete commands
set number                          " line numbers
set wildmenu                        " turn on wild menu
set wildmode=list:longest,full
set backspace=2                     " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,]          " backspace and cursor keys wrap to
set shortmess=filtIoOA              " Shorten messages
set report=0                        " tell us about changes
set nostartofline                   " don't jump to the start of line when scrolling
set scrolloff=1                     " scroll early, give us a bit of context
set autoread                        " automatically read changes in files from other applications
set splitright splitbelow           " when :[v]split-ting, go to the right/down
set showmatch                       " brackets/braces that is
set mat=1                           " duration to show matching brace (1/10 sec)
set incsearch                       " do incremental searching
set laststatus=2                    " always show the status line
set shortmess+=c                    " don't show match x of y in the status line
set noshowmode                      " don't show INSERT in the status line
set ignorecase
set smartcase                       " auto case sensitivity when searching
set hlsearch                        " do highlight searches, but with vim-cool
set novisualbell                    " shut the fuck up
set title
set titlestring=vim:\ %f\ %a%r%m
set hidden                          " allow hidden buffers with edits
set updatetime=250                  " short updates for gitgutter
set fillchars=diff:.                " deleted lines filler

if has("mouse")
    set mouse=a                     " for noobs
endif

" }}}
" Indentation {{{

set breakindent
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set autoindent                                     " automatic indent new lines
set cindent                                        " be smart about it: actually, use filetype
" don't muck up indenting with #
inoremap # X<BS>#
set wrap                                           " wrap lines so no h-scrolling required
set nojs                                           " don't J-join sentences with double spaces
set linebreak                                      " word boundaries 
set smarttab                                       " fuck tabs
set virtualedit=block                              " allow virtual edit in visual-block mode
set nofoldenable                                   " don't automatically close all folds initially
set foldmethod=syntax                              " how to determine folds
set conceallevel=0
" defaults
set ts=2 sw=2 sts=2 expandtab

" specifics
augroup FILETYPES
autocmd!
autocmd Filetype html       setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype liquid     setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype css        setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype scss       setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype less       setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype jst        setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype xml        setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype ruby,eruby setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype haskell    setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype c          setlocal ts=8 sw=8 sts=8 expandtab
autocmd Filetype cpp        setlocal ts=8 sw=8 sts=8 expandtab
autocmd Filetype objc       setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype python     setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype markdown   setlocal ts=2 sw=2 sts=2 expandtab fo-=c
autocmd Filetype pandoc     setlocal ts=4 sw=4 sts=4 expandtab fo-=c
autocmd Filetype scala      setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype go         setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype vim        setlocal ts=2 sw=2 sts=2 expandtab com+=":\""
autocmd Filetype clojure    setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype ada        setlocal ts=3 sw=3 sts=3 expandtab
autocmd Filetype makefile   setlocal ts=4 sw=4 sts=4 noexpandtab
augroup END

" }}}
" }}}
" Mappings {{{

" lead with , and use '\' for the original functionality
let mapleader = ","
let maplocalleader = "\\"

" Editing mappings {{{

" select all
noremap <Leader>a ggVG

" start replace s/// using current selection
vnoremap <leader><F2> "hy:%s/<C-r>h//gc<left><left><left>

" find using current selection
vnoremap <C-f> "hy/<C-r>h<cr>

" Substitute
nnoremap <leader>s :%s//g<left><left>
nnoremap <leader>S :%s/\C\v/gc<left><left>
vnoremap <leader>s :s//g<left><left>

" reflow paragraph with Q in normal and visual mode
" & approximately get back to where we were
nnoremap Q m`gqap``
vnoremap Q gq

" also for EOL, etc
" nnoremap $ g$
" nnoremap 0 g0
" nnoremap A g$a
" nnoremap I g0i

" make Y behave like other capitals
map Y y$

" Increment & decrement
" nnoremap + <C-a>
" nnoremap - <C-x>

" replace selection with " register
vmap gd "_dP

" visually select the block of characters you added last time you were in INSERT mode.
nnoremap gV `[v`]h

" repeated indent and outdent lines in selection
vnoremap < <gv
vnoremap > >gv

" Split lines
nnoremap gs i<cr><esc>

" retrospective semicolon
nnoremap <m-cr> m`A;<esc>``

" Use <C-s> and <M-s> to save
nnoremap <C-s> :w<cr>
nnoremap <M-s> :w<cr>

" Better command-line editing (:O emacs mode!)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" toggle spelling
nnoremap <leader>Sp :setlocal spell!<cr>

" Look up in online French dictionary
" nnoremap <leader>wr viw"hy:!open "http://wordreference.com/enfr/<c-r>h"<cr><cr>

" Look up in Mac dictionary
nnoremap <leader>K viw"hy:!open "dict://<c-r>h"<cr><cr>

" Strip all trailing whitespace in file {{{
function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map <leader>ws :call StripWhitespace ()<CR>

" toggle typewriter mode
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" }}}

" Find merge conflict markers
nnoremap <silent> <leader>Cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" copy default register to clipboard
noremap <leader>c :let @+=@"<cr>:echo "copied!"<cr>
noremap <leader>C :let @"=@+<cr>:echo "pasted!"<cr>

" toggle undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" }}}
" Navigation mappings {{{

" use NERDTree on ,d
" Plus more nerdtree goodies
" noremap <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
noremap <leader>d :NERDTreeToggle<CR>
noremap <leader>D :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeMinimalUI = 1

" FZF files
nnoremap <c-p> :FZF<cr>
" buffers
nnoremap <C-b> :Buffers<cr>

" next/prev buffer!
nnoremap <leader><Tab> :bn<cr>
nnoremap <leader><S-Tab> :bp<cr>
nnoremap <leader>t :tabnext<cr>
nnoremap <leader><s-t> :tabprev<cr>
" make this work with alacritty somehow
" nnoremap <C-tab> :tabnext<cr>
" nnoremap <C-S-tab> :tabprev<cr>

" quick delete buffer
nnoremap <leader>bd :Bdelete<CR>
nnoremap <leader>bD :Bdelete!<CR>

" exit a buffer or split
nnoremap <leader>q :close<CR>

" editing vim config
nnoremap <D-<>       :tabe ~/.vimrc<cr>
nnoremap <leader>Vs  :so $VIM_VIMRC<cr>
nnoremap <leader>Vc  :e $VIM_CONFIG<cr>
nnoremap <leader>Ve  :e $VIM_VIMRC<cr>
nnoremap <leader>Vn  :e $VIM_INIT<cr>
nnoremap <leader>Vp  :e $VIM_PLUG<cr>

" vim-grepper!
nmap gG <plug>(GrepperOperator)
xmap gG <plug>(GrepperOperator)
nnoremap <leader>g :Grepper -tool rg<cr>
nnoremap <leader>G :Grepper -tool rg -cword -noprompt<cr>
command! -nargs=* Rg :Grepper -tool rg
nnoremap <leader>L :let @/="\\<".expand("<cword>")."\\>"<cr>:lvim! /\C<c-r>//j %<cr>
nnoremap <leader>l :lw<cr>
let g:grepper = {
    \ 'tools': ['git', 'rg', 'grep'],
    \ 'open':  1,
    \ 'jump':  0,
    \ }

" }}}
" Leader Mappings {{{

" word count
nnoremap <leader>wc :!wordcount %<cr>

" errors
" nnoremap <leader>j :cnext<cr>zz
" nnoremap <leader>k :cprev<cr>zz

" the magic of this is, if b:neomake_* is empty, it runs the default one(s).
nnoremap <leader>m :exec "Neomake! ".get(b:, 'neomake_makers', "")<cr>
nnoremap <leader>M :exec "Neomake ".get(b:, 'neomake_file', "")<cr>

" }}}
" Window Mappings {{{

" Window yank/paste {{{
" https://stackoverflow.com/a/6094578
fu! PasteWindow(direction)
    if exists("g:yanked_buffer")
        if a:direction == 'edit'
            let temp_buffer = bufnr('%')
        endif

        exec a:direction . " +buffer" . g:yanked_buffer

        if a:direction == 'edit'
            let g:yanked_buffer = temp_buffer
        endif
    endif
endf

nmap <silent> <leader>wy :let g:yanked_buffer=bufnr('%') \| echo 'yanked buffer '.expand('%:t')<cr>
nmap <silent> <leader>wd :let g:yanked_buffer=bufnr('%')<cr>:close<cr>
nmap <silent> <leader>wr :call PasteWindow('edit')<cr>
nmap <silent> <leader>wP :call PasteWindow('aboveleft split')<cr>
nmap <silent> <leader>wp :call PasteWindow('split')<cr>
nmap <silent> <leader>wV :set nosplitright \| call PasteWindow('vsplit') \| set splitright<cr>
nmap <silent> <leader>wv :call PasteWindow('vsplit')<cr>
nmap <silent> <leader>wt :call PasteWindow('tabnew')<cr>
" }}}

" TODO find neovim
map <m-tab> :tabnext<cr>
map <m-c-y> :tabprev<cr>

" Easy split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Easy split navigation (with alt, for in terminal)
noremap <M-h> <C-w>h
noremap <M-j> <C-w>j
noremap <M-k> <C-w>k
noremap <M-l> <C-w>l

" Maps Alt-[h,j,k,l] to resizing a window split
" map <silent> <A-h> <C-w>5<
" map <silent> <A-l> <C-w>5>
" map <silent> <A-j> <C-W>5-
" map <silent> <A-k> <C-W>5+

noremap <silent> <A-S-k> :ObviousResizeUp 5<CR>
noremap <silent> <A-S-j> :ObviousResizeDown 5<CR>
noremap <silent> <A-S-h> :ObviousResizeLeft 5<CR>
noremap <silent> <A-S-l> :ObviousResizeRight 5<CR>

" Accordion style
map <silent> <C-A-h> <C-w>h<C-w><bar>
map <silent> <C-A-l> <C-w>l<C-w><bar>
map <silent> <C-A-j> <C-w>j<C-w>_
map <silent> <C-A-k> <C-w>k<C-w>_

" Maximize window
map <silent> <S-Space> <C-w><bar><C-w>_

set winminheight=0

" }}}
" Plugin Mapping {{{

call togglebg#map("<F4>")

let g:AutoPairsShortcutToggle = ''

" splitjoin
" nnoremap <silent> J :<C-u>call <SID>try('SplitjoinJoin',  'J')<CR>
" nnoremap <silent> gs :<C-u>call <SID>try('SplitjoinSplit', "i\015")<CR>
" function! s:try(cmd, default)
"   if exists(':' . a:cmd) && !v:count
"     let tick = b:changedtick
"     execute a:cmd
"     if tick == b:changedtick
"       execute join(['normal!', a:default])
"     endif
"   else
"     execute join(['normal! ', v:count, a:default], '')
"   endif
" endfunction

" dash.vim
nmap <expr> K <SID>doc("\<Plug>DashSearch")
nmap <expr> <Leader>k <SID>doc("\<Plug>DashGlobalSearch")
function! s:doc(cmd)
  if &keywordprg =~# '^man' && exists(':Dash')
    return a:cmd
  endif
  return 'K'
endfunction

" incsearch.vim
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

" }}}
" Vim Highlighting {{{

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <leader>hi :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <leader>hl :HLT<cr>

" }}}
" }}}
" Commands {{{

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Make :Q work just as well
command! Q q

" Vim as a file renaming device
command! MoveFiles silent execute "read !find . -maxdepth 1 -type f -not -path '*/\\.*' | cut -sd / -f 2-" | Mvall | execute "normal ggdd"
command! MoveAll silent execute "read !ls" | Mvall | execute "normal ggdd"
command! -bar Mvall silent execute "setf sh | %s/.*/mv -i '&' '&'/g"
command! -bar Shall execute "%!sh"

" }}}
" Spelling {{{

set spl=en_au

" Set language quickly
command! SpellFR setlocal spell spl=fr
command! SpellEN setlocal spell spl=en_au

" do an inline spell correction
nnoremap z! wgea<c-x><c-s>

" z[ corrects the last incorrect (red underline) word with 1z=.
" repeatable: z[... corrects the last four.

nmap z[ <Plug>CorrectLastSpellError
nmap <Plug>CorrectLastSpellError m`[S"syiw1z="zyiw``
\:silent! call repeat#set("\<Plug>CorrectLastSpellError", -1)<CR>
\:echo "<C-r>s -> <C-r>z"<CR>

nmap z{ <Plug>CorrectAnyLastSpellError
nmap <Plug>CorrectAnyLastSpellError m`[s"syiw1z="zyiw``
\:silent! call repeat#set("\<Plug>CorrectAnyLastSpellError", -1)<CR>
\:echo "<C-r>s -> <C-r>z"<CR>

nmap g[ <Plug>OkayLastSpellError
nmap <Plug>OkayLastSpellError m`[Szg``
\:silent! call repeat#set("\<Plug>OkayLastSpellError", -1)<CR>
\:echo ""<CR>

nmap [g <Plug>IgnoreLastSpellError
nmap <Plug>IgnoreLastSpellError m`[SzG``
\:silent! call repeat#set("\<Plug>IgnoreLastSpellError", -1)<CR>
\:echo ""<CR>

nmap z] <Plug>CorrectNextSpellError
nmap <Plug>CorrectNextSpellError m`]S"syiw1z="zyiw``
\:silent! call repeat#set("\<Plug>CorrectNextSpellError", -1)<CR>
\:echo "<C-r>s -> <C-r>z"<CR>

nmap z{ <Plug>CorrectAnyNextSpellError
nmap <Plug>CorrectAnyNextSpellError m`]s"syiw1z="zyiw``
\:silent! call repeat#set("\<Plug>CorrectAnyNextSpellError", -1)<CR>
\:echo "<C-r>s -> <C-r>z"<CR>

nmap g] <Plug>OkayNextSpellError
nmap <Plug>OkayNextSpellError m`]Szg``
\:silent! call repeat#set("\<Plug>OkayNextSpellError", -1)<CR>
\:echo ""<CR>

nmap ]g <Plug>IgnoreNextSpellError
nmap <Plug>IgnoreNextSpellError m`]SzG``
\:silent! call repeat#set("\<Plug>IgnoreNextSpellError", -1)<CR>
\:echo ""<CR>

" }}}
" Functions {{{

" blazing fast word count function, for statusline. {{{
" written by Cormac Relf, based on something else (can't remember)
function! WordCount()
    let currentmode = mode()
    if !exists("g:lastmode_wc")
        let g:lastmode_wc = currentmode
    endif

    " echo g:lastmode_wc." -> ".currentmode

    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if &modified || !exists("b:wordcount") || g:lastmode_wc =~? 'v' || currentmode =~? 'v' || (currentmode != g:lastmode_wc && g:lastmode_wc !~? 'i')
        " echo "ran ".g:lastmode_wc." -> ".currentmode
        if !exists("b:wordcount")
            let b:wordcount = 0
        endif
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg == "--No lines in buffer--"
            let b:wordcount = 0
        elseif v:statusmsg == "No matching autocommands"
            " Do nothing please. This works around UltiSnips weirdness
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, "Selected") < 0
                " echom "s:split_wc <<<<<<<<<<<<<"
                " echom join(s:split_wc, " ")
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount
    else
        let g:lastmode_wc = currentmode
        return b:wordcount
    endif
endfunction
" }}}

" }}}
" Filetypes {{{

" fatih/vim-go
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1

au BufEnter /tmp/crontab.* setl backupcopy=yes

au BufRead *.conf setf conf
au BufRead *.h setf c
au BufRead *.xaml setf xml
au BufRead *.vim,.*vimrc setlocal foldenable foldmethod=marker foldlevel=1

" allow highlighting $() in #!/bin/sh scripts
" as vim should do, per the POSIX standard
let g:is_posix = 1

runtime macros/matchit.vim

let g:golang_goroot = "/usr/local/go/"

" haskell
autocmd FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
autocmd FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>

let g:neomake_enabled_makers = []
let g:neomake_open_list = 2
let g:neomake_verbose = 2

" rust
au FileType rust let b:AutoPairs = { '(': ')', '{': '}', '[': ']', '"': '"' }
let g:neomake_rust_enabled_makers = ['cargo']
au FileType rust let b:neomake_makers = "cargo"

" Paredit {{{

command! Paredit execute Paredit()
function! Paredit()
    " allow > and < to fling braces
    " nunmap <buffer> <silent> <p
    " nunmap <buffer> <silent> <P
    " nunmap <buffer> <silent> >p
    " nunmap <buffer> <silent> >P
    nunmap <leader>Sp
    let g:paredit_shortmaps = 0
    let g:paredit_electric_return = 0
    setlocal ts=2 sw=2 sts=2 expandtab
endfunction
augroup PAREDIT
    autocmd!
    autocmd Filetype clojure execute Paredit()
    autocmd Filetype lisp    execute Paredit()
    autocmd Filetype cljs    execute Paredit()
augroup END

" }}}

" }}}
" Plugin Configuration {{{

let g:projectionist_heuristics = {
      \ "plugin/": { "*.vim": { "type": "vim" } }
      \ }

" javascript and JSX syntax
let g:jsx_ext_required = 0

" for pandoc speed
let g:pandoc#folding#level = 999
let g:pandoc#folding#fdc = 0
let g:pandoc#syntax#style#emphases = 1
let g:pandoc#syntax#style#underline_special = 0
let g:pandoc#syntax#conceal#use = 0
" let g:pandoc#formatting#mode=a " soft breaks; automatically set formatoptions
" let g:pantondoc_folding_fold_yaml = 1
" stop making esc slow!
" let g:pandoc#modules#disabled = ["bibliographies"]
let g:pandoc_use_embeds_in_codeblocks_for_langs = ["ruby", "haskell", "python", "typescript",
                                                  \ "go", "c", "scala", "clojure",
                                                  \ "rust", "javascript" ]

let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1

" Startify

" Solve problems with ctrlp and nerdtree splitting
autocmd User Startified setlocal buftype=
let g:startify_files_number = 5
let g:startify_custom_header = []
let g:startify_custom_header = startify#fortune#cowsay()

" Syntastic checking
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <leader>e :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" vim-sneak
" vim-sneak overrides vim-surround functionality, so:
xmap gs <Plug>VSurround
autocmd FileType pandoc   let b:surround_99 = "[//]: # (\r)"

" 2-character Sneak (default)
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
" visual-mode
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S

" explicit repeat (as opposed to automatic 'clever-s' repeat)
" nmap ; <Plug>SneakNext
" nmap <leader>; <Plug>SneakPrevious
" xmap ; <Plug>VSneakNext
" xmap <leader>; <Plug>VSneakPrevious

" " 1-character _inclusive_ Sneak (for enhanced 'f')
" nmap f <Plug>Sneak_f
" nmap F <Plug>Sneak_F
" " visual-mode
" xmap f <Plug>Sneak_f
" xmap F <Plug>Sneak_F
" " operator-pending-mode
" omap f <Plug>Sneak_f
" omap F <Plug>Sneak_F

" " 1-character _exclusive_ Sneak (for enhanced 't')
" nmap t <Plug>Sneak_t
" nmap T <Plug>Sneak_T
" " visual-mode
" xmap t <Plug>Sneak_t
" xmap T <Plug>Sneak_T
" " operator-pending-mode
" omap t <Plug>Sneak_t
" omap T <Plug>Sneak_T

" }}}
" Omni Completeion and YouCompleteMe {{{

set shortmess+=c " suppress annoying # matches found thing

" }}}
" Prose Formatting {{{

" c: auto-format comments,
" r: return inserts comment char
" o: o-command comment char
" q: gq on comments,
" l: don't break really long lines in insert mode
" n: wrap to first char in body of a numbered list entry
" j: delete comment chars when joining lines
" 1: wraps before 1-letter words,

set formatoptions=croqlnj1
" set formatlistpat=\\v^\\s*(\\d+|[a-z])[\\]:.)}]\\s*
" set formatlistpat=^\\s*[0-9a-z][\\]\\:.)}]\\s*
" set formatlistpat=\\v^\\s*(\\d+\|[a-z])[\\]:\\.\\)}]\\s*
" ( ( 2. | a. | ii. ) | *  )
set formatlistpat=\\v^\\s*((\\d+\|[a-z]\|)[\\]:\\.\\)}]\|\\*[\\t\ ])\\s*

" copyable text from hard-wrapped document
command! -range=% SoftWrap
            \ <line2>put _ |
            \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

function! Prose()
    let g:prose_hard_wrap = 0
    let b:wc_enabled = 1 " see airline wordcount segment

    if exists("ncm2#disable_for_buffer")
      call ncm2#disable_for_buffer()
    endif

    if !exists("b:toggled_ws_once") || b:toggled_ws_once == 0
        " silent exec :AirlineToggleWhitespace
    endif
    let b:toggled_ws_once = 1

    " speed up syntax highlighting
    syn sync minlines=45
    syn match myExCapitalWordsBQ +\<[A-Z]\+\>+ contains=@NoSpell containedin=pandocBlockQuote contained
    syn match myExCapitalWords +\<[A-Z]\+\>+ contains=@NoSpell containedin=pandocUListItem,pandocListItem
    hi link myExCapitalWordsBQ pandocBlockQuote
    setl cinwords=

    setl nocindent
    setl nosmartindent
    setl autoindent

    setl ts=4 sts=4 sw=4 expandtab

    setl noshowmatch

    " t: auto-format paragraphs of text
    " -l
    " -r, so enter doesn't insert bullets prematurely
    " -o, so essentially manually insert bullets.
    " setl formatoptions=tcroqlnj1
    " setl formatoptions=nj
    " same as above
    " setl formatlistpat=\\v^\\s*((\\d+\|[a-z]\|)[\\]:\\.\\)}]\|\\*[\\t\ ])\\s*
    " setl textwidth=0
    " markdown comments
    setl com=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,b:-

    " for cool lists using fo~=o/c
    " setlocal com+=:*
    " setlocal com+=:\-

    " Set undo points at important text operations.
    inoremap <buffer> . .<c-g>u
    inoremap <buffer> ! !<c-g>u
    inoremap <buffer> ? ?<c-g>u
    inoremap <buffer> , ,<c-g>u
    inoremap <buffer> ; ;<c-g>u
    inoremap <buffer> : :<c-g>u
    inoremap <buffer> <c-u> <c-g>u<c-u>
    inoremap <buffer> <c-w> <c-g>u<c-w>

    if g:prose_hard_wrap == 0
        " sane movement with wrap turned on
        nnoremap <buffer> j gj
        nnoremap <buffer> k gk
        nnoremap <buffer> 0 g0
        nnoremap <buffer> $ g$
        nnoremap A g$a
        nnoremap I g0i

        vnoremap <buffer> j gj
        vnoremap <buffer> k gk
        vnoremap <buffer> 0 g0
        vnoremap <buffer> $ g$

        nnoremap <buffer> <Down> gj
        nnoremap <buffer> <Up> gk
        vnoremap <buffer> <Down> gj
        vnoremap <buffer> <Up> gk
        inoremap <buffer> <Down> <C-o>gj
        inoremap <buffer> <Up> <C-o>gk
    endif

    " Use Mac OS X style accents, works for (at least) French.
    inoremap <M-e> <C-k>'
    inoremap <M-`> <C-k>`
    inoremap <M-i> <C-k>^
    inoremap <M-u> <C-k>:
    inoremap <M-c> <C-k>,c
    inoremap <M-S-c> <C-k>,C

    " for referencing
    iabbrev nbsp &#8203;
    inoremap <D-6> [^]<left>

    " for pandoc building using pbuild
    nnoremap <leader>pr :Dispatch! pbuild short %<cr>
    " nnoremap <leader>pR :Dispatch "!pbuild short %"<cr>

    " use convention of **bold** and _italic_
    let b:surround_105 = "_\r_" " i
    let b:surround_98 = "**\r**"  " b
    vmap <D-b> gs*gvgs*
    vmap <D-i> gs_
    nmap <D-b> ysiw*lysiw*
    nmap <D-i> ysiw_
    imap <D-i> __<left>
    imap <D-b> ****<left><left>

    " delete footnotes and -blockquotes-
    " let @f = ':%g/\v^(\[\^\d+\]|\> )/d'
    let @f = ':%g/\v^\[\^[a-zA-Z0-9\_\-]+\]/d:%s/\v\[\^[a-zA-Z0-9\-\_]{0,}\]//g'
    let @v = ':%v/\v^\[\^[a-zA-Z0-9\_\-]+\]/d:%s/\v\[\^[a-zA-Z0-9\-\_]{0,}\]//g'

    " increment footnotes in region
    vnoremap <leader>fa <Plug>IncrementFootnotes
    vnoremap <silent> <Plug>IncrementFootnotes :sno/[^\(\d\+\)]/\='[^'.(submatch(1)+1).']'/g<CR>
                \:silent! call repeat#set("gv\<Plug>IncrementFootnotes", -1)<CR>

    " decrement footnotes in region
    vnoremap <leader>fz <Plug>DecrementFootnotes
    vnoremap <silent> <Plug>DecrementFootnotes :sno/[^\(\d\+\)]/\='[^'.(submatch(1)-1).']'/g<CR>
                \:silent! call repeat#set("gv\<Plug>DecrementFootnotes", -1)<CR>

endfunction

augroup PROSE
    autocmd!
    autocmd Filetype markdown   execute Prose()
    autocmd Filetype none       execute Prose()
    autocmd Filetype pandoc     execute Prose()
augroup END

" reloading settings from Prose()
command! Prose execute Prose()

" Pandoc table mode, automatic aligning using Tabularize
autocmd Filetype pandoc inoremap <silent> <Bar> <Bar><Esc>:call AlignPandocTables()<CR>a
function! AlignPandocTables()
    let p = '^\s*|\s.*\s|\s*$'
    if  exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" }}}


