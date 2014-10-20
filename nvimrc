" ----------------------------------------------------------------------------
" Lean 'n' Clean Neovim Config
" ----------------------------------------------------------------------------

set nocompatible " Be IMproved

call plug#begin()

" ----------------------------------------------------------------------------
" Basic configuration
" ----------------------------------------------------------------------------

let g:vimDir = "~/.nvim"

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

set hlsearch " Highlight search
set incsearch " Highlight pattern matches as you type
set ignorecase " Ignore case when using a search pattern
set smartcase " Override 'ignorecase' when pattern has upper case character

" Set grep tool
if executable('ack')
	set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
	set grepformat=%f:%l:%c:%m
endif

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

call EnsureExists(vimDir.'~/.vim/.cache')
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

" Unite
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'

" All the color schemes in the world!
Plug 'daylerees/colour-schemes'






call plug#end()









" Finish tuning Vim
filetype plugin indent on
syntax on
