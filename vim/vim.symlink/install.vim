set nocompatible

if $VIM_HOME == ''
    if has('win32') || has ('win64')
        let $VIM_HOME = $HOME."/AppData/Local/nvim"
    else
        let $VIM_HOME = $HOME."/.vim"
    endif
endif
echom $VIM_HOME.'/plugged'

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

filetype off
call plug#begin($VIM_HOME.'/plugged')
    let $VIM_PLUG = $VIM_HOME."/plug.vim"
    so $VIM_PLUG
call plug#end()

echom "running PlugInstall"
PlugInstall
echom "installed all plugins"