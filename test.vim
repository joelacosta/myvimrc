"probar con :global/Error/print
" :%s/Error//gne
"let timer = timer_start(1000, 'ReadTerm',{'repeat':-1})
"execute(":sign define error text=>> texthl=WarningMsg")

function! ReadTerm()
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

"autocmd CursorMoved * call ReadTerm2()
"autocmd CursorMoved * :echom getcurpos()
"autocmd CursorMovedI * :echom getcurpos()
":h dictwatcheradd()*

function! Test(timer)
  echom "iniciando"
  let hasta = nvim_buf_line_count(t:terminal_bufer_number) 
  let t:lines = nvim_buf_get_lines(t:terminal_bufer_number,t:terminal_last_line, hasta,0) 
  let s = 0
  for line in t:lines
    let s = s + 1
    if line =~ 'Error'
       call sign_place(0,'','error',t:terminal_bufer_number,{'lnum':t:terminal_last_line + s})
    endif
  endfor
  if t:lines[-1]=='>>>'
    echom "FIN"
    call timer_pause(t:timer,1)
    setlocal winbar ='frenado'
  endif
endfunction

function! GuardarUltimaLinea()
  let t:terminal_last_line = line('.',t:terminal_windows_id)
  echom t:terminal_last_line
  call timer_pause(t:timer,0)
  setlocal winbar='buscando'
endfunction

function! AbrirTerminal()
  execute "vnew term://cmd"
  let t:timer = timer_start(1000, 'Test',{'repeat':-1})
  call timer_pause(t:timer,1)
  "execute 'autocmd TermLeave <buffer> call GuardarUltimaLinea()'
  "execute 'autocmd TermLeave <buffer> normal! G'
  execute 'tnoremap <silent> <CR> <C-\><C-n>:call GuardarUltimaLinea()<CR>i<CR>'
  execute "sign define error text=>> texthl=WarningMsg"
  let t:terminal_windows_id = win_getid()
  let t:terminal_id = b:terminal_job_id
  let t:terminal_bufer_number = bufnr()
  "setlocal nonumber
  setlocal norelativenumber
  "setlocal signcolumn=yes:1
  "setlocal statuscolumn=%(%#LineNr#%s%)
  execute chansend(t:terminal_id,'python')
  execute chansend(t:terminal_id,"\r")
  let t:terminal_last_line=0
  let t:terminal_new_line=0
  wincmd p
endfunction

