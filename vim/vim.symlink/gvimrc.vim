" set guifont=Menlo\ for\ Powerline:h14
" set guifont=Skyhook\ Mono:h16
" set guifont=Ubuntu\ Mono:h15
" set guifont=M+\ 1m\ regular:h14
" set guifont=DejaVu\ Sans\ Mono:h14
" set guifont=Monaco:h13
" set guifont=Envy\ Code\ R\ for\ Powerline:h13
" set guifont=Inconsolata-dz:h14
" set guifont=Pragmata\ TT:h14
" set guifont=Dark\ Courier:h16
" set guifont=Cousine:h14
" set guifont=Hack:h13
" set linespace=1
set guifont=Hack:h11
set linespace=3
" set gfn=Source\ Code\ Pro\ for\ Powerline:h13
" set linespace=1

set antialias

colorscheme two-firewatch
let g:airline_theme = "twofirewatch"

set lines=58
set columns=1000
set guioptions=egmt
set listchars=tab:▸\ ,eol:¬,precedes:«,extends:»
set ttimeoutlen=10
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

if has('gui_macvim')
  nnoremap <silent> <SwipeLeft> :macaction _cycleWindowsBackwards:<CR>
  nnoremap <silent> <SwipeRight> :macaction _cycleWindows:<CR>
  set macmeta
  macmenu &Tools.Make key=<nop>
  set fuoptions=background:Normal    " macvim specific setting for 
				                     " editor's background colour
endif

" automatically reload vimrc when it's saved
au! BufWritePost .gvimrc so ~/.gvimrc

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
nmap <c-tab> :tabnext<cr>
imap <c-tab> <c-o>:tabnext<cr>
vmap <c-tab> <c-o>:tabnext<cr>
nmap <c-s-tab> :tabprevious<cr>
imap <c-s-tab> <c-o>:tabprevious<cr>
vmap <c-s-tab> <c-o>:tabprevious<cr>

" Cmd-# switches to tab
nmap <d-1> 1gt
nmap <d-2> 2gt
nmap <d-3> 3gt
nmap <d-4> 4gt
nmap <d-5> 5gt
nmap <d-6> 6gt
nmap <d-7> 7gt
nmap <d-8> 8gt
nmap <d-9> 9gt
