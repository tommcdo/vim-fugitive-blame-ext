function! s:log_message(commit)
	if a:commit =~ '^0\+$'
		return '(Not Committed Yet)'
	endif
	if !has_key(s:log_messages, a:commit)
		let cmd_output = system('git --git-dir='.b:git_dir.' show --oneline '.a:commit)
		let first_line = split(cmd_output, '\n')[0]
		let s:log_messages[a:commit] = substitute(first_line, '[a-z0-9]\+ ', '', '')
	endif
	return s:log_messages[a:commit]
endfunction

function! s:truncate_message(message)
	let offset = 2
	if &ruler == 1 && (&laststatus == 0 || (&laststatus == 1 && winnr('$') == 1))
		" Statusline is not visible, so the ruler is. Its width is either 17
		" (default) or defined in 'rulerformat'.
		let offset += str2nr(get(matchlist(&rulerformat, '^%\(\d\+\)('), 1, '17')) + 1
	endif
	if &showcmd
		" Width of showcmd seems to always be 11.
		let offset += 11
	endif
	let maxwidth = &columns - offset
	if strlen(a:message) > maxwidth
		return a:message[0:(maxwidth - 3)] . '...'
	else
		return a:message
	endif
endfunction

function! s:show_log_message()
	let line = substitute(getline('.'), '\v^\^?([a-z0-9]+).*$', '\1', '')
	redraw
	echo s:truncate_message(s:log_message(line))
endfunction

let s:log_messages = {}
autocmd CursorMoved *.fugitiveblame call <SID>show_log_message()
