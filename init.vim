" Plugins
" Installs Plug for neovim:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'dyng/ctrlsf.vim'
Plug 'janko/vim-test'
Plug 'sheerun/vim-polyglot' " Going to try this for now
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'ap/vim-css-color'
Plug 'godlygeek/tabular'
Plug 'iCyMind/NeoSolarized'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Need to get this working
" Plug 'ryanoasis/vim-devicons'

" Airline, Tmuxline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

call plug#end()

let mapleader = "\<Space>"

set backspace=indent,eol,start
set wildmenu
set modifiable          " lets current buffer be changed, helps with nerdtree set nojoinspaces  " Use one space, not two, after punctuation.
set nobackup
set nowrap
set number              " show line number
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set splitbelow          " Open new split panes to right and bottom, which feels more natural
set splitright
set visualbell

if has('clipboard')
  set clipboard=unnamed,unnamedplus " make copied text available to the OS' clipboard
endif

" Use Ag over Grep
if executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m

  augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
  augroup END
endif

" Tabs and spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType java setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType make set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

syntax on
filetype plugin indent on
autocmd BufNewFile,BufRead *.env.* set syntax=sh

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Terminal stuff
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" Source and edit vimrc.
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>se :sp $MYVIMRC<cr>

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END



" Plugin Settings ======================================================

" Added following to zshrc to respect gitignore by using ag for FZF
" export FZF_DEFAULT_COMMAND="ag -l --nocolor --hidden --ignore /.git/"
nnoremap <silent> <c-p> :Files<cr>

" nerdtree settings
" when opening NERDTree always find file i'm currently on first
" map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" let g:test#strategy = "neovim"
let g:test#strategy = "vtr"
let g:test#preserve_screen = 1

let g:VtrOrientation = "h"
let g:VtrPercentage = 35
let g:VtrUseVtrMaps = 1
let g:VtrClearBeforeSend = 0

" Ale settings
" let g:ale_linter_aliases = {'javascript': ['css', 'javascript']}
" let g:ale_linters = {
" \   'javascript': ['eslint', 'stylelint'],
" \   'ruby': ['ruby', 'rubocop'],
" \   'sh': ['shellcheck'],
" \}

" let g:ale_fixers = {
" \   'ruby': ['rubocop'],
" \   'javascript': ['eslint'],
" \   'typescriptreact': ['eslint'],
" \}
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let g:ale_fixers = {'jsx': ['eslint'], 'javascript': ['eslint']}

" let g:ale_open_list = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ruby_indent_assignment_style = 'variable'

" https://github.com/sonph/onehalf/blob/master/vim/README.md
set t_Co=256
set cursorline
colorscheme NeoSolarized
set background=light

if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux' )	
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"	
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"	
    set termguicolors	
endif

" air-line/tmux-line settings
" let g:airline_theme='onehalflight'
" let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:tmuxline_powerline_separators = 0

" CtrlSF mappings
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>


" Tabular
" AddTabularPattern semi /\S\+;
vmap <Leader>t; :Tab /\S\+;<CR>

map <Leader>bp orequire'pry';binding.pry<esc>:w<cr>
map <Leader>bb orequire'byebug';byebug<esc>:w<cr>
