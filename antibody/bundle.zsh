has-antibody () {
    hash antibody 2>/dev/null
}

if ! [[ has-antibody; ]]; then
    # install it
    sh -s < "$DOT/antibody/antibody-install.sh"
    if ! [[ has-antibody; ]]; then
        echo "Failed to install antibody."
        exit
    fi
fi


mkdir -p "$HOME/.antibody"
ab_plugins="$DOT/antibody/plugins.txt"
ab_sources="$HOME/.antibody/ab_sources.sh"
hashes="$HOME/.antibody/hashes.md5"

strip-comments () { grep -v "^\s#\|^\s*$" < "$ab_plugins"; }
check-sums () { md5sum -c "$hashes" 2>/dev/null >/dev/null;  }

source <(antibody init)

export DISABLE_AUTO_UPDATE="true"
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
export ZSH_THEME=""
antibody bundle robbyrussell/oh-my-zsh

if [[ ! -e "$ab_sources" || ! check-sums; ]]; then
    rm -f "$ab_sources"
    strip-comments | antibody bundle | xargs -I {} echo "source {}" >> "$ab_sources"
    md5sum "$ab_plugins" "$ab_sources" > "$hashes"
fi

source $ab_sources
