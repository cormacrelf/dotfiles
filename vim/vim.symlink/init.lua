local api = vim.api

-- you need this before rtp+=ing any themes, otherwise they configure
-- themselves with 256 colors, or maybe Airline does
api.nvim_set_option("termguicolors", true)

-- load the old configuration
-- the neovim one is almost unnecessary, except the pumvisible stuff
api.nvim_command("source $HOME/.config/nvim/legacy-init.vim")

-- load packer.nvim plugins
-- for whatever reason you cannot load a file directly as `~/.config/nvim/lua/XXXXX.lua`, I guess
-- it needs some kind of namespace? IDK.
require 'cormacrelf.plugins'

require 'nvim_utils'

function lua_keybind(mode, keys, functioncall)
  api.nvim_set_keymap(mode, keys, '<cmd>lua '.. functioncall ..'<cr>', { silent = true, noremap = true })
end
function vim_keybind(mode, keys, functioncall)
  api.nvim_set_keymap(mode, keys, '<cmd>'.. functioncall ..'<cr>', { silent = true, noremap = true })
end
function plug_keybind(mode, keys, plugname)
  api.nvim_set_keymap(mode, keys, '<Plug>('.. plugname ..')', { noremap = true })
end

vim_keybind('n', '<leader>Vl', 'e $HOME/.config/nvim/init.lua')
vim_keybind('n', '<leader>Vn', 'e $HOME/.config/nvim/legacy-init.vim')
vim_keybind('n', '<leader>Vs', 'luafile $NEOVIM_LUA_INIT')
vim_keybind('n', '<f5>', 'call github_colors#toggle_soft()')

-- api.nvim_set_var("vimsyn_embed", "lPr")
api.nvim_set_option("titlestring", "nvim: %f %a%r%m")
-- api.nvim_set_option("guicursor", "v:true")
-- api.nvim_command("set guicursor")

-- terminal mappings
api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {})
api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-n><C-w>h', {})
api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-n><C-w>j', {})
api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-n><C-w>k', {})
api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-n><C-w>l', {})

-- colorscheme
api.nvim_set_option("background", "dark")
-- requires
api.nvim_set_var("github_colors_soft", 1)
api.nvim_set_var("github_colors_block_diffmark", 0)
api.nvim_command("let g:lightline.colorscheme = 'github'")
api.nvim_command("colorscheme github")

-- dark-notify
local pack_home = vim.fn.stdpath('data')..'/site/pack/packer'
local git_cormacrelf = vim.env.HOME .. "/git/cormacrelf"
require('dark_notify').run({
  lightline_loaders = {
    github=(git_cormacrelf .. "/vim-colors-github/autoload/lightline/colorscheme/github.vim")
  },
  schemes = {
    light = { colorscheme = "github", lightline = "github" },
    dark = { colorscheme = "github", lightline = "github" },
  }
})
vim.api.nvim_set_keymap('n', '<f4>', '<cmd>lua require("dark_notify").toggle()<cr>', { silent = true })

-- lsp (nvim-lspconfig)
-- Starter: https://sharksforarms.dev/posts/neovim-rust/
-- https://github.com/neovim/nvim-lspconfig#rust_analyzer

-- lspconfig object
local lspconfig = require'lspconfig'
-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
  require'completion'.on_attach(client)
end
-- Enable rust_analyzer
lspconfig.rust_analyzer.setup({ on_attach = on_attach })
lspconfig.tsserver.setup({ on_attach = on_attach })
-- restart lsp
api.nvim_command("command! LspRestart execute 'lua vim.lsp.stop_client(vim.lsp.get_active_clients())' <BAR> edit")
-- update rust-analyzer
api.nvim_command("command! RustAnalyzerUpdate !curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-mac -o ~/.local/bin/rust-analyzer && chmod +x ~/.local/bin/rust-analyzer")

-- LSP bindings
lua_keybind('n', 'gd', 'vim.lsp.buf.definition()')
-- lua_keybind('n', 'gd', 'vim.lsp.buf.declaration()')
lua_keybind('n', 'gD', 'vim.lsp.buf.implementation()')
lua_keybind('n', '1gD', 'vim.lsp.buf.type_definition()')
lua_keybind('n', 'K', 'vim.lsp.buf.hover()')
lua_keybind('n', 'gK', 'vim.lsp.buf.signature_help()')
lua_keybind('n', 'gr', 'vim.lsp.buf.references()')
lua_keybind('n', 'g0', 'vim.lsp.buf.document_symbol()')
lua_keybind('n', 'gW', 'vim.lsp.buf.workspace_symbol()')
lua_keybind('n', '<leader>.', 'vim.lsp.buf.code_action()')
lua_keybind('n', '<leader>rn', 'vim.lsp.buf.rename()')

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
api.nvim_command("set completeopt=menuone,noinsert,noselect")
-- Avoid showing extra messages when using completion
api.nvim_command("set shortmess+=c")

-- Diagnostics bindings
lua_keybind('n', '[d', 'vim.lsp.diagnostics.goto_prev()')
lua_keybind('n', ']d', 'vim.lsp.diagnostics.goto_next()')
lua_keybind('n', ']D', 'vim.lsp.diagnostics.set_loclist()')

-- Configure diagnostics
api.nvim_set_var("diagnostic_enable_virtual_text", 1)
api.nvim_set_var("diagnostic_trimmed_virtual_text", "40")
api.nvim_set_var("diagnostic_insert_delay", 1)

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
api.nvim_set_option("signcolumn", "yes")

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
api.nvim_set_option("updatetime", 300)

nvim_create_augroups {
  -- Show diagnostic popup on cursor hold
  line_diagnostics = {
    { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics()" }
  },
  -- Enable type inlay hints
  lsp_inlay_hints = {
    {
      "CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost",
      "*",
      "lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = 'Comment' }"
    },
  },
}


-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust" },  -- list of language that will be disabled
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["foo.bar"] = "Identifier",
    },
  },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>aa"] = "@parameter.inner",
        ["<leader>as"] = "@statement.outer",
        ["<leader>af"] = "@function.outer",
      },
      swap_previous = {
        ["<leader>AA"] = "@parameter.inner",
        ["<leader>AS"] = "@statement.outer",
        ["<leader>AF"] = "@function.outer",
      },
    },
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["as"] = "@statement.outer",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    -- lsp_interop = {
    --   enable = true,
    --   peek_definition_code = {
    --     ["<leader>pf"] = "@function.outer",
    --   },
    -- },
  },
}
api.nvim_set_option("foldmethod", "expr")
api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

-- highlight after yanking
-- https://www.reddit.com/r/neovim/comments/gofplz/neovim_has_added_the_ability_to_highlight_yanked/g5sgtjp/
nvim_create_augroups {
  highlight_yank = {
    {"TextYankPost",     "*.todo", "silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }"},
  },
}

-- git-messenger
api.nvim_set_var("git_messenger_no_default_mappings", true)
-- bb for 'blame'
plug_keybind('n', '<leader>bb', 'git-messenger')

-- bullets.vim
api.nvim_set_var("bullets_enable_in_empty_buffers", 0)
api.nvim_set_var("bullets_enabled_file_types", { "markdown", "pandoc", "text", "gitcommit" })
