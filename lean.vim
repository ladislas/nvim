" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

call plug#begin()

" ----------------------------------------------------------------------------
" MARK: - Global Variables
" ----------------------------------------------------------------------------

let nvimDir  = '$HOME/.config/nvim'
let cacheDir = expand(nvimDir . '/.cache')


" ----------------------------------------------------------------------------
" MARK: - Basic Useful Functions
" ----------------------------------------------------------------------------

function! PreserveCursorPosition(command)
	" preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")

	" do the business:
	execute a:command

	" clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

function! StripTrailingWhitespace()
	call PreserveCursorPosition("%s/\\s\\+$//e")
endfunction

function! CreateAndExpand(path)
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path), 'p')
	endif

	return expand(a:path)
endfunction


" ----------------------------------------------------------------------------
" MARK: - Basic Vim Configuration
" ----------------------------------------------------------------------------

let mapleader = "," " Set mapleader
let g:mapleader = ","

set mouse=a " Allow mouse usage
set mousehide

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
" MARK: - Backup Configuration
" ----------------------------------------------------------------------------

set history=1000 " Remember everything
set undolevels=1000

" Nice persistent undos
let &undodir=CreateAndExpand(cacheDir . '/undo')
set undofile

" Keep backups
let &backupdir=CreateAndExpand(cacheDir . '/backup')
set backup

" Keep swap files, can save your life"
let &directory=CreateAndExpand(cacheDir . '/swap')
set swapfile


" ----------------------------------------------------------------------------
" MARK: - Basic UI Configuration
" ----------------------------------------------------------------------------

set number       " Show line numbers
set showcmd      " Show last command
set lazyredraw   " Don't redraw when not needed
set scrolloff=10 " Keep cursor from reaching end of screen
set laststatus=2 " Always show the status line
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
set listchars=tab:\|\ ,trail:•

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
" MARK: - Colors Themes
" ----------------------------------------------------------------------------

Plug 'morhetz/gruvbox'

" Gruvbox setup
let g:gruvbox_bold = 0


" ----------------------------------------------------------------------------
" MARK: - UI Plugins
" ----------------------------------------------------------------------------

Plug 'vim-airline/vim-airline'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'zhaocai/GoldenView.Vim', {'on': '<Plug>ToggleGoldenViewAutoResize'}

" Vim Airline setup
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2

" GoldenView setup
let g:goldenview__enable_default_mapping=0
nmap <F4> <Plug>ToggleGoldenViewAutoResize


" ----------------------------------------------------------------------------
" MARK: - Buffer Plugins
" ----------------------------------------------------------------------------

Plug 'duff/vim-bufonly'
Plug 'qpkorr/vim-bufkill'


" ----------------------------------------------------------------------------
" MARK: - Startup Plugins
" ----------------------------------------------------------------------------

Plug 'mhinz/vim-startify', {'on': 'Startify'}

" Vim Startify setup
let g:startify_session_dir = CreateAndExpand(cacheDir . '/sessions')
let g:startify_change_to_vcs_root = 1
let g:startify_show_sessions = 1
nnoremap <F1> :Startify<cr>


" ----------------------------------------------------------------------------
" MARK: - Editing Plugins
" ----------------------------------------------------------------------------

Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

" Undotree setup
nnoremap <silent> <F5> :UndotreeToggle<CR>


" ----------------------------------------------------------------------------
" MARK: - Navigation Plugins
" ----------------------------------------------------------------------------

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" NERDTree setup
let NERDTreeShowHidden=0
let NERDTreeQuitOnOpen=0
let g:NERDTreeUseSimpleIndicator=1
let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=0
let NERDTreeIgnore=['\.hg', '.DS_Store']
let g:NERDTreeBookmarksFile = CreateAndExpand(cacheDir . '/NERDTree/NERDTreeShowBookmarks')

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>


" ----------------------------------------------------------------------------
" Source Control Management Plugins
" ----------------------------------------------------------------------------

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Gitgutter setup
let g:gitgutter_realtime=0

" Fugitive setup
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gr :Gremove<CR>

autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
autocmd BufReadPost fugitive://* set bufhidden=delete


" ----------------------------------------------------------------------------
" MARK: - Mappings
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
set pastetoggle=<F6>

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


" ----------------------------------------------------------------------------
" End of Configuration
" ----------------------------------------------------------------------------

call plug#end()

" Set color scheme
colorscheme gruvbox

" Finish tuning Vim
filetype plugin indent on
syntax on
