function fuzzy_edit_in
  set -l _flag_dir "."
  argparse 'd/dir=' -- $argv
  or return
  set -l prev_dir "$PWD"
  cd $_flag_dir
  eval "fd -tf . $dir | "(__fzfcmd) $preview_cmd "-m $FZF_DEFAULT_OPTS $FZF_OPEN_OPTS --query \"$fzf_query\"" | read -l select
  if not test -z "$select"
    eval "$EDITOR \"$_flag_dir/$select\""
  end
  cd "$prev_dir"
end

