" vim:fdm=marker

" ctrlp_session.vim - Ctrlp extension to manage vim sessions.
" Maintainer:         Pascal Lalancette
" Version:            1.0

let g:ctrlp_session_path="~/.vim_sessions"

" Return full session path from a session name {{{
function! s:session_file(name)
    let l:file = g:ctrlp_session_path."/".a:name.".vim"
    return fnamemodify(expand(l:file), ':p')
endfunction
"}}}

" system() implementation which keep only first line and remove ending newline
" {{{
function! s:system(cmd)
    let l:output=system(a:cmd)
    let l:lines = split(l:output, "\n")
    if empty(l:lines)
        return ""
    endif
    return l:lines[0]
endfunction
" }}}
"
" Create a session {{{
function! ctrlp_session#create(name)
    echo 'Tracking session '.a:name
    let g:this_ctrlp_session = s:session_file(a:name)
    call ctrlp_session#persist()
endfunction
"}}}

" Create a session using name of current git branch. {{{
function! ctrlp_session#create_git()
	if !exists("*fugitive#head")
        echohl WarningMsg
		echomsg "Error: vim-fugitive not installed."
        echohl None
		return
	endif
	if empty(fugitive#head())
        echohl WarningMsg
		echomsg "Cannot create session: No git repository found."
        echohl None
		return
    endif
    let l:repository=fnamemodify(s:system("git rev-parse --show-toplevel"), ":t")
    let l:name=l:repository."@".fugitive#head()
    call ctrlp_session#create(l:name)
endfunction
"}}}

" Load a session {{{
function! ctrlp_session#load(name)
    " Disable persistence while loading session to avoid conflicts and
    " potential crashes.
    if exists('g:this_ctrlp_session')
        unlet g:this_ctrlp_session
    endif
    exec("source ".s:session_file(a:name))
endfunction
"}}}

" Delete a session {{{
function! ctrlp_session#delete(name)
    echo 'Deleting session in '.a:name
    let l:session_file = s:session_file(a:name)
    if exists('g:this_ctrlp_session') && l:session_file == g:this_ctrlp_session
        " The deleted session is the active one. Make sure it does not
        " magically reappear!
        unlet g:this_ctrlp_session
    endif
    call delete(l:session_file)
endfunction
"}}}

" Quit current active session and reset Vim. {{{
function! ctrlp_session#quit()
    if !exists('g:this_ctrlp_session')
		echomsg "No active session to quit"
        return
    endif
    unlet g:this_ctrlp_session
    try
        " Delete all previous buffers
        exec("bufdo bd")
    catch
        echohl WarningMsg
		echomsg "Could not delete all buffers while leaving session."
        echohl None
        return
    endtry
endfunction
"}}}

" List all persisted sessions {{{
function! ctrlp_session#list()
	let l:wildignore=&wildignore
	set wildignore=
	let l:session_files=split(globpath(g:ctrlp_session_path, "*.vim"))
	let l:result=map(l:session_files, "fnamemodify(expand(v:val), ':t:r')")
	let &wildignore=l:wildignore
	return l:result
endfunction
"}}}

" Take a snapshot of Vim state and persist on disk {{{
function! ctrlp_session#persist()
  if exists('g:this_ctrlp_session')
    let sessionoptions= &sessionoptions
    try
      set sessionoptions-=blank sessionoptions-=options
      execute 'mksession! '.fnameescape(g:this_ctrlp_session)
      call writefile(insert(readfile(g:this_ctrlp_session), 'let g:this_ctrlp_session =v:this_session', -2), g:this_ctrlp_session)
    catch
      unlet g:this_ctrlp_session
      echoerr string(v:exception)
    finally
      let &sessionoptions=sessionoptions
    endtry
  endif
  return ''
endfunction
"}}}
