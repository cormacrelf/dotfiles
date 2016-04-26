ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}±%{$fg[white]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}±%{$fg[white]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="]%{$reset_color%} "
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN
ZSH_THEME_HG_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_HG_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_HG_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_HG_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN

vcs_status() {
    if [[ ( $(whence in_svn) != "" ) && ( $(in_svn) == 1 ) ]]; then
        svn_prompt_info
    elif [[ ( $(whence in_hg) != "" ) && ( $(in_hg) == 1 ) ]]; then
        hg_prompt_info
    else
        git_prompt_info
    fi
}

prompt_pure_human_time() {
    local tmp=$1
    local days=$(( tmp / 60 / 60 / 24  ))
    local hours=$(( tmp / 60 / 60 % 24  ))
    local minutes=$(( tmp / 60 % 60  ))
    local seconds=$(( tmp % 60  ))
    (( $days > 0  )) && echo -n "${days}d "
    (( $hours > 0  )) && echo -n "${hours}h "
    (( $minutes > 0  )) && echo -n "${minutes}m "
    echo "${seconds}s"
}

# displays the exec time of the last command if set threshold was exceeded
prompt_pure_cmd_exec_time() {
    local stop=$EPOCHSECONDS
    local start=${cmd_timestamp:-$stop}
    integer elapsed=$stop-$start
    (($elapsed > ${PURE_CMD_MAX_EXEC_TIME:=5})) && prompt_pure_human_time $elapsed
}

exit_time() {
    local str='%(?..%{$fg_bold[red]%}exit %?
%{$reset_color%})'
    # str="$str%{$fg_bold[red]%}$(prompt_pure_cmd_exec_time)%{$reset_color%}"
    echo $str
}

function check_last_exit_code() {
    local LAST_EXIT_CODE=$?
    if [[ $LAST_EXIT_CODE -ne 0  ]]; then
        local EXIT_CODE_PROMPT=''
        # EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
        EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
        # EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
        EXIT_CODE_PROMPT+=" "
        echo "$EXIT_CODE_PROMPT"
    fi
}

if [ $SSH_CONNECTION ]; then SSH="%n@%m: "; else SSH=""; fi

PROMPT='$(check_last_exit_code)%{$fg[red]%}$SSH%2~%{$reset_color%} $(vcs_status)$ '

