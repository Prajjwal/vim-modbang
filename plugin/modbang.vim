if exists("g:loaded_modbang")
  finish
endif

let g:loaded_modbang = 1
let s:popup = -1

function! s:HandleCmdlineEnter() abort
  let s:popup = popup_create('lul', {
        \ 'pos': 'topright',
        \ 'line': 1,
        \ 'col': &columns,
        \ 'maxwidth': &columns / 3,
        \ 'minwidth': &columns / 3,
        \ 'minheight': &lines,
        \ 'title': '[modbang]',
        \ 'padding': [1, 1, 1, 1],
        \ 'border': [1, 1, 1, 1],
        \ 'hidden': v:true,
        \ })
endfunction

function! s:HandleCmdlineChange() abort
  let l:cmd = getcmdline()

  if l:cmd !~ '^%!'
    return
  endif

  let l:buffer = bufnr('%')

  try
    let l:output = systemlist(l:cmd[2:], l:buffer)
    call popup_setoptions(s:popup, { 'title': '[modbang]' })
    call popup_settext(s:popup, l:output)
  catch /^Vim\%((\a\+)\)\?:E\(282\|485\):/
    call popup_setoptions(s:popup, { 'title': '[modbang !!]' })
  endtry

  call popup_show(s:popup)
  redraw
endfunction

function! s:HandleCmdlineLeave() abort
  call popup_close(s:popup)
  let s:popup = -1
endfunction

augroup Modbang
  autocmd!

  autocmd CmdlineEnter * call s:HandleCmdlineEnter()
  autocmd CmdlineLeave * call s:HandleCmdlineLeave()
  autocmd CmdlineChanged * call s:HandleCmdlineChange()
augroup END
