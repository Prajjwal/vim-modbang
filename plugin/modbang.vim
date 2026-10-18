if exists("g:loaded_modbang")
  finish
endif

let g:loaded_modbang = 1

if !has('popupwin')
  echohl WarningMsg
  echom 'modbang.vim: Requires +popupwin support'
  echohl None
  finish
endif

augroup Modbang
  autocmd!

  autocmd CmdlineEnter * call modbang#_on_cmdline_enter()
  autocmd CmdlineLeave * call modbang#_on_cmdline_leave()
  autocmd CmdlineChanged * call modbang#_on_cmdline_changed()
augroup END
