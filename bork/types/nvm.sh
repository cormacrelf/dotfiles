action=$1
version=$2
shift 2
dir=$(arguments get nvm_dir $*)
NVM_DIR=${NVM_DIR:="${dir:="$HOME/.nvm"}"}

export NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" || exit $STATUS_FAILED_PRECONDITION

case $action in
  desc)
    echo "asserts presence of nvm version"
    echo "> nvm 9"
    echo "> nvm v8.0"
    ;;
  status)
    nvm ls "$version" 2>&1 > /dev/null
    [ "$?" -gt 0 ] && return $STATUS_MISSING
    return 0 ;;
  install)
    nvm install "$version"
    ;;
  upgrade)
    exit $STATUS_FAILED
    ;;
esac

