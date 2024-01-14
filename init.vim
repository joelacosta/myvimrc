set noswapfile
set showcmd
set number
set relativenumber 
set scrolloff=7
":set path+=**
set wildmenu
let g:netrw_banner=0
let g:netwr_browse_split=0

nmap <silent> <space>q 12:Lexplore<CR>:let g:netrw_browse_split=0<CR>
nmap <silent> <space>e :Rexplore<CR>:let g:netrw_browse_split=0<CR>
nmap <silent> <space>t :Texplore<CR>:let g:netrw_browse_Split=0<CR>


call plug#begin()
Plug 'karoliskoncevicius/vim-sendtowindow'
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon' ,{'branch':'harpoon2'}
call plug#end()

"set nosplitbelow
set splitbelow splitright
set noswapfile

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>


map <Leader>tp :new term://cmd<CR>ipython3<CR><C-\><C-n><C-w>L<C-w>h
map <Leader>r ggVG<space>l<C-w><C-l>i<CR><C-\><C-n><C-w>h
map <Leader>c {V}<space>l<C-w><C-l>i<CR><C-\><C-n><C-w>h
map <Leader>v V<space>l<C-w><C-l>i<CR><C-\><C-n><C-w>h
tmap <Esc> <C-\><C-n>

map <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
map <Leader>fa :lua require("harpoon.mark").add_file()<CR>
":lua require("harpoon.ui").nav_next()                   -- navigates to next mark
":lua require("harpoon.ui").nav_prev()                   -- navigates to previous mark
":lua require("harpoon.ui").nav_file(3)                  -- navigates to file 3

colorscheme gruvbox
syntax on

