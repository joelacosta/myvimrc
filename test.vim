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
  execute win_id2win(t:terminal_windows_id) "wincmd w"
  let t:error = execute("globa/Error/print")
  wincmd p
endfunction

