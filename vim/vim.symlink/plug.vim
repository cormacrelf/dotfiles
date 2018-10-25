" Completion, Snippets and Insert Mode
" Plug 'jiangmiao/auto-pairs'
" Plug 'rstacruz/vim-closer'
" Plug 'tpope/vim-endwise'
Plug 'cohama/lexima.vim'
Plug 'mattn/emmet-vim'

" Plug 'Yggdroot/indentLine'

" Writing mode
Plug 'junegunn/goyo.vim'

" snippets
if g:cormacrelf.snippets
  Plug 'tomtom/tlib_vim'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'SirVer/ultisnips'
  " Plug 'garbas/vim-snipmate'
  " Plug 'honza/vim-snippets'
endif

if has('nvim')
  if g:cormacrelf.LanguageClient
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  endif
endif
if g:cormacrelf.ncm2
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/nvim-yarp'
  Plug 'ncm2/ncm2'
  Plug 'ncm2/ncm2-path'
  if g:cormacrelf.snippets
    Plug 'ncm2/ncm2-ultisnips'
  endif
endif

Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Shougo/echodoc.vim'

" Language-specific
Plug 'dag/vim-fish'
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'othree/html5.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'derekwyatt/vim-scala'
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
Plug 'https://framagit.org/tyreunom/coquille', { 'branch': 'pathogen-bundle', 'do': ':UpdateRemotePlugins' }

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
" Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'cormacrelf/fuzzy-projectionist.vim'
" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify' " replace gitgutter
Plug 'mhinz/vim-startify'
" Plug 'vim-scripts/tasklist.vim', { 'on': 'TaskList' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'talek/obvious-resize'
Plug 'moll/vim-bbye' " Bdelete
Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
Plug 'osyo-manga/vim-over' " :s preview
Plug 'editorconfig/editorconfig-vim'
Plug 'romainl/vim-cool' " basically incsearch highlighting
" Plug 'haya14busa/incsearch.vim'
" Plug 'kana/vim-tabpagecd'
" Plug 'terryma/vim-multiple-cursors'


" Motion, commands
Plug 'godlygeek/tabular'
Plug 'tommcdo/vim-lion'           " glip= gLii,
" Plug 'maxbrunsfeld/vim-yankstack' " disabled because https://github.com/vim-pandoc/vim-pandoc/issues/245
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/matchit.zip'
Plug 'justinmk/vim-sneak' " s<char><char>
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'tpope/vim-commentary'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-ragtag'

" Colours and Appearance
Plug 'xolox/vim-misc' | Plug 'xolox/vim-colorscheme-switcher'
Plug 'whatyouhide/vim-gotham'
Plug 'ewilazarus/preto'
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'vim-scripts/chlordane.vim'
" Plug 'malcolmbaig/vim-two-firewatch' " white brace matching, but even in light mode
Plug 'shofel/vim-two-firewatch'
Plug 'w0ng/vim-hybrid'
Plug 'sjl/badwolf'
Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-togglebg'
Plug 'cormacrelf/vim-colors-github'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plug 'gerw/vim-HiLinkTrace'
" Plug 'jszakmeister/vim-togglecursor'


" External
" Plug 'Shougo/vimproc'
" Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-eunuch' " :Move, :Mkdir, :Rename


" Other
Plug 'ciaranm/detectindent'
Plug 'junegunn/vader.vim'
