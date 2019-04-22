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
Plug 'zhaocai/GoldenView.Vim', {'on': '<Plug>ToggleGoldenViewAutoResize'}
Plug 'luochen1990/rainbow'
Plug 'thiagoalessio/rainbow_levels.vim'

" Vim Airline setup
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2

" GoldenView setup
let g:goldenview__enable_default_mapping=0
nmap <F4> <Plug>ToggleGoldenViewAutoResize

" Rainbow Parentheses setup
let g:rainbow_conf = {'ctermfgs': ['245', '142', '109', '175', '167', '208', '214', '223']}

" Rainbow Levers setup
let g:rainbow_levels = [
			\{'ctermfg': 142, 'guifg': '#b8bb26'},
			\{'ctermfg': 108, 'guifg': '#8ec07c'},
			\{'ctermfg': 109, 'guifg': '#83a598'},
			\{'ctermfg': 175, 'guifg': '#d3869b'},
			\{'ctermfg': 167, 'guifg': '#fb4934'},
			\{'ctermfg': 208, 'guifg': '#fe8019'},
			\{'ctermfg': 214, 'guifg': '#fabd2f'},
			\{'ctermfg': 223, 'guifg': '#ebdbb2'},
			\{'ctermfg': 245, 'guifg': '#928374'}]


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

Plug 'editorconfig/editorconfig-vim'

Plug 'kristijanhusak/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

" Multiple cursors
function g:Multiple_cursors_before()
	call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
	call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

" Rainbow
let g:rainbow_active = 1

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Undotree setup
nnoremap <silent> <F5> :UndotreeToggle<CR>

" Comment strings
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" ----------------------------------------------------------------------------
" MARK: - Language Plugins
" ----------------------------------------------------------------------------

" Misc
Plug 'tpope/vim-endwise'

" Vim Polyglote
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown', 'c', 'cpp', 'h']

" C++
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c', 'h'] }

" Swift
Plug 'keith/swift.vim'

" YAML
Plug 'chase/vim-ansible-yaml'

" Markdown
autocmd BufRead,BufNewFile *.md,*.markdown setlocal filetype=pandoc.markdown " Automatically set filetype for Markdown files"
Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
Plug 'shime/vim-livedown', { 'for': ['markdown', 'pandoc.markdown', 'md'] }

" Pandoc setup
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#conceal#blacklist = ['block', 'codeblock_start', 'codeblock_delim']
let g:pandoc#syntax#conceal#cchar_overrides = {'li': '*'}
let g:pandoc#formatting#equalprg = "pandoc -t gfm --wrap=none"

" Livedown setup
let g:livedown_autorun = 0
let g:livedown_open = 1
let g:livedown_port = 1337
let g:livedown_browser = "chrome"
map <leader>gm :call LivedownPreview()<CR>


" ----------------------------------------------------------------------------
" Autocompletion & Snippets Plugins
" ----------------------------------------------------------------------------

Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer', 'for': ['cpp', 'c', 'h', 'ino']}

Plug 'SirVer/ultisnips'
Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'ladislas/vim-snippets'

" Deoplete setup
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()

autocmd FileType h,c,cpp let b:deoplete_disable_auto_complete = 1
autocmd FileType h,c,cpp call deoplete#custom#buffer_option('auto_complete', v:false)

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#mappings#manual_complete()

inoremap <silent><expr> <S-TAB>
			\ pumvisible() ? "\<C-p>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" YouCompleteMe setup
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '!!'

" CompleteParameter setup
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

" UltiSnips setup
let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
" let g:UltiSnipsSnippetsDir=plugDir.'/vim-snippets/UltiSnips'


" ----------------------------------------------------------------------------
" Denite Plugins
" ----------------------------------------------------------------------------

Plug 'Shougo/denite.nvim'
Plug 'Shougo/neoyank.vim'


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
" MARK: - Stop Loading Plugins
" ----------------------------------------------------------------------------

call plug#end()


" ----------------------------------------------------------------------------
" Misc setup
" ----------------------------------------------------------------------------

" When writing a buffer (no delay).
" call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
" call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
" call neomake#configure#automake('nrwi', 500)

" ----------------------------------------------------------------------------
" denite setup
" ----------------------------------------------------------------------------

call denite#custom#option('default', 'prompt', '>')
call denite#custom#map(
			\ 'insert',
			\ '<C-j>',
			\ '<denite:move_to_next_line>',
			\ 'noremap'
			\)
call denite#custom#map(
			\ 'insert',
			\ '<C-k>',
			\ '<denite:move_to_previous_line>',
			\ 'noremap'
			\)


" Set denite leader
nmap <space> [denite]
nnoremap [denite] <nop>

" Set useful denite mappings
nnoremap <silent> [denite]y :<C-u>Denite neoyank -direction=dynamictop -buffer-name=yanks<cr>
nnoremap <silent> [denite]t :<C-u>Denite -direction=dynamictop -buffer-name=files file<cr>
nnoremap <silent> [denite]l :<C-u>Denite -direction=dynamictop -buffer-name=line line<cr>
nnoremap <silent> [denite]b :<C-u>Denite -direction=dynamictop -buffer-name=buffers buffer<cr>


" ----------------------------------------------------------------------------
" MARK: - Mappings
" ----------------------------------------------------------------------------

" Call basic functions
nmap <leader>f$ :call StripTrailingWhitespace()<CR>
nmap <leader>fef :call PreserveCursorPosition('normal gg=G')<CR>

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
" MARK: - End of Configuration
" ----------------------------------------------------------------------------

" Set color scheme
colorscheme gruvbox

" Finish tuning Vim
filetype plugin indent on
syntax on
