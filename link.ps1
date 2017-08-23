function ln-s ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

ln-s "${PSScriptRoot}\vim\vim.symlink" "$env:LOCALAPPDATA\nvim"

