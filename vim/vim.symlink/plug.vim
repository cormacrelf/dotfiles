" Completion, Snippets and Insert Mode
" Plug 'jiangmiao/auto-pairs'
" Plug 'rstacruz/vim-closer'
" Plug 'tpope/vim-endwise'
Plug 'cohama/lexima.vim'
Plug 'reedes/vim-wordy'
Plug 'neomake/neomake'
Plug 'Chiel92/vim-autoformat'
Plug 'rhysd/git-messenger.vim'
Plug 'rbong/vim-flog'
Plug 'liuchengxu/vista.vim'
Plug 'norcalli/nvim_utils'
" straight up doesn't work at the moment, but could be good
" Plug 'weilbith/nvim-lsp-smag'

" " barbar
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'romgrk/lib.kom'
" Plug 'romgrk/barbar.nvim'

" Bullets.vim {{{

" i think we have to set this before loading the plugin, because these are
" read as soon as the file is loaded.
"
" don't clash with git-messenger, and any other plugins that don't have a
" filetype when they first open a buffer
let g:bullets_enable_in_empty_buffers = 0
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'pandoc',
    \ 'text',
    \ 'gitcommit'
    \]

Plug 'dkarter/bullets.vim'

" }}}

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

if version < 800
  Plug 'ConradIrwin/vim-bracketed-paste' " vim8/neovim have this now
endif

" Plug 'Yggdroot/indentLine'

" Writing mode
Plug 'junegunn/goyo.vim'

" snippets
if g:cormacrelf.snippets
  Plug 'SirVer/ultisnips'
  " Plug 'honza/vim-snippets'
endif

" Plug 'tomtom/tlib_vim'
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'garbas/vim-snipmate'
" Plug 'mattn/emmet-vim'

if has('nvim')
  if g:cormacrelf.coc
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
  elseif g:cormacrelf.nvim_lsp
    " Collection of common configurations for the Nvim LSP client
    Plug 'neovim/nvim-lspconfig'

    " Extensions to built-in LSP, for example, providing type inlay hints
    Plug 'tjdevries/lsp_extensions.nvim'

    " Autocompletion framework for built-in LSP
    Plug 'nvim-lua/completion-nvim'

    " Diagnostic navigation and settings for built-in LSP
    Plug 'nvim-lua/diagnostic-nvim'
  endif

  if g:cormacrelf.treesitter
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'romgrk/nvim-treesitter-context'
  end

endif

Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Shougo/echodoc.vim'

" Language-specific
Plug 'jparise/vim-graphql'
Plug 'rhysd/vim-llvm'
Plug 'tpope/vim-scriptease'
Plug 'dag/vim-fish'
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'dhruvasagar/vim-table-mode'
Plug 'othree/html5.vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'derekwyatt/vim-scala'
" Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/yajs.vim'
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript.jsx', 'typescript.tsx'] }
" Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript'] }
Plug 'Quramy/vim-js-pretty-template', {'for': ['javascript', 'typescript']}
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'dpwright/vim-tup'
Plug 'PProvost/vim-ps1' " Powershell
Plug 'https://framagit.org/tyreunom/coquille.git', {
      \ 'branch': 'master',
      \ 'do': ':UpdateRemotePlugins' }
" Plug 'fsharp/vim-fsharp', {
"       \ 'for': 'fsharp',
"       \ 'do':  'make fsautocomplete' }

" Clojure / Paredit
Plug 'guns/vim-clojure-static', { 'for': ['clojure'] }
Plug 'tpope/vim-classpath', { 'for': ['clojure'] }
Plug 'tpope/vim-fireplace', { 'for': ['clojure'] }
Plug 'guns/vim-sexp', { 'for': ['clojure'] }
Plug 'vim-scripts/paredit.vim', { 'for': ['clojure'] }
" Plug 'tpope/vim-salve', { 'for': ['clojure'] }
Plug 'kien/rainbow_parentheses.vim'
" Plug 'VimClojure'
" Plug 'tpope/vim-foreplay'


" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'tpope/vim-surround'
" Plug 'wellle/targets.vim'

" obsoleted by tree-sitter text objects
" Plug 'kana/vim-textobj-syntax' " viy
" Plug 'kana/vim-textobj-function'          " af if
" Plug 'vim-scripts/argtextobj.vim'
" Plug 'beloglazov/vim-textobj-punctuation' " au iu
" Plug 'terryma/vim-expand-region'          " + or _
" Plug 'LandonSchropp/vim-stamp'            " paste with S<textobj>, without affecting \" register

" Navigation, behaviour
" Plug 'kien/ctrlp.vim'
" Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'cormacrelf/fuzzy-projectionist.vim'
if g:cormacrelf.lightline
  " Plug 'vim-airline/vim-airline'
  Plug 'itchyny/lightline.vim'
endif
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter'
" if has('nvim') || has('patch-8.0.902')
"   Plug 'mhinz/vim-signify'
" else
"   Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
" endif

" Plug 'mhinz/vim-startify'
" Plug 'vim-scripts/tasklist.vim', { 'on': 'TaskList' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'talek/obvious-resize'
Plug 'christoomey/vim-tmux-navigator'
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
" Plug 'justinmk/vim-sneak' " s<char><char>
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'tpope/vim-commentary'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-ragtag'
" Plug 'yuttie/comfortable-motion.vim'

" Colours and Appearance
Plug 'cormacrelf/vim-colors-github'
Plug 'cormacrelf/dark-notify'

" External
" Plug 'Shougo/vimproc'
" Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-eunuch' " :Move, :Mkdir, :Rename


" Other
Plug 'ciaranm/detectindent'
Plug 'junegunn/vader.vim'
