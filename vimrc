" My vimrc
" Based on @padenot and @paulrouget vimrc's,
" http://nvie.com/posts/how-i-boosted-my-vim/
" martius@martiusweb.net

""" Preamble
" not compatible with vi
set nocp
" pathogen plugins loader
call pathogen#infect()

""" Customizables settings
let mapleader = ","
let maplocalleader = "!"

" Things I write all the time
iabbrev m@ martius@martiusweb.net
iabbrev j@ martin@jolitv.com

" Typos I do all the time
iabbrev whiel while

""" Cool mappings (for an azerty layout)
" move the current line down
nnoremap - ddp
" move the current line up
nnoremap è ddkP
" alias to ^
noremap H ^
" alias to $
noremap L $
" deletes current line in insert mode
inoremap <c-d> <esc>ddi
" (all modes) uppercase current word
noremap <c-u> viwUe
inoremap <c-u> <esc>viwUea
" disable highlight
nnoremap <silent> <leader>/ :nohlsearch<cr>
" open my vimrc in a new tab
nnoremap <leader>evim :tabnew $MYVIMRC<cr> 
" source my vimrc (reload the tab)
nnoremap <leader>svim :source $MYVIMRC<cr>
" Speak English (spellcheck)
noremap <leader>en :set spell! spelllang=en<cr>
" Speak French
noremap <leader>fr :set spell! spelllang=fr<cr>

""" Operator-pending mappings
" between parentheses (try dp between parentheses)
onoremap p i(

""" Ban bad habits 
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

""" Things to refactor
" for loop with i as index in Javascript
augroup javascript_file
	autocmd FileType javascript :iabbrev <buffer> fori for(i = 0; i < ; ++i)<left><left><left><left><left><left>
augroup END

""" Most basic options
" use the mouse
set mouse=a
" Show line numbers
set number
" Wrap lines
set wrap
" Hidden mode (keeps closed buffers in memory)
set hidden
" Seems to be a good idea to disable backups & swap files
" since files I open are not really big and RAM is cheap.
set nobackup
set noswapfile
" large history of commands and undo levels
set history=1000
set undolevels=1000
" Silent!
set visualbell
set noerrorbells

""" Look & feel
" colors
if &t_Co >= 256 || has("gui_running")
	 " all the file types
   colorscheme desertEx
	 " html files get a special one, helps to make a difference
	 autocmd filetype html,xml colorscheme anotherdark
endif
if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif
" Display cursor position
set ruler
" As in terminal in gui mode (disable all, except the icon in kde, copy visual
" to paste buffer)
set go=ipac
" set terminal title
set title
" fast refresh when available
set ttyfast
" Always display status line
set laststatus=2
" Fancy powerline symbols
let g:Powerline_symbols = 'fancy'
" Font I use
set guifont=Monaco\ for\ Powerline\ 10
" Redraw when needed
set lazyredraw

""" Search
" makes a search "very magic", ie special chars gets original regex meanings
" therefore, it becomes necessary to escape characters like {, *, etc.
nnoremap / /\v
vnoremap / /\v
" ignore case when searching, but only if search pattern is all lowercase
set ignorecase
set smartcase
" highlight search and automatically move to next matching string
set hlsearch
set incsearch
" Search loops at the end of the file
set wrapscan
" Remember: you can use <leader>/ to unhilight search results

""" Edition options
" display matching parenthese, bracket, etc
set showmatch
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Don't show invisble chars by default, but defines the way I want them to be displayed
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set nolist
" Unicode
set encoding=utf-8
" fileformats to try in order of preference
set fileformats="unix,dos,mac"
" Pressing F2 will disable smart indentation, useful when using terminal pasting
set pastetoggle=<F2>
" Always display about 4 lines before and after the current line
set scrolloff=4
" c-u and c-d makes a move of 5 lines
set scroll=5
" Persisent undo
set undofile
set undodir=~/.vim/undodir
" Use tilda as an operator
set tildeop
" Format options (comments continues on new lines, detect lists indentations,
" dont break a line after a one-letter word, try to break before)
set formatoptions+=on1

""" Identation (default behavior is still written to make it explicit)
" Use tabs, not spaces, A tab is displayed as a 2 spaces, but count as 4
set noexpandtab shiftwidth=2 tabstop=2
" Autoindentation
set autoindent
set smartindent

""" File pattern matching
set wildignore=*.swp,*.back
" Use wildmenu
set wildmenu
" Complete until longest common string, then list matching in a one-line menu
set wildmode=longest:full

""" Filetype specific configuration 
filetype plugin indent on
