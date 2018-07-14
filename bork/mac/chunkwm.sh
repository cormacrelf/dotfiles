ok brew-tap crisidev/chunkwm
ok brew chunkwm
if did_install; then
  brew services restart chunkwm
fi

ok brew-tap koekeishiya/formulae
ok brew skhd
if did_install; then
  brew services restart skhd
fi

