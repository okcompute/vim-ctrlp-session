" ctrlp_session.vim - Ctrlp extension to manage Vim sessions.
" Maintainer:         Pascal Lalancette
" Version:            1.0

augroup ctrlp_session
  autocmd!
  autocmd BufEnter,VimLeavePre * exe s:persist()
augroup END

function! s:CtrlPSession()
	if !exists(":CtrlP")
        echohl WarningMsg
		echomsg "Error: CtrlP not installed."
        echohl None
		return
	endif
    call ctrlp#init(ctrlp#ctrlp_session#id())
endfunction

command! -nargs=1 Session execute s:Session(<f-args>)
command! -nargs=0 SessionGit call s:SessionGit()
command! -nargs=1 SessionLoad call s:SessionLoad(<f-args>)
command! -nargs=0 SessionDelete call g:session_delete()
command! -nargs=0 SessionPause call s:SessionPause()
command! -nargs=0 SessionList echo join(g:obsession_list(), ", ")
command! -nargs=0 CtrlPObsession call s:CtrlPObsession()
