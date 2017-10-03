" ctrlp_session.vim - Ctrlp extension to manage Vim sessions.
" Maintainer:         Pascal Lalancette
" Version:            1.0

" Location of session files
if !exists('g:ctrlp_session_path')
	if exists('g:ctrlp_cache_dir')
		let g:ctrlp_session_path=expand(g:ctrlp_cache_dir . '/sessions')
	else
		let g:ctrlp_session_path="~/.vim_sessions"
	endif
endif

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
command! -nargs=0 SGit call ctrlp_session#create_git()
command! -nargs=1 SLoad call ctrlp_session#load(<f-args>)
command! -nargs=1 SDelete call ctrlp_session#delete(<f-args>)
command! -nargs=0 SQuit call ctrlp_session#quit()
command! -nargs=0 SList echo join(ctrlp_session#list(), ", ")
command! -nargs=0 CtrlPSession call s:CtrlPSession()
