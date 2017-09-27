" Basics {{{

set nocompatible

if $VIM_HOME == ''
    if has('win32') || has ('win64')
        let $VIM_HOME = $HOME."/AppData/Local/nvim"
    else
        let $VIM_HOME = $HOME."/.vim"
    endif
endif

let $VIM_INIT = $VIM_HOME."/init.vim"
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

filetype off
call plug#begin($VIM_HOME.'/plugged')
    let $VIM_PLUG = $VIM_HOME."/plug.vim"
    so $VIM_PLUG
call plug#end()

filetype plugin indent on
syntax on

" do this first so any yank mappings still cache
call yankstack#setup()

set thesaurus+=$HOME/lib/mthesaur.txt

if filereadable($VIM_HOME."/private.vim")
    so ~/.vim/private.vim
endif

set modeline
set modelines=3
set noswapfile

if !has('nvim')
  set viminfo+=n$VIM_HOME/viminfo
else
  " Do nothing here to use the neovim default
  " or do soemething like:
  " set viminfo+=n~/.shada
endif

" }}}
" Autocommands {{{

autocmd BufEnter /tmp/crontab.* setl backupcopy=yes

" }}}
" Text Formatting {{{

set background=dark
" override the colorscheme to 24-bit in nvim/gvim's respective configs.
" both source this first, so it makes sense that way.
if !(has("nvim") || has("gui_running"))
    set term=screen-256color
    colorscheme gotham256
    let g:airline_theme='gotham'
else
    " set updatetime=250
endif

call togglebg#map("<F4>")

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

" }}}
" Indentation {{{

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
autocmd Filetype coffee     setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype haskell    setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype c          setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype objc       setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype python     setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype markdown   setlocal ts=2 sw=2 sts=2 expandtab fo-=c
autocmd Filetype pandoc     setlocal ts=4 sw=4 sts=4 expandtab fo-=c
autocmd Filetype scala      setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype go         setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype vim        setlocal ts=4 sw=4 sts=4 expandtab com+=":\""
autocmd Filetype clojure    setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype ada        setlocal ts=3 sw=3 sts=3 expandtab
autocmd Filetype makefile   setlocal ts=4 sw=4 sts=4 noexpandtab
augroup END

" }}}
" Leader Mappings {{{

" lead with , and use '\' for the original functionality
let mapleader = ","
let maplocalleader = "\\"
nnoremap <M-;> ,
" nnoremap ; ;

" Shortcut to rapidly toggle `set list`
" noremap <leader>l :set list!<CR>

" use NERDTree on ,d
" Plus more nerdtree goodies
" noremap <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
noremap <leader>d :NERDTreeTabsToggle<CR>
noremap <leader>D :NERDTreeFocusToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:NERDTreeMinimalUI = 1

" copy default register to clipboard
noremap <leader>c :let @+=@"<cr>:echo "copied!"<cr>
noremap <leader>C :let @"=@+<cr>:echo "pasted!"<cr>

" next/prev buffer!
nnoremap <leader><Tab> :bn<cr>
nnoremap <leader><S-Tab> :bp<cr>
nnoremap <leader>t :tabnext<cr>
nnoremap <leader><s-t> :tabprev<cr>

" toggle spelling
nnoremap <leader>Sp :setlocal spell!<cr>

" quick delete buffer
nnoremap <leader>bd :Bdelete<CR>
nnoremap <leader>bD :Bdelete!<CR>

" exit a buffer or split
nnoremap <leader>q :close<CR>

" Find merge conflict markers
nnoremap <silent> <leader>Cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" select all
noremap <Leader>a ggVG

" editing vim config
nnoremap <D-<>       :tabe ~/.vimrc<cr>
nnoremap <leader>Vs  :so   ~/.vimrc<cr>
nnoremap <leader>Ve  :e ~/.vimrc<cr>
nnoremap <leader>Vn  :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>Vp  :e $VIM_PLUG<cr>

" toggle typewriter mode
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Look up in online French dictionary
" nnoremap <leader>wr viw"hy:!open "http://wordreference.com/enfr/<c-r>h"<cr><cr>

" Look up in Mac dictionary
nnoremap <leader>K viw"hy:!open "dict://<c-r>h"<cr><cr>

" toggle undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" vim-grepper!
nmap gG <plug>(GrepperOperator)
xmap gG <plug>(GrepperOperator)
nnoremap <leader>g :Grepper -tool rg<cr>
nnoremap <leader>G :Grepper -tool rg -cword -noprompt<cr>
command! -nargs=* Rg :Grepper -tool rg -noswitch<cr>
nnoremap <leader>L :let @/="\\<".expand("<cword>")."\\>"<cr>:lvim! /\C<c-r>//j %<cr>
nnoremap <leader>l :lw<cr>

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

" Better command-line editing (:O emacs mode!)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

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

" All windows in equal space
map <silent> <S-Space> <C-w>=

" Maximize window
map <silent> <S-Space> <C-w><bar><C-w>_

set winminheight=0

map <m-tab> :tabnext<cr>
map <m-c-y> :tabprev<cr>

" https://stackoverflow.com/a/6094578
fu! PasteWindow(direction) "{{{
    if exists("g:yanked_buffer")
        if a:direction == 'edit'
            let temp_buffer = bufnr('%')
        endif

        exec a:direction . " +buffer" . g:yanked_buffer

        if a:direction == 'edit'
            let g:yanked_buffer = temp_buffer
        endif
    endif
endf "}}}

"yank/paste buffers
nmap <silent> <leader>wy :let g:yanked_buffer=bufnr('%') \| echo 'yanked buffer '.expand('%:t')<cr>
nmap <silent> <leader>wd :let g:yanked_buffer=bufnr('%')<cr>:close<cr>
nmap <silent> <leader>wr :call PasteWindow('edit')<cr>
nmap <silent> <leader>wP :call PasteWindow('top split')<cr>
nmap <silent> <leader>wp :call PasteWindow('split')<cr>
nmap <silent> <leader>wV :set nosplitright \| call PasteWindow('vsplit') \| set splitright<cr>
nmap <silent> <leader>wv :call PasteWindow('vsplit')<cr>
nmap <silent> <leader>wt :call PasteWindow('tabnew')<cr>

" }}}
" Remapping {{{

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

" wheel
let g:wheel#map#up   = '<D-k>'
let g:wheel#map#down = '<D-j>'
let g:wheel#map#mouse = 0

" also for EOL, etc
nnoremap $ g$
nnoremap 0 g0
nnoremap A g$a
nnoremap I g0i

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

" Open CtrlP buffer explorer with C-b
nnoremap <C-b> :CtrlPBuffer<cr>

" Open MRU files
nnoremap <C-M-P> :CtrlPMRUFiles<cr>

" }}}
" Commands {{{

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Make :Q work just as well
command! Q q

" Set language quickly
command! FR setlocal spl=fr
command! EN setlocal spl=en_au

" Vim as a file renaming device
command! MoveFiles silent execute "read !find . -maxdepth 1 -type f -not -path '*/\\.*' | cut -sd / -f 2-" | Mvall | execute "normal ggdd"
command! MoveAll silent execute "read !ls" | Mvall | execute "normal ggdd"
command! -bar Mvall silent execute "setf sh | %s/.*/mv -i '&' '&'/g"
command! -bar Shall execute "%!sh"

" }}}
" Spelling {{{

set spl=en_au

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

" nnoremap <F2> :call CycleLang()<CR>
fun! CycleLang()
    let langs = ['', 'en_au', 'fr']

    let i = index(langs, &spl)
    let j = (i+1)%len(langs)
    let &l:spl = langs[j] " letlocal

    if empty(&spl)
        echo "nospell"
        setlocal nospell
    else
        echo "spelling: ".&spl
        setlocal spell
    endif
endfun

" }}}
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
set noshowmode                      " don't show INSERT in the status line
set ignorecase
set smartcase                       " auto case sensitivity when searching
set nohlsearch                      " don't highlight searches
set novisualbell                      " shut the fuck up
set title
set titlestring=vim:\ %f\ %a%r%m
set hidden                          " allow hidden buffers with edits
set updatetime=250                  " short updates for gitgutter

if has("mouse")
    set mouse=a                     " for noobs
endif

" }}}
" Functions {{{

" Strip all trailing whitespace in file
function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map <leader>ws :call StripWhitespace ()<CR>
map <leader>wS :AirlineToggleWhitespace<CR>

" blazing fast word count function, for statusline.
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
" Filetypes {{{

" allow highlighting $() in #!/bin/sh scripts
" as vim should do, per the POSIX standard
let g:is_posix = 1

runtime macros/matchit.vim

let g:golang_goroot = "/usr/local/go/"
" autocmd FileType go compiler golang

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

function! Listacular()
    " <c-.> marks as 'done', sends to start of done section
    nnoremap <buffer> <C-.> m`dd/^x<cr>P0rx``
    " <c-,> moves to top of list and marks as not done just in case
    nnoremap <buffer> <C-,> m`ddggP0r-``
    setl textwidth=0
endfunction

autocmd! BufNewFile,BufRead $HOME/Dropbox/Listacular/* execute Listacular()

" }}}
" Plugin Mapping {{{

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
" Plugin Configuration {{{

" javascript and JSX syntax
let g:jsx_ext_required = 0

" for pandoc speed
let g:pandoc#syntax#style#emphases = 1
let g:pandoc#syntax#style#underline_special = 0
let g:pandoc#syntax#conceal#use = 0
" let g:pantondoc_folding_fold_yaml = 1
" stop making esc slow!
let g:pandoc#modules#disabled = ["bibliographies"]
let g:pandoc_use_embeds_in_codeblocks_for_langs = ["ruby", "haskell", "python",
                                                  \ "go", "c", "scala", "clojure",
                                                  \ "rust", "javascript" ]

let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1

" Startify

" Solve problems with ctrlp and nerdtree splitting
autocmd User Startified setlocal buftype=
let g:startify_bookmarks = [
            \ '~/.vimrc',
            \ '~/.vim/vundlerc.vim',
            \ '~/.gvimrc',
            \ '~/Dropbox/Writing/nv/Movies.txt',
            \ '/tmp/750words'
\ ]
let g:startify_files_number = 5
let g:startify_custom_header = [
\"                                     _ ___ ",
\"   ___ ___ ___ _____ ___ ___ ___ ___| |  _|",
\"  |  _| . |  _|     | .'|  _|  _| -_| |  _|",
\"  |___|___|_| |_|_|_|__,|___|_| |___|_|_|  ",
\"                                           "]

" Airline
let b:toggled_ws_once = 1
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
" let g:airline_section_y = '%{WordCount()}w'
let g:airline#extensions#whitespace#enabled = 0
call airline#parts#define_function('wordcount', 'WordCount')
call airline#parts#define_condition('wordcount', 'exists("b:wc_enabled") && b:wc_enabled == 1')
let g:airline_section_y = airline#section#create(['ffenc', ' ', 'wordcount'])


" CtrlP
let g:ctrlp_extensions = ['tag']
" Use Silver Searcher for finding files
" It uses .gitignore
" But don't let it index $HOME!
" let g:ctrlp_user_command = ['.git/',    'cd %s && git ls-files -co --exclude-standard',
"                           \ 'cd %s && find . -type f']
                 " 2: ['.git/', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_user_command = {
    \ 'types': { 1: ['Desktop/', 'find %s -type f -maxdepth 2'],
    \            2: ['.git/', 'ag %s -l --nocolor -g ""']
    \ },
    \ 'fallback': 'ag %s -l --nocolor -g ""'
\ }

" vim-grepper
let g:grepper = {
    \ 'tools': ['rg', 'git', 'grep'],
    \ 'open':  1,
    \ 'jump':  0,
    \ }

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Syntastic checking
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <leader>e :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" vim-surround

" vim-sneak overrides vim-surround functionality, so:
xmap gs <Plug>VSurround
autocmd FileType pandoc   let b:surround_99 = "[//]: # (\r)"
" vim-sneak

" 2-character Sneak (default)
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
" visual-mode
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S

" vim-sneak

" explicit repeat (as opposed to automatic 'clever-s' repeat)
" nmap ; <Plug>SneakNext
" nmap <leader>; <Plug>SneakPrevious
" xmap ; <Plug>VSneakNext
" xmap <leader>; <Plug>VSneakPrevious

" 1-character _inclusive_ Sneak (for enhanced 'f')
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
" visual-mode
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
" operator-pending-mode
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" 1-character _exclusive_ Sneak (for enhanced 't')
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
" visual-mode
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
" operator-pending-mode
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" }}}
" Omni Completeion and YouCompleteMe {{{

set shortmess+=c " suppress annoying # matches found thing
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:deoplete#enable_at_startup = 1

" nnoremap <leader>jd :YcmCompleter GoTo<cr>

" let g:ycm_filetype_whitelist = { 'javascript': 1 }

" this uses the default toolchain
" let g:ycm_rust_src_path = $RUST_SRC_PATH
" but this uses the active toolchain
" let g:ycm_rust_src_path = system("echo -n $(dirname $(dirname $(rustup which rustc)))") . "/lib/rustlib/src/rust/src"

" Snippets / UltiSnips
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-ultisnips"]
" let g:UltiSnipsSnippetsDir = $HOME.'/.vim/my-ultisnips'
" let g:UltiSnipsExpandTrigger="<C-CR>"
" let g:UltiSnipsJumpForwardTrigger="<C-tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" function! g:UltiSnips_Complete()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res == 0
"         if pumvisible()
"             return "\<C-n>"
"         else
"             call UltiSnips#JumpForwards()
"             if g:ulti_jump_forwards_res == 0
"                return "\<TAB>"
"             endif
"         endif
"     endif
"     return ""
" endfunction
"
" fun! Ultisnips_Remap()
"     exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" endf

" au InsertEnter * call Ultisnips_Remap()
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

    let b:wc_enabled = 1

    if !exists("b:pbuild_args")
        let b:pbuild_args = ""
    endif

    if !exists("b:toggled_ws_once") || b:toggled_ws_once == 0
        " silent exec :AirlineToggleWhitespace
    endif
    let b:toggled_ws_once = 1

    " speed up syntax highlighting
    syn  sync minlines=45
    syn  match myExCapitalWords +\<[A-Z]\+\>+ contains=@NoSpell
    setl smartindent autoindent
    setl cinwords=

    setl nocindent
    setl nosmartindent
    setl autoindent

    set noshowmatch

    " t: auto-format paragraphs of text
    " -l
    " -r, so enter doesn't insert bullets prematurely
    " -o, so essentially manually insert bullets.
    setl formatoptions=tcroqlnj1
    " same as above
    " setl formatlistpat=\\v^\\s*((\\d+\|[a-z]\|)[\\]:\\.\\)}]\|\\*[\\t\ ])\\s*
    setl textwidth=80
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

    " sane movement with wrap turned on
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
    vnoremap <buffer> j gj
    vnoremap <buffer> k gk
    nnoremap <buffer> <Down> gj
    nnoremap <buffer> <Up> gk
    vnoremap <buffer> <Down> gj
    vnoremap <buffer> <Up> gk
    inoremap <buffer> <Down> <C-o>gj
    inoremap <buffer> <Up> <C-o>gk

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
    let b:surround_73 = "*\r*"  " I
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
" Miscellaneous {{{

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}
