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
endif

let $VIM_CONFIG=$VIM_HOME.'/config.vim'
source $VIM_CONFIG

let s:plug = $VIM_HOME."/plug.vim"
let s:plugdir =  $VIM_HOME.'/plugged'
echom 'installing plugins from '.s:plug.' to ' . s:plugdir

filetype off
call plug#begin(s:plugdir)
    exec 'so ' .s:plug
call plug#end()

echom "running PlugInstall"
PlugInstall
PlugUpdate
qa!
