action=$1
name=$2
version=$3
shift 3
dir=$(arguments get nvm_dir $*)
NVM_DIR=${NVM_DIR:="${dir:="$HOME/.nvm"}"}

export NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" || exit $STATUS_FAILED_PRECONDITION

case $action in
  desc)
    echo "asserts presence of nvm alias"
    echo "> nvm-alias default 9"
    echo "> nvm-alias default v8.0"
    ;;
  status)
    needs_exec "perl" || return $STATUS_FAILED_PRECONDITION
    nvm alias "$name" | perl -pe 's/\x1b\[[0-9;]*m//g' | grep "^$name"
    [ "$?" -gt 0 ] && return $STATUS_MISSING
    nvm alias "$name" | perl -pe 's/\x1b\[[0-9;]*m//g' | awk '{ print $3 }' | grep "$version"
    [ "$?" -gt 0 ] && return $STATUS_OUTDATED
    return 0 ;;
  install)
    nvm alias "$name" "$version"
    ;;
  upgrade)
    nvm alias "$name" "$version"
    ;;
esac

