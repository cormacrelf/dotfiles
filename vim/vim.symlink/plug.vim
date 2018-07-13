" Completion, Snippets and Insert Mode
Plug 'jiangmiao/auto-pairs'
" Plug 'tpope/vim-endwise'
Plug 'mattn/emmet-vim'
"
" Only in Neovim

Plug 'Yggdroot/indentLine'

" snipmate dependencies
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-snipmate'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    " Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/echodoc.vim'
    Plug 'neomake/neomake'
    Plug 'radenling/vim-dispatch-neovim'
endif

Plug 'tpope/vim-dispatch'

" Language-specific
Plug 'dag/vim-fish'
Plug 'kana/vim-filetype-haskell'
Plug 'bitc/vim-hdevtools'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'othree/html5.vim'
" Plug 'fatih/vim-go'
Plug 'derekwyatt/vim-scala'
Plug 'jeaye/color_coded', { 'for': ['c'] }
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/yajs.vim'
Plug 'fsharp/vim-fsharp', {
      \ 'for': 'fsharp',
      \ 'do':  'make fsautocomplete',
      \}
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
" Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript'] }
Plug 'Quramy/vim-js-pretty-template', {'for': ['javascript', 'typescript']}
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'PProvost/vim-ps1' " Powershell


" Clojure / Paredit
Plug 'guns/vim-clojure-static', { 'for': ['clojure'] }
Plug 'tpope/vim-classpath', { 'for': ['clojure'] }
Plug 'tpope/vim-fireplace', { 'for': ['clojure'] }
Plug 'guns/vim-sexp', { 'for': ['clojure'] }
" Plug 'vim-scripts/paredit.vim', { 'for': ['clojure'] }
" Plug 'VimClojure'
" Plug 'tpope/vim-foreplay'


" Text Objects
Plug 'vim-scripts/argtextobj.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-function'          " af if
Plug 'beloglazov/vim-textobj-punctuation' " au iu
Plug 'wellle/targets.vim'
Plug 'terryma/vim-expand-region'        " + or _


" Navigation, behaviour
" Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/tasklist.vim', { 'on': 'TaskList' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'talek/obvious-resize'
Plug 'moll/vim-bbye' " Bdelete
Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'reedes/vim-wheel' " d-j, d-k
Plug 'osyo-manga/vim-over' " :s preview
Plug 'chrisbra/NrrwRgn' " :NR, :wq
Plug 'editorconfig/editorconfig-vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'haya14busa/incsearch.vim'
" Plug 'jeaye/color_coded'
" Plug 'kana/vim-tabpagecd'
" Plug 'terryma/vim-multiple-cursors'


" Motion, commands
Plug 'godlygeek/tabular'
Plug 'tommcdo/vim-lion'           " glip= gLii,
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/matchit.zip'
Plug 'justinmk/vim-sneak' " s<char><char>
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'tpope/vim-commentary'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-ragtag'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed'
    !./install.py --all
  endif
endfunction

" Colours and Appearance
Plug 'xolox/vim-misc' | Plug 'xolox/vim-colorscheme-switcher'
Plug 'whatyouhide/vim-gotham'
Plug 'ewilazarus/preto'
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'vim-scripts/chlordane.vim'
Plug 'rakr/vim-two-firewatch'
Plug 'w0ng/vim-hybrid'
Plug 'sjl/badwolf'
Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-togglebg'
" Plug 'jszakmeister/vim-togglecursor'


" External
" Plug 'Shougo/vimproc'
" Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-eunuch' " :Move, :Mkdir, :Rename


" Other
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
Plug 'ciaranm/detectindent'
" Plug 'vim-scripts/loremipsum'

