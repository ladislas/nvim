" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

set nocompatible " Be IMproved

call plug#begin()

" ----------------------------------------------------------------------------
" Basic Vim Configuration
" ----------------------------------------------------------------------------

let g:vimrcPath = $MYVIMRC
let g:vimPath = system('realpath '.g:vimrcPath)
let g:vimDir = fnamemodify(g:vimPath, ':h')
let g:plugDir = g:vimDir.'/plugged'

let mapleader = "," " Set mapleader
let g:mapleader = ","

set mouse=a " Allow mouse usage
set mousehide

set history=1000 " Remember everything
set undolevels=1000

set encoding=utf-8 " Set right encoding and formats
set fileformat=unix
set nrformats-=octal

set spelllang=en_us,fr " Spell check english and french

set hidden " Deal nicely with buffers and switch without saving
set autoread

set modeline " Allow modeline for per file formating using
set modelines=5

set backspace=indent,eol,start " Makes backspace behave like most editors

if has('nvim') " Activate clipboard for neovim
	set clipboard+=unnamedplus
endif

set hlsearch   " Highlight search
set incsearch  " Highlight pattern matches as you type
set ignorecase " Ignore case when using a search pattern
set smartcase  " Override 'ignorecase' when pattern has upper case character

" Set grep tool
if executable('ack')
	set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
	set grepformat=%f:%l:%c:%m
endif


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
"set listchars=tab:>-,trail:•,extends:❯,precedes:
set listchars=tab:\|-,trail:• ",eol:¶
"set listchars=tab:»·,trail:·

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
set t_vb=

set nofoldenable " Disable folding
set background=dark

" In case we run a GUI
if has('gui_running')
	set lines=999 columns=9999

	set guioptions+=t
	set guioptions-=T

	if has('gui_macvim')
		set gfn=Sauce\ Code\ Powerline\ Light:h12
		set transparency=2
	endif

	if has('gui_gtk')
		set gfn=Sauce\ Code\ Powerline\ Light:h12
	endif
else
	if $COLORTERM == 'gnome-terminal'
		set t_Co=256
	endif

	if $TERM_PROGRAM == 'iTerm.app'
		" different cursors for insert vs normal mode
		let &t_SI = "\<Esc>]50;CursorShape=1\x7"
		let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	endif
endif


" ----------------------------------------------------------------------------
" Unite Plugins
" ----------------------------------------------------------------------------

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'

" Unite setup
let g:unite_data_directory=g:vimDir.'/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

if executable('ack')
	let g:unite_source_grep_command='ack'
	let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
	let g:unite_source_grep_recursive_opt=''
endif

function! s:unite_settings()
	imap <buffer> <C-j>   <Plug>(unite_select_next_line)
	imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
	nmap <buffer> Q <plug>(unite_exit)
	nmap <buffer> <esc> <plug>(unite_exit)
	imap <buffer> <esc> <plug>(unite_exit)
endfunction

autocmd FileType unite call s:unite_settings()

" Set Unite leader
nmap <space> [unite]
nnoremap [unite] <nop>

" Set useful Unite mappings
nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=files file<cr>
nnoremap <silent> [unite]y :<C-u>Unite -auto-resize -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>


" ----------------------------------------------------------------------------
" Core Plugins
" ----------------------------------------------------------------------------

Plug 'bufkill.vim'
Plug 'mhinz/vim-startify', {'on': 'Startify'}
Plug 'duff/vim-bufonly'

" Vim Startify setup
let g:startify_session_dir = g:vimDir.'/.cache/sessions'
let g:startify_change_to_vcs_root = 1
let g:startify_show_sessions = 1
nnoremap <F1> :Startify<cr>


" ----------------------------------------------------------------------------
" UI Plugins
" ----------------------------------------------------------------------------

Plug 'bling/vim-airline'
Plug 'zhaocai/GoldenView.Vim', {'on': '<Plug>ToggleGoldenViewAutoResize'}
Plug 'oblitum/rainbow'

" Vim Airline setup
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='¦'

" GoldenView setup
let g:goldenview__enable_default_mapping=0
nmap <F4> <Plug>ToggleGoldenViewAutoResize

" Rainbow setup
au FileType c,cpp,objc,objcpp,python,javascript call rainbow#load()


" ----------------------------------------------------------------------------
" Autocompletion & Snippets Plugins
" ----------------------------------------------------------------------------

" if has('nvim')
" 	runtime! python_setup.vim
" endif

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
Plug 'SirVer/ultisnips'
Plug 'ladislas/vim-snippets'

" YouCompleteMe setup
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist={'unite': 1}
let g:ycm_min_num_of_chars_for_completion = 1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" UltiSnips setup
let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsSnippetsDir=plugDir.'/vim-snippets/UltiSnips'


" ----------------------------------------------------------------------------
" Navigation Plugins
" ----------------------------------------------------------------------------

Plug 'mileszs/ack.vim'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle','NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin' ", {'on': ['<Plug>NERDTreeToggle','<Plug>NERDTreeFind']}

" Undotree setup
let g:undotree_WindowLayout='botright'
let g:undotree_SetFocusWhenToggle=1
nnoremap <silent> <F5> :UndotreeToggle<CR>

" NERDTree setup
let NERDTreeShowHidden=0
let NERDTreeQuitOnOpen=0
let g:NERDTreeUseSimpleIndicator=1
let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=0
let NERDTreeIgnore=['\.hg', '.DS_Store']
let NERDTreeBookmarksFile=expand(g:vimDir.'/.cache/NERDTree/NERDTreeBookmarks')
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>


" ----------------------------------------------------------------------------
" Editing Plugins
" ----------------------------------------------------------------------------

Plug 'editorconfig/editorconfig-vim'
Plug 'kristijanhusak/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'

Plug 'chrisbra/NrrwRgn'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

Plug 'godlygeek/tabular'

" Tabularize setup
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>


" ----------------------------------------------------------------------------
" Language Specific Plugins
" ----------------------------------------------------------------------------

" C++
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c', 'h'] }
Plug 'derekwyatt/vim-protodef', { 'for': ['cpp', 'c', 'h'] }
Plug 'derekwyatt/vim-fswitch', { 'for': ['cpp', 'c'] }

" Markdown
autocmd BufRead,BufNewFile *.md,*.markdown setlocal filetype=pandoc.markdown " Automatically set filetype for Markdown files"
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
Plug 'vim-pandoc/vim-pantondoc', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
Plug 'shime/vim-livedown', { 'for': ['markdown', 'pandoc.markdown', 'md'] }

" Python
Plug 'klen/python-mode', { 'for': ['python'] }

" Web
Plug 'othree/html5.vim', { 'for': ['html', 'html.handlebars'] }
Plug 'cakebaker/scss-syntax.vim', {'for': ['less', 'scss', 'sass']}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'mustache/vim-mustache-handlebars', {'for': 'html.handlebars'}
" Plug 'skammer/vim-css-color', {'for': ['less', 'scss', 'sass']}
" Plug 'PProvost/vim-markdown-jekyll', {'for': ['html', 'hbs']}

" Pandoc setup
let g:pandoc_use_conceal = 1
let g:pandoc_syntax_dont_use_conceal_for_rules = ['block', 'codeblock_start', 'codeblock_delim']
let g:pandoc_syntax_user_cchars = {'li': '*'}
let g:pantondoc_use_pandoc_markdown = 1
let g:pandoc#formatting#equalprg = "pandoc -t markdown --no-wrap --atx-headers"

" Livedown setup
let g:livedown_autorun = 0
let g:livedown_open = 1
let g:livedown_port = 1337
map <leader>gm :call LivedownPreview()<CR>

" ----------------------------------------------------------------------------
" Text Object Plugins
" ----------------------------------------------------------------------------

" n/a


" ----------------------------------------------------------------------------
" Colors Themes
" ----------------------------------------------------------------------------

" Plug 'daylerees/colour-schemes'
Plug 'morhetz/gruvbox'
Plug 'effkay/argonaut.vim'

" Gruvbox setup
let g:gruvbox_bold = 0
if !has("gui_running")
	let g:gruvbox_italic = 0
endif


" ----------------------------------------------------------------------------
" Source Cotrol Management Plugins
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
" Basic useful functions
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

function! EnsureExists(path)
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path), 'p')
	endif
endfunction

function! CloseWindowOrKillBuffer()
	let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

	" never bdelete a nerd tree
	if matchstr(expand("%"), 'NERD') == 'NERD'
		wincmd c
		return
	endif

	if number_of_windows_to_this_buffer > 1
		wincmd c
	else
		bdelete
	endif
endfunction


" ----------------------------------------------------------------------------
" Basic Backup
" ----------------------------------------------------------------------------

if exists('+undofile') " Nice persistent undos
	set undofile
	execute "set undodir=".g:vimDir."/.cache/undo"
endif

set backup " Keep backups
execute "set backupdir=".g:vimDir."/.cache/backup"

set swapfile " Keep swap files, can save your life"
execute "set directory=".g:vimDir."/.cache/swap"

call EnsureExists(g:vimDir.'/.cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)
call EnsureExists(g:vimDir.'/.cache/NERDTree/NERDTreeBookmarks')


" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

" Call basic functions
nmap <leader>f$ :call StripTrailingWhitespace()<CR>
nmap <leader>fef :call PreserveCursorPosition("normal gg=G")<CR>
vmap <leader>s :sort<cr>

" Quick save
nnoremap <leader>w :w<cr>

" Add newline with return key
nmap <CR> o<Esc>

" Remap arrow keys
nnoremap <down> :tabprev<CR>
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>

" Windows/Buffers motion keys
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s
nnoremap <leader>vsa :vert sba<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-k> <up>
inoremap <C-j> <down>

if mapcheck('<space>/') == ''
	nnoremap <space>/ :vimgrep //gj **/*<left><left><left><left><left><left><left><left>
endif

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


call plug#end()

" Set colorscheme
colorscheme gruvbox

" Finish tuning Vim
filetype plugin indent on
syntax on
