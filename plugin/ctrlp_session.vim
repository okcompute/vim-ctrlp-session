" ctrlp_session.vim - Ctrlp extension to manage Vim sessions.
" Maintainer:         Pascal Lalancette
" Version:            1.0

augroup ctrlp_session
  autocmd!
  autocmd BufEnter,VimLeavePre * call ctrlp_session#persist()
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

command! -nargs=1 Session call ctrlp_session#create(<f-args>)
command! -nargs=0 SessionGit call ctrlp_session#create_git()
command! -nargs=1 SessionLoad call ctrlp_session#load(<f-args>)
command! -nargs=0 SessionDelete call ctrlp_session#delete()
command! -nargs=0 SessionQuit call ctrlp_session#quit()
command! -nargs=0 SessionPause call ctrlp_session#pause()
command! -nargs=0 SessionResume call ctrlp_session#resume()
command! -nargs=0 SessionList echo join(ctrlp_session#list(), ", ")
command! -nargs=0 CtrlPSession call s:CtrlPSession()
