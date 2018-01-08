" vim-plug (https://github.com/junegunn/vim-plug) settings
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Define bundles via Github repos
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-run-interactive'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'itchyny/vim-haskell-indent'
Plug 'jgdavey/tslime.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'rakr/vim-one'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'Valloric/YouCompleteMe'
" http://stackoverflow.com/questions/31257793/ycm-client-support-sopyddll-and-ycm-core-sopyddll-not-detected-you-need
Plug 'trevordmiller/nova-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/tComment'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mattn/emmet-vim'

" Airline, Tmuxline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

call plug#end()

" Leader
let mapleader = "\<Space>"

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
" set relativenumber
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
" set guifont=Inconsolas:h15
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
set linespace=0

set modifiable " So I can add files with NerdTree
map <C-n> :NERDTreeToggle<CR>
map <leader>, :NERDTreeFind<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif


if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Ignore git files.. works when I get rid of the ag stuff
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor
let g:ctrlp_custom_ignore = '\v[\/]\.(DS_Storegit|hg|svn|optimized|compiled|node_modules|gems)$'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif


" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>

let g:rspec_runner = "os_x_iterm"
" let g:rspec_command = 'call Send_to_Tmux("spring rspec {spec}\n")'
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}
let g:syntastic_javascript_checkers=["eslint"]
" let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Tab complete for emmet, might get rid of this
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Color scheme
colorscheme solarized
" colorscheme nova
set background=light
" colorscheme Tomorrow-Night-Eighties
" colorscheme monokai
" colorscheme one
" set background=dark

" Check out some very minimal color:
" https://github.com/pbrisbin/vim-colors-off
" https://github.com/fxn/vim-monochrome

" Source (reload) your vimrc. Type space, s, o in sequence to trigger
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>se :sp $MYVIMRC<cr>

" Toggle paste mode
set pastetoggle=<f2>
autocmd InsertLeave * set nopaste " disable paste mode when leaving insert mode

if has('clipboard')
    set clipboard=unnamed,unnamedplus " make copied text available to the OS' clipboard
endif

" Dont open nerdtree when vim starts
let g:NERDTreeHijackNetrw=0

" JSX highlight on .js files
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

" air-line
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

" Move current line up 1 with a space
nmap <leader>mu kgJ :s/ \{2,}/ /g<cr>
nmap <leader>bu gJ :s/ \{2,}/ /g<cr>

" == Repeat last change on multiple lines ==
" What if we did a single modification on the first line of the above snippet
" appending ; at the end of the line with A;. We can repeat that command by
" selecting the lines 2-3 and running the dot command over visual selection
"  with   :'<,'> normal .

 nnoremap <leader>bp orequire "pry"; binding.pry<esc>
 nnoremap <leader>dbp :g/binding.pry/d<esc>

" FZF stuff
let g:fzf_files_options =
  \ '--color fg:240,bg:-1,hl:33,fg+:241,bg+:221,hl+:33 ' .
  \ '--color info:33,prompt:33,pointer:166,marker:166,spinner:33 ' .
  \ '--reverse ' .
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
nnoremap <C-p> :Files<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g "" --hidden'

nnoremap <leader>ga :Files app/<cr>
nnoremap <leader>gm :Files app/models/<cr>
nnoremap <leader>gv :Files app/views/<cr>
nnoremap <leader>gc :Files app/controllers/<cr>
nnoremap <leader>gy :Files app/assets/stylesheets/<cr>
nnoremap <leader>gj :Files app/assets/javascripts/<cr>
nnoremap <leader>gs :Files spec/<cr>
