#!/bin/sh

if hash brew 2>/dev/null; then
  echo "ok: brew installed already"
else 
  echo "~~~ now installing homebrew ~~~"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if hash bork 2>/dev/null; then
  echo "ok: bork installed already"
else
  echo "~~~ now installing bork ~~~"
  brew install bork
fi
