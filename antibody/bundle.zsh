has-antibody () {
    hash antibody 2>/dev/null
}

if ! has-antibody; then
    # install it
    sh -s < "$DOT/antibody/antibody-install.sh"
    if ! has-antibody; then
        echo "Failed to install antibody."
        exit
    fi
fi

mkdir -p "$HOME/.antibody"
bundle_zsh="$DOT/antibody/bundle.zsh"
ab_plugins="$DOT/antibody/plugins.txt"
ab_sources="$HOME/.antibody/ab_sources.sh"
hashes="$HOME/.antibody/hashes.md5"

strip-comments () { grep -v "^\s*#\|^\s*$" < "$ab_plugins"; }
check-sums () { md5sum -c "$hashes" 2>/dev/null >/dev/null;  }

if [[ ! -e "$ab_sources" ]] || ! check-sums; then
    echo "regenerating antibodies:"
    strip-comments | sed 's/^/ - /'

    # Note: antibody here refers to the binary. Once you've $(antibody init)-ed,
    # you can't pipe bundle output. We won't do this.
    strip-comments | antibody bundle | sed 's/^/source /' > "$ab_sources"

    # Note: changing this bundle.zsh file will trigger regeneration, for convenience.
    md5sum "$ab_plugins" "$ab_sources" "$bundle_zsh" > "$hashes"
fi

# oh-my-zsh overrides, so it knows where it is.
export DISABLE_AUTO_UPDATE="true"
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
export ZSH_THEME=""

source $ab_sources
