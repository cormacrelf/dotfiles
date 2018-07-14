DOT="$HOME/.dotfiles"

ok symlink $HOME/.vim $DOT/vim/vim.symlink
ok symlink $HOME/.vimrc $DOT/vim/vim.symlink/vimrc.vim

ok symlink $HOME/.zshrc $DOT/zsh/zshrc.symlink
ok symlink $HOME/.gitignore $DOT/git/gitignore.symlink
ok symlink $HOME/.gitconfig $DOT/git/gitconfig.symlink
ok symlink $HOME/.tmux.conf $DOT/tmux/tmux.conf
ok symlink $HOME/.chunkwmrc $DOT/chunkwm/chunkwmrc
ok symlink $HOME/.skhdrc $DOT/chunkwm/skhdrc

ok directory $HOME/.config
ok symlink $HOME/.config/fish $DOT/fish
ok symlink $HOME/.config/nvim $DOT/vim/vim.symlink
ok symlink $HOME/.config/alacritty $DOT/alacritty
