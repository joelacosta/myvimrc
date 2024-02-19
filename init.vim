set noswapfile
set showcmd
set splitright splitbelow
set noswapfile
set number
set relativenumber
set scrolloff=7
set list


set path =,,C:/Users/JoelA/AppData/Local/Programs/Python/Python312/**
set wildmenu
let g:netrw_banner=0
let g:netrw_browse_Split=0
let g:gruvbox_termcolors='256'
nmap <silent> <Space>t :Texplore<CR>
nmap <silent> <Space>e :Rexplore<CR>

let g:python3_host_prog = 'C:/Users/JoelA/AppData/Local/Programs/Python/Python312/python.exe'

call plug#begin()
Plug 'junegunn/fzf'
Plug 'karoliskoncevicius/vim-sendtowindow'
Plug 'morhetz/gruvbox'
"Plug 'vim-airline/vim-airline'
"Plug 'sainnhe/gruvbox-material'
"Plug 'davidhalter/jedi-vim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'ThePrimeagen/harpoon' ,{'branch':'harpoon2'}
call plug#end()

"------------------------------------------------------
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection=0
colorscheme gruvbox

set laststatus=3
set winbar=%=%m\ %f

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

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

map <Leader>tp :new term://cmd<CR>ipython<CR><C-\><C-n><C-w>L<C-w>h
map <Leader>r ggVG<space>l<C-w><C-l>i<CR><C-\><C-n><C-w>h
map <Leader>c {V}<space>l<C-w><C-l>i<CR><C-\><C-n><C-w>h
map <Leader>v _v$<space>l<C-w><C-l>i<CR><C-\><C-n><C-w>h
tmap <Esc> <C-\><C-n>

map <silent> <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
map <Leader>fa :lua require("harpoon.mark").add_file()<CR>
":lua require("harpoon.ui").nav_next()                   -- navigates to next mark
":lua require("harpoon.ui").nav_prev()                   -- navigates to previous mark
":lua require("harpoon.ui").nav_file(3)                  -- navigates to file 3

syntax on
