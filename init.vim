set number
set relativenumber 
set scrolloff=7

call plug#begin()
Plug 'karoliskoncevicius/vim-sendtowindow'
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon' ,{'branch':'harpoon2'}
call plug#end()

set splitbelow splitright

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

map <Leader>tp :new term://cmd<CR>ipython3<CR><C-\><C-n><C-w>k

map <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
map <Leader>fa :lua require("harpoon.mark").add_file()<CR>
":lua require("harpoon.ui").nav_next()                   -- navigates to next mark
":lua require("harpoon.ui").nav_prev()                   -- navigates to previous mark
":lua require("harpoon.ui").nav_file(3)                  -- navigates to file 3

colorscheme gruvbox
syntax on

