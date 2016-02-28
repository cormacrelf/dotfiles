# Check if homebrew is already installed, if not - install it
command -v brew >/dev/null 2>&1 || {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Update Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install from Brewfile
brew tap Homebrew/bundle
brew bundle

# Remove outdated versions from the cellar
brew cleanup
