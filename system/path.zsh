export PATH=".:bin:$HOME/bin:/usr/local/share/npm/bin:$HOME/.cabal/bin:/usr/local/bin:/usr/local/sbin:$HOME/Library/Haskell/bin:$DOT/bin:$PATH"

# GNU coreutils
if hash brew 2>/dev/null; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

export GOPATH="$HOME/go"

export PATH="$PATH:$GOPATH/bin"

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH="$PATH:/Developer/NVIDIA/CUDA-7.5/bin"

