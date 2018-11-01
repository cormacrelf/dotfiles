ok apt git
ok apt build-essential
ok apt fish
if did_install; then
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/fish
fi

