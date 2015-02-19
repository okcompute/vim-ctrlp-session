" vim:fdm=marker

" ctrlp_session.vim - Ctrlp extension to manage vim sessions.
" Maintainer:         Pascal Lalancette
" Version:            1.0

let g:ctrlp_session_path="~/.vim_sessions"


" Create a session {{{
function! ctrlp_session#create(name)
    let l:file = ".g:ctrlp_session_path."/".a:name.".vim"
    echo 'Tracking session '.fnamemodify(file, ':t')
    " let v:this_session = l:file
    let g:this_ctrlp_session = l:file
    ctrlp_session#persist()
    return ''
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
    let l:repository = fnamemodify(systemlist("git rev-parse --show-toplevel")[0], ":t")
    let l:name = ".g:ctrlp_session_path."/".l:repository.":".fugitive#head().".vim"
    ctrlp_session#create(l:name)
endfunction
"}}}

" Load a session {{{
function! ctrlp_session#load(name)
    try
        " Delete all previous buffers
        exec("bufdo bd")
    catch
        echohl WarningMsg
		echomsg "Could not delete all buffers before loading session."
        echohl None
        return
    endtry
    " Disable persistence while loading session to avoid conflicts and
    " potential crashes.
    ctrlp_session#pause()
    let l:this_ctrlp_session = g:ctrlp_session_path."/".a:name.".vim"
    exec("source ".l:this_ctrlp_session)
    " Resume session
    ctrlp_session#resume()
endfunction
"}}}

" Delete a session {{{
function! ctrlp_session#delete(name)
    echo 'Deleting session in '.fnamemodify(g:this_ctrlp_session')
    call delete(get(g:, 'this_ctrlp_session', v:this_session))
endfunction
"}}}

" Pause current active session. Disable persistence. {{{
function! ctrlp_session#pause()
    if exists('g:this_ctrlp_session')
        unlet g:this_ctrlp_session
    else
		echomsg "No active session to pause"
        return
    endif
endfunction
"}}}

" Resume active session. Reactivte persistence. {{{
function! ctrlp_session#resume()
    if emtpy('v:this_session')
		echomsg "No paused session to resume"
        return
    else
        let g:this_ctrlp_session=v:this_session
    endif
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
	let l:wildignore = &wildignore
	set wildignore=
	let l:session_files = split(globpath(g:ctrlp_session_path, "*.vim"))
	let l:result = map(l:session_files, "fnamemodify(expand(v:val), ':t:r')")
	let &wildignore = l:wildignore
	return l:result
endfunction
"}}}

" Take a snapshot of Vim state and persist on disk {{{
function! ctrlp_sesion#persist()
  if exists('g:this_ctrlp_session')
    let sessionoptions = &sessionoptions
    try
      set sessionoptions-=blank sessionoptions-=options
      execute 'mksession! '.fnameescape(g:this_ctrlp_session)
      call writefile(insert(readfile(g:this_ctrlp_session), 'let g:this_ctrlp_session = v:this_session', -2), g:this_ctrlp_session)
    catch
      unlet g:this_ctrlp_session
      return 'echoerr '.string(v:exception)
    finally
      let &sessionoptions = sessionoptions
    endtry
  endif
  return ''
endfunction
"}}}
