function! s:log_message(commit)
	if a:commit == '00000000'
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
	setlocal noruler
	setlocal noshowcmd
	if strlen(a:message) > &columns
		return a:message[0:(&columns - 5)] . '...'
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
