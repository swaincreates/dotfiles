let mapleader = "\<Space>"

set modifiable    " lets current buffer be changed, helps with nerdtree
set nojoinspaces  " Use one space, not two, after punctuation.
set nowrap
set number        " show line number  
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set splitbelow    " Open new split panes to right and bottom, which feels more natural
set splitright

" Tabs and spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType make set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

syntax on
filetype plugin indent on


" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Things I know I want:
" - Fuzzy finding ctrl-p
" - Ruby syntax and def complete
" - Javascript syntax and what not
" - Either tmux or good way to handle multiple terminals, possibly using tabs
"   for something like `rails s`
" X- Change Ctrl+w to just Ctrl for moving around

