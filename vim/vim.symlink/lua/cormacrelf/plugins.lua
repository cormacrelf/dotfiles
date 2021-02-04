-- bootstrap
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

-- required if packer is opt
vim.cmd [[packadd packer.nvim]]

-- plugins!
require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use 'norcalli/nvim_utils'

  use '~/git/cormacrelf/vim-colors-github'
  use '~/git/cormacrelf/dark-notify'

  -- closing braces
  use 'cohama/lexima.vim'
  -- use 'rstacruz/vim-closer'

  use 'Chiel92/vim-autoformat'
  use 'rhysd/git-messenger.vim'
  use 'liuchengxu/vista.vim'
  use 'dkarter/bullets.vim'

  -- Collection of common configurations for the Nvim LSP client
  use 'neovim/nvim-lspconfig'
  -- Extensions to built-in LSP, for example, providing type inlay hints
  use 'tjdevries/lsp_extensions.nvim'
  -- Autocompletion framework for built-in LSP
  use 'nvim-lua/completion-nvim'
  -- Diagnostic navigation and settings for built-in LSP
  use 'nvim-lua/diagnostic-nvim'

  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'romgrk/nvim-treesitter-context'

  use 'tpope/vim-dispatch'
  use 'radenling/vim-dispatch-neovim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'Shougo/echodoc.vim'

  -- Language-specific
  use 'jparise/vim-graphql'
  use 'rhysd/vim-llvm'
  use 'tpope/vim-scriptease'
  use 'dag/vim-fish'
  use 'neovimhaskell/haskell-vim'
  use 'vim-ruby/vim-ruby'
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'dhruvasagar/vim-table-mode'
  use 'othree/html5.vim'
  -- use 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  use 'derekwyatt/vim-scala'
  -- use 'rust-lang/rust.vim'
  use 'cespare/vim-toml'
  use 'elixir-lang/vim-elixir'
  use { 'pangloss/vim-javascript', ft =  {'javascript', 'javascript.jsx'} }
  -- use 'othree/yajs.vim'
  use { 'leafgarland/typescript-vim', fs = { 'typescript' } }
  use { 'maxmellon/vim-jsx-pretty', fs = { 'javascript.jsx', 'typescript.tsx' } }
  -- use { 'HerringtonDarkholme/yats.vim', fs = { 'typescript' } }
  use { 'Quramy/vim-js-pretty-template', fs = { 'javascript', 'typescript' } }
  use 'hashivim/vim-terraform'
  use 'juliosueiras/vim-terraform-completion'
  use 'dpwright/vim-tup'
  use 'PProvost/vim-ps1' -- Powershell
  -- use 'https://framagit.org/tyreunom/coquille.git', {
  --   \ 'branch': 'master',
  --   \ 'do': ':UpdateRemotePlugins' }
  -- use 'fsharp/vim-fsharp', {
      --       \ 'for': 'fsharp',
      --       \ 'do':  'make fsautocomplete' }

  -- Clojure / Paredit
  use { 'guns/vim-clojure-static', ft = {'clojure'} }
  use { 'tpope/vim-classpath', ft = {'clojure'} }
  use { 'tpope/vim-fireplace', ft = {'clojure'} }
  use { 'guns/vim-sexp', ft = {'clojure'} }
  use { 'vim-scripts/paredit.vim', ft = {'clojure'} }
  -- use { 'tpope/vim-salve', ft = {'clojure'} }
  use 'kien/rainbow_parentheses.vim'
  -- use 'VimClojure'
  -- use 'tpope/vim-foreplay'

  -- Text Objects
  use 'kana/vim-textobj-user'
  use { 'kana/vim-textobj-indent', requires = {'kana/vim-textobj-user'} }
  use { 'tpope/vim-surround', requires = {'kana/vim-textobj-user'} }

  -- Navigation, behaviour
  -- use 'kien/ctrlp.vim'
  -- use 'tpope/vim-vinegar'
  use 'tpope/vim-projectionist'
  use 'cormacrelf/fuzzy-projectionist.vim'
  -- use 'vim-airline/vim-airline'
  use 'itchyny/lightline.vim'
  use 'mhinz/vim-grepper'
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'
  use 'tpope/vim-rhubarb'
  use 'airblade/vim-gitgutter'

  use { 'mbbill/undotree', cmd = 'UndotreeToggle' }
  use 'talek/obvious-resize'
  use 'christoomey/vim-tmux-navigator'
  use 'moll/vim-bbye' -- Bdelete
  use 'scrooloose/nerdtree'
  -- use 'jistr/vim-nerdtree-tabs'
  use 'osyo-manga/vim-over' -- :s preview
  use 'editorconfig/editorconfig-vim'
  use 'romainl/vim-cool' -- basically incsearch highlighting
  -- use 'haya14busa/incsearch.vim'
  -- use 'kana/vim-tabpagecd'
  -- use 'terryma/vim-multiple-cursors'

  -- Motion, commands
  use 'godlygeek/tabular'
  use 'tommcdo/vim-lion'           -- glip= gLii,
  -- use 'maxbrunsfeld/vim-yankstack' " disabled because https://github.com/vim-pandoc/vim-pandoc/issues/245
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use 'vim-scripts/matchit.zip'
  -- use 'justinmk/vim-sneak' " s<char><char>
  -- use 'AndrewRadev/splitjoin.vim'
  -- use 'tpope/vim-commentary'
  -- use 'Lokaltog/vim-easymotion'
  -- use 'tpope/vim-ragtag'
  -- use 'yuttie/comfortable-motion.vim'

  -- Colours & Appearance
  -- use 'neg-serg/neg'
  -- use 'xolox/vim-misc'
  -- use 'xolox/vim-colorscheme-switcher'
  -- use 'arcticicestudio/nord-vim'
  -- use 'whatyouhide/vim-gotham'
  -- use 'ewilazarus/preto'
  -- use 'romainl/Apprentice'
  -- use 'morhetz/gruvbox'
  -- use 'dracula/vim'
  -- use 'vim-scripts/chlordane.vim'
  -- use 'malcolmbaig/vim-two-firewatch' " white brace matching, but even in light mode
  -- use 'shofel/vim-two-firewatch'
  -- use 'w0ng/vim-hybrid'
  -- use 'sjl/badwolf'
  -- use 'chriskempson/base16-vim'
  -- use 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
  -- use 'jszakmeister/vim-togglecursor'

  -- Other
  use 'ciaranm/detectindent'
  use 'junegunn/vader.vim'
  use 'tpope/vim-eunuch' -- :Move, :Mkdir, :Rename
end)
