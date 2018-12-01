let g:cormacrelf = {}
let g:cormacrelf.coc = 1
let g:cormacrelf.ncm2 = 0
let g:cormacrelf.LanguageClient = 0
let g:cormacrelf.lightline = 1
let g:cormacrelf.snippets = 1
let g:cormacrelf.startify = 0
let g:cormacrelf.prose_hard_wrap = 1

func! Cormacrelf_DisableSnippets()
  let g:cormacrelf.ncm2 = 0
  let g:cormacrelf.LanguageClient = 0
  let g:cormacrelf.snippets = 0
endfunc

if exists("g:gui_oni")
  call Cormacrelf_DisableSnippets()
  let g:cormacrelf.lightline = 0
endif

if exists("$VIM_LOCAL_CONFIG") && filereadable($VIM_LOCAL_CONFIG)
  source $VIM_LOCAL_CONFIG
endif

if filereadable(".local.vim")
  source .local.vim
elseif filereadable(".config/local.vim")
  source .config/local.vim
endif
