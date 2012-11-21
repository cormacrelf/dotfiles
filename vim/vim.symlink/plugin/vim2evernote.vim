" --------------------------------------------------------------*
" Vim2Evernote
" Vim global plugin to send selected lines directly to Evernote
" Created: 01 Mar 2011 
" Author: Rense Corten
" License:	This file is placed in the public domain.
" --------------------------------------------------------------*
"
" --------------------------------------------------------------*
"  Usage:
"  1.	Save this file in /vim/vimfiles/plugin/
"  

"  2. 	Set Evernote to monitor a path on your harddisk.
"  		Vim2Evernote will write the selected lines in a .md file
"  		with a weird name in that path.
"  		Evernote will automatically import the file; the title of
"  		the note will be the first line of the selected text.
"
"  3.	Optionally, set Evernote to delete the file after
"  		importing.
"
"  4. 	Edit line 54 to contain the path of the path you set in
"  		step 2.
"
"  5. 	To use the plugin, visually select some text and press
"  		<Leader>e, where <Leader> is your mapleader, typically '\'.
"  		The mapping may be changed in your .vimrc file. 
"  		
"  NOTE: Evernote may complain about 'invalid characters' in the
"  title of the note (the first selected line). The only solution
"  for now is to change that line.
" --------------------------------------------------------------*



if exists("g:loaded_Vim2Evernote") || &cp
	finish
endif
let g:loaded_Vim2Evernote= 1.0 

vnoremap <Plug>ENlines :call <sid>ENlines()<cr>
if !hasmapto('<Plug>ENlines', 'n')
	vmap <Leader>e <Plug>ENlines
endif

function! s:ENlines()
	let mypath = '/Users/cormac/Dropbox/Elements/evernote/'  "Edit this line to reflect your setup
	echo "Writing to " . mypath . "..."

	let selectedLines = getbufline('%', line("'<"), line("'>"))

	if col("'>") < strlen(getline(line("'>")))
		let selectedLines[-1] = strpart(selectedLines[-1], 0, col("'>"))
	endif
	if col("'<") != 1
		let selectedLines[0] = strpart(selectedLines[0], col("'<")-1)
	endif


	let temp = mypath.'note'.strftime("%y%m%d%H%M%S").'.md' 
	call writefile(selectedLines, temp)

	execute "!/usr/local/share/python/gnsync --path" mypath "--logpath ~/Library/Logs/gnsync.log --notebook 'Inbox' --format markdown"

	execute "!rm" temp
endf
