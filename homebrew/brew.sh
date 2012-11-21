# Check if homebrew is already installed, if not - install it
command -v brew >/dev/null 2>&1 || {
	/usr/bin/ruby <$(curl -fsSk https://raw.github.com/mxcl/homebrew/go)
}

# Update Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install formulae
for formula in git hub zsh rbenv ruby-build ack tree vim haskell-platform tig clojure; do
	brew install $formula
done

# Remove outdated versions from the cellar
brew cleanup
