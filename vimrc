" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

set nocompatible " Be IMproved

call plug#begin()

" ----------------------------------------------------------------------------
" Basic Vim Configuration
" ----------------------------------------------------------------------------

let g:vimDir = expand('%:p:h')

let mapleader = "," " Set mapleader
let g:mapleader = ","

set mouse=a " Allow mouse usage
set mousehide

set history=1000 " Remember everything
set undolevels=1000

set encoding=utf-8 " Set right encoding and formats
set fileformat=unix
set nrformats-=octal

set hidden " Deal nicely with buffers and switch without saving
set autoread

set modeline " Allow modeline for per file formating using
set modelines=5

set backspace=indent,eol,start " Makes backspace behave like most editors

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
set noshowmode   " Hide the mode on last line as we use Vim Airline

set cursorline " Highlight current line
autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorline

set autoindent " Auto indent line on CR
set smarttab   " Add tab and backspace like you'd like to
set shiftround " Always indent with a multiple of shiftwidth

set tabstop=4 " Tabs are 4 spaces long and are tabs, not spaces...
set softtabstop=4
set shiftwidth=4
set noexpandtab

set list " Show invisible characters
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮

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

	if g:is_macvim
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
let g:unite_data_directory=vimDir.'/.cache/unite'
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
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>


" ----------------------------------------------------------------------------
" Core Plugins
" ----------------------------------------------------------------------------

Plug 'bufkill.vim'
Plug 'mhinz/vim-startify'

" Startify setup
let g:startify_session_dir = vimDir.'/.cache/sessions'
let g:startify_change_to_vcs_root = 1
let g:startify_show_sessions = 1
nnoremap <F1> :Startify<cr>


" ----------------------------------------------------------------------------
" UI Plugins
" ----------------------------------------------------------------------------

Plug 'bling/vim-airline'
Plug 'zhaocai/GoldenView.Vim', {'on': '<Plug>ToggleGoldenViewAutoResize'}
Plug 'oblitum/rainbow'

" Airline setup
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='¦'

" GoldenView setup
let g:goldenview__enable_default_mapping=0
nmap <F4> <Plug>ToggleGoldenViewAutoResize

" Rainbow setup
let g:rainbow_active = 1
au FileType h,c,cpp,objc,objcpp,go,python,ruby,javascript,java,vim call rainbow#load()


" ----------------------------------------------------------------------------
" Editing Plugins
" ----------------------------------------------------------------------------

Plug 'editorconfig/editorconfig-vim'


" ----------------------------------------------------------------------------
" Core Plugins
" ----------------------------------------------------------------------------


" ----------------------------------------------------------------------------
" Core Plugins
" ----------------------------------------------------------------------------


" ----------------------------------------------------------------------------
" Core Plugins
" ----------------------------------------------------------------------------


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
		call mkdir(expand(a:path))
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
	execute "set undodir=".vimDir."/.cache/undo"
endif

call EnsureExists(vimDir.'/.cache')
call EnsureExists(&undodir)


" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------


" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------
" All the color schemes in the world!
Plug 'daylerees/colour-schemes'






call plug#end()









" Finish tuning Vim
filetype plugin indent on
syntax on
