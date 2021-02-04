function crate
  # cd (crate_dir)/crates/$argv[1]
  set -l fzf_query $argv[1]
  if not test -z $fzf_query
    set -l fzf_query $commandline[2]
  end

  set CRATES (crate_dir)/crates
  set COMMAND "cd $CRATES && fd --type d -d 1"

  eval "$COMMAND | "(__fzfcmd)" +m $FZF_DEFAULT_OPTS $FZF_CD_OPTS --query \"$fzf_query\"" | read -l select

  if not test -z "$select"
    builtin cd "$select"

    # Remove last token from commandline.
    commandline -t ""
  end

  commandline -f repaint
end

function crate_dir
  cargo metadata --format-version 1 2>/dev/null | jq -r .workspace_root
end

