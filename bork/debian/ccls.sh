# https://github.com/MaskRay/ccls/wiki/Getting-started

ok apt zlib1g-dev
ok apt ncurses-dev
ok apt g++-7

mkdir -p $HOME/lib
ok github $HOME/lib/ccls MaskRay/ccls
if did_update; then
  needs_exec "git" || exit $STATUS_FAILED_PRECONDITION
  cd $HOME/lib/ccls
  git submodule update --init
  cmake -H. -BRelease
  cmake --build Release
fi
