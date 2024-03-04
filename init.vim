set noswapfile
set number
set relativenumber
set scrolloff=7
set list
"--------------------------------- TEMP
"-------------------------------- VENTANAS ------------------------
set splitright
let g:netrw_banner=0
let g:netrw_browse_Split=0

nmap <silent> <Space>t :Texplore<CR>
nmap <silent> <Space>e :Rexplore<CR>
nmap <silent> <Space>od :call AbrirDirectorio()<CR>

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>


"-------------------------------- INTEGRACION CON PYTHON -----------
set path =,,C:/Users/JoelA/AppData/Local/Programs/Python/Python312/**
let g:python3_host_prog = 'C:/Users/JoelA/AppData/Local/Programs/Python/Python312/python.exe'

tmap <Esc> <C-\><C-n>
nnoremap <silent> <leader>tp :call AbrirTerminal()<CR>
nnoremap <silent> <Leader>r ggVG"cy :call Correr()<CR>
nnoremap <silent> <Leader>c {V}"cy :call Correr()<CR>
nnoremap <silent> <Leader>v _v$"cy :call Correr()<CR>
"--------------------------------------------------------------------

"-------------------------- SATUS LINES----------------------------
set showtabline=2
set tabline=%!Tabline()
set winbar=%{%Winbar()%}

set laststatus=3
set cmdheight=1
set showcmd
set showcmdloc=statusline
set statusline=%(%#LineNr#cmd\ %S%)%=%=%15(%l\ [%L]\ %p%%%)
"--------------------PLUGINS-------------------------------------------
call plug#begin()
Plug 'morhetz/gruvbox'
call plug#end()
"---------------------------------------------------------------------

"------------------- COLORES------------------------------------------
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection=0
colorscheme gruvbox

nnoremap <A-j> :m+1<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+1<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+1<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

noremap <A-h> <<
vnoremap <A-h> <gv
vnoremap <A-l> >gv
noremap <A-l> >>

syntax on

"------------------------- FUNCIONES----------------------------
function! Winbar()
  let s = ""
  if &buftype==#""
    let s = " %(%#LineNr#[%L]%)%=%=%(%#LineNr#%m (%n) %f%)"
  elseif &buftype==#"help"
    let s = " %=%=%(%#LineNr# [Help] %f%)"
  else
    let s = "%=%(%#LineNr#%{&buftype}%)"
  endif
  return s
endfunction

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")
    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
    if bufmodified
      let s .= '[+] '
    endif
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction

function! BuscarErrores(timer) 
  call sign_unplace('g1',{'buffer':t:terminal_bufer_number})
  call sign_place(1,'g1','buscando',t:terminal_bufer_number,{'lnum':line('w$',t:terminal_windows_id)})
  let hasta = nvim_buf_line_count(t:terminal_bufer_number) 
  if hasta == t:terminal_last_line
    return ''
  endif
  let t:lines = nvim_buf_get_lines(t:terminal_bufer_number,t:terminal_last_line, hasta,0) 
  let s = 0
  for line in t:lines
    let s = s + 1
    if line =~ 'Error'
       call sign_place(0,'','error',t:terminal_bufer_number,{'lnum':t:terminal_last_line + s})
        call sign_unplace('g1',{'buffer':t:terminal_bufer_number})
        call sign_place(1,'g1','error',t:terminal_bufer_number,{'lnum':line('w$',t:terminal_windows_id)})
    endif
  endfor
  if t:lines[-1]=='>>>' || t:lines[-1] == '>>> '
    call timer_pause(t:timer,1)
    call sign_unplace('g1',{'buffer':t:terminal_bufer_number})
    call sign_place(1,'g1','finalizado',t:terminal_bufer_number,{'lnum':line('w$',t:terminal_windows_id)})
    echom 'PAUSADO'
  endif
endfunction

function! GuardarUltimaLinea()
  let t:terminal_last_line = line('.',t:terminal_windows_id)
  call timer_pause(t:timer,0)
endfunction

function SalirTab()
   if exists("t:timer")
	call timer_pause(t:timer,1)
   endif
endfunction

function EntrarTab()
   if exists("t:timer")
     call timer_pause(t:timer,0)
   endif
endfunction

autocmd TabLeave * call SalirTab()
autocmd TabEnter * call EntrarTab()

function! AbrirTerminal()
  execute "vnew term://cmd"
  highlight! link SignColumn LineNr
  let t:timer = timer_start(200, 'BuscarErrores',{'repeat':-1})
  call timer_pause(t:timer,1)
  execute 'autocmd WinClosed <buffer> call timer_stop(t:timer)'
  execute 'autocmd WinClosed <buffer> unlet t:timer'
  execute 'tnoremap <buffer><silent> <CR> <C-\><C-n>:call GuardarUltimaLinea()<CR>i<CR>'
  execute "sign define error text=>> texthl=WarningMsg"
  execute "sign define buscando text=>> texthl=ModeMsg"
  execute "sign define finalizado text=>> texthl=LineNr"
  let t:terminal_windows_id = win_getid()
  let t:terminal_id = b:terminal_job_id
  let t:terminal_bufer_number = bufnr()
  setlocal nonumber
  setlocal norelativenumber
  setlocal signcolumn=yes:1
  setlocal statuscolumn=%s\  
  execute chansend(t:terminal_id,'python')
  execute chansend(t:terminal_id,"\r")
  let t:terminal_last_line=0
  wincmd p
endfunction

function! Correr()
  execute win_id2win(t:terminal_windows_id) "wincmd w"
  execute GuardarUltimaLinea()
  normal! "cgp
  normal! G
  wincmd p
endfunction

function! AbrirDirectorio()
  if &buftype=='terminal'
    echom "No se puede abrir el directorio de una terminal"
  elseif has('win32')
    let path = substitute(expand('%:p:h'),'/','\\','g')
    if path != ""
      silent execute '!explorer.exe '.path
    else
      let path = substitute(b:netrw_curdir, '/','\\','g')
      silent execute '!explorer.exe '.path
    endif
  else
    echom "Joel solamente lo implemento para windows"
  endif
endfunction

