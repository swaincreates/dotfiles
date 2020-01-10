" Plugins
" Installs Plug for neovim:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
call plug#begin(stdpath('data') . '/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'iCyMind/NeoSolarized' " Solarized with termguicolors
Plug 'janko/vim-test'
Plug 'sheerun/vim-polyglot' " Going to try this for now
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'

call plug#end()

let mapleader = "\<Space>"

set modifiable    " lets current buffer be changed, helps with nerdtree set nojoinspaces  " Use one space, not two, after punctuation.
set nobackup
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

" Terminal stuff
if has('nvim')
  " tmap <C-o> <C-\><C-n>
endif

" Source and edit vimrc.
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>se :sp $MYVIMRC<cr>
"
" Added following to zshrc to respect gitignore by using ag for FZF
" export FZF_DEFAULT_COMMAND="ag -l --nocolor --hidden --ignore /.git/"
nnoremap <silent> <c-p> :Files<cr>

" nerdtree settings
" when opening NERDTree always find file i'm currently on first
" map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeMinimalUI = 1

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

let g:test#strategy = "neovim"

" Color scheme that depends on plugin `Neosolarized`
colorscheme NeoSolarized
set termguicolors

