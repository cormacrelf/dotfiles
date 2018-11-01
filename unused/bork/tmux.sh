#!/bin/bash
DOT="$HOME/.dotfiles"
TMUX="$DOT/tmux"
PLUG="$DOT/tmux/plugins"

ok directory "$PLUG"
ok github "$PLUG/tpm" tmux-plugins/tpm

