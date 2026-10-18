let s:popup = -1
let s:debounce_timer = -1
let s:render_timer = -1

function! modbang#_on_cmdline_enter() abort
  call s:PopupCreate()
endfunction

function! modbang#_on_cmdline_changed() abort
  if s:render_timer != -1
    call timer_stop(s:render_timer)
  endif

  let s:render_timer = timer_start(250, { -> s:Render() })
endfunction

function! modbang#_on_cmdline_leave() abort
  if s:render_timer != -1
    call timer_stop(s:render_timer)
    let s:render_timer = -1
  endif

  call s:PopupClose()
endfunction

function! s:PopupCreate() abort
  let s:popup = popup_create('modbang_preview_popup', {
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
endfunction!

function! s:Render() abort
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
endfunction!

function! s:PopupClose() abort
  call popup_close(s:popup)
  let s:popup = -1
endfunction
