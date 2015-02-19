" =============================================================================
" File:          autoload/ctrlp/ctrlp_session.vim
" Description:   Load sessions directly from CtrlP
" =============================================================================


" Load guard
if ( exists('g:loaded_ctrlp_session') && g:loaded_ctrlp_session )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_session = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp#ctrlp_session#init()',
	\ 'accept': 'ctrlp#ctrlp_session#accept',
	\ 'lname': 'sessions',
	\ 'sname': 'sessions',
	\ 'type': 'line',
	\ })

	" \ 'enter': 'ctrlp#ctrlp_session#enter()',
	" \ 'exit': 'ctrlp#ctrlp_session#exit()',
	" \ 'opts': 'ctrlp#ctrlp_session#opts()',
	" \ 'sort': 0,
	" \ 'specinput': 0,

" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#ctrlp_session#init()
	let l:sessions = ctrlp_session#list()
	if exists("v:this_session")
		let l:sessions = filter(l:sessions, "v:val != '".v:this_session."'")
	endif
	return l:sessions
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#ctrlp_session#accept(mode, str)
	call ctrlp#exit()
  if a:mode == 'h'
    call ctrlp_session#delete(a:str)
    return
  endif
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#ctrlp_session#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#ctrlp_session#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#ctrlp_session#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#ctrlp_session#id()
	return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/session.vim
" command! CtrlPSession call ctrlp#init(ctrlp#ctrlp_session#id())


" vim:nofen:fdl=0:ts=2:sw=2:sts=2
