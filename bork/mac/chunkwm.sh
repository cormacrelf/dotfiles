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

# it doesn't work apparently
# ok brew chunkwm-blur --from='--HEAD crisidev/chunkwm'
# ok symlink /usr/local/opt/chunkwm/share/chunkwm/plugins/blur.so /usr/local/opt/chunkwm-blur/share/chunkwm-blur/plugins/blur.so

