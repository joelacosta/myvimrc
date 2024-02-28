"probar con :global/Error/print
" :%s/Error//gne
function! ReadTerm()
  execute win_id2win(t:terminal_windows_id) "wincmd w"
  normal! G
  let t:errores = search("Error",'bcnW')
  wincmd p
  echom t:errores
endfunction


function! ReadTerm2()
  let t:line_new = getcurpos(t:terminal_windows_id)[1]
if t:terminal_line == t:line_new
   let t:terminal_line = t:line_new
   return 'fallo'
else
  let t:terminal_line = t:line_new
  let buf = nvim_create_buf(v:false,v:true)
  execute win_id2win(t:terminal_windows_id) "wincmd w"
  let @e = execute("globa/Error/print")
  wincmd p 
  let width = winwidth(t:terminal_windows_id)
  let height= winheight(t:terminal_windows_id)
  let fila = win_screenpos(t:terminal_windows_id)[0]
  let columna= win_screenpos(t:terminal_windows_id)[1]
  let opts = {'relative': 'win',
                \ 'win': t:terminal_windows_id,
                \ 'width': width-20,
                \ 'height': 5,
                \ 'col': columna,
                \ 'row': fila,
                \ 'style': 'minimal',
                \ 'border': 'single',
                \ }
  let win = nvim_open_win(buf,v:true,opts)
  call nvim_win_set_option(win,'winhl','Normal:LineNr')
  let closingKeys = ['<Esc>', '<CR>', '<Space>']
  for closingKey in closingKeys
    call nvim_buf_set_keymap(buf, 'n', closingKey, ':close<CR>', {'silent': v:true, 'nowait': v:true, 'noremap': v:true})
  endfor
  normal! "ep
endif
endfunction

autocmd CursorMoved * call ReadTerm2()
"autocmd CursorMoved * :echom getcurpos()
"autocmd CursorMovedI * :echom getcurpos()
":h dictwatcheradd()*

