# TODO --sudo flag
# TODO versions
# TODO update

action=$1
name=$2
shift 2

case $action in
  desc)
    echo "asserts presence of packages installed via pip3"
    echo "> pip3 pygments"
    ;;
  status)
    needs_exec "pip3" || return $STATUS_FAILED_PRECONDITION
    pkgs=$(bake pip3 list | grep "^$name")
    [ "$?" -gt 0 ] && return $STATUS_MISSING
    pkgs=$(bake pip3 list --outdated | grep "^$name")
    [ "$?" -eq 0 ] && return $STATUS_OUTDATED
    return 0 ;;
  install)
    bake pip3 install "$name"
    ;;
  upgrade)
    bake pip3 install --upgrade "$name"
    ;;
esac

