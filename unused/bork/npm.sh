register types/nvm.sh
register types/nvm-alias.sh

export NVM_DIR="$HOME/.nvm"

ok github "$NVM_DIR" creationix/nvm --branch="v0.33.11"

ok nvm 10
ok nvm-alias default 10

# use it because otherwise it could still be on another version
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use 10

ok npm yarn
ok npm typescript-language-server
ok npm crx
ok npm sql-cli
ok npm diff-so-fancy
