" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

" call plug#begin()

" ----------------------------------------------------------------------------
" Basic Vim Configuration
" ----------------------------------------------------------------------------

set mouse=a " Allow mouse usage
set mousehide

set history=1000 " Remember everything
set undolevels=1000

set encoding=utf-8 " Set right encoding and formats
set fileformat=unix
set nrformats-=octal

set spelllang=en_us,fr " Spell check english and french

set hidden " Deal nicely with buffers and switch without saving
set autowrite
set autoread

set modeline " Allow modeline for per file formating using
set modelines=5

set backspace=indent,eol,start " Makes backspace behave like most editors

set clipboard+=unnamedplus

set hlsearch   " Highlight search
set incsearch  " Highlight pattern matches as you type
set ignorecase " Ignore case when using a search pattern
set smartcase  " Override 'ignorecase' when pattern has upper case character


" ----------------------------------------------------------------------------
" Basic UI Configuration
" ----------------------------------------------------------------------------

set number       " Show line numbers
set showcmd      " Show last command
set lazyredraw   " Don't redraw when not needed
set laststatus=2 " Always show the status line
set scrolloff=10 " Keep cursor from reaching end of screen
set noshowmode   " Hide the mode on last line as we use Vim Airline

set cursorline " Highlight current line
autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorline

set autoindent " Auto indent line on CR
set smarttab   " Add tab and backspace like you'd like to
set shiftround " Always indent with a multiple of shiftwidth

set tabstop=4 " Default indentation is 4 spaces long and uses tabs, not spaces...
set softtabstop=4
set shiftwidth=4
set noexpandtab

set list " Show invisible characters

set linebreak " Show linebreaks
let &showbreak='↪ '

set showmatch " Hightlight brackets
set matchtime=2

set wildmenu           " Tab complete commands
set wildmode=list:full " Show full list of commands
set wildignorecase
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store

set splitbelow " Split windows below
set splitright " Split windows right

set noerrorbells " Turn of error notifications
set novisualbell

set nofoldenable " Disable folding
set background=dark


" ----------------------------------------------------------------------------
" Navigation Plugins
" ----------------------------------------------------------------------------

let g:netrw_winsize = -28             " absolute width of netrw window
let g:netrw_liststyle = 3             " tree-view
let g:netrw_sort_sequence = '[\/]$,*' " sort is affecting only: directories on the top, files below
let g:netrw_browse_split = 3          " open file in a new tab


" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

" Quick save
nnoremap <leader>w :w<cr>

" Add newline with return key
nmap <CR> o<Esc>

" Quicker ESC
inoremap jj <ESC>

" Save with sudo
cmap w!! %!sudo tee > /dev/null %

" Sort text
vmap <leader>ss :sort<cr>

" Remap arrow keys
nnoremap <down> :tabprev<CR>
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>

" Windows/Buffers motion keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>s <C-w>s
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>vsa :vert sba<cr>

" Change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

" Sane regex search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v

" Turn search highlight on and off
nnoremap <BS> :set hlsearch! hlsearch?<cr>

" Screen line scroll
nnoremap <silent> j gj
nnoremap <silent> k gk

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Toggles smart indenting while pasting, A.K.A lifesaver
set pastetoggle=<F3>

" Reselect last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

" Window killer
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>

" Quick buffer open
nnoremap gb :ls<cr>:e #

" Tab shortcuts
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>

" Spell check on/off
nmap <silent> <leader>sp :set spell!<CR>


" call plug#end()

" Finish tuning Vim
filetype plugin indent on
syntax on
