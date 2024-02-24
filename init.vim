set noswapfile

set number
set relativenumber
set scrolloff=7
set list

"-------------------------------- VENTANAS ------------------------
set splitright splitbelow
let g:netrw_banner=0
let g:netrw_browse_Split=0

nmap <silent> <Space>t :Texplore<CR>
nmap <silent> <Space>e :Rexplore<CR>

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>


"-------------------------------- INTEGRACION CON PYTHON -----------
set path =,,C:/Users/JoelA/AppData/Local/Programs/Python/Python312/**
let g:python3_host_prog = 'C:/Users/JoelA/AppData/Local/Programs/Python/Python312/python.exe'

function! AbrirTerminal()
  execute "new term://cmd"
  let t:terminal_windows_id = win_getid()
  let t:terminal_id = b:terminal_job_id
  setlocal nonumber
  setlocal norelativenumber
  execute chansend(t:terminal_id,'python')
  execute chansend(t:terminal_id,"\r")
  wincmd p
endfunction

function! Correr()
  execute win_id2win(t:terminal_windows_id) "wincmd w"
  normal! "cgp
  call chansend(t:terminal_id,"\r")  
  call chansend(t:terminal_id,"\r")  
  wincmd p
endfunction

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
