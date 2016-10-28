export PATH="$HOME/bin:$HOME/.cabal/bin:/usr/local/bin:/usr/local/sbin:$DOT/bin:$PATH"

# GNU coreutils
if hash brew 2>/dev/null; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

# Golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Rust/cargo
export PATH="$PATH:$HOME/.cargo/bin"
export RUST_DEFAULT_TOOLCHAIN=$(rustup toolchain list | grep default | cut -d' ' -f1)
export RUST_SRC_PATH="$HOME/.multirust/toolchains/$RUST_DEFAULT_TOOLCHAIN/lib/rustlib/src/rust/src"

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH="$PATH:/Developer/NVIDIA/CUDA-7.5/bin"

