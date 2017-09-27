function ln-s ($target, $link) {
    cmd /c mklink /D "$link" "$target"
}

ln-s "${PSScriptRoot}\vim\vim.symlink" "$env:LOCALAPPDATA\nvim"

write-output "installing big list of vim plugins in headless mode, please wait"

Set-Location $PSScriptRoot\vim\vim.symlink

nvim -u .\install.vim

Set-Location $PSScriptRoot
