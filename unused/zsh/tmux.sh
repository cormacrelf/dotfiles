#!/bin/sh
if hash tmux >/dev/null 2>/dev/null; then
  if [ -z "$TMUX" ]; then
    tmux attach -t TMUX || tmux new -s TMUX
  fi
fi
