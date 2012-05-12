" My vimrc
" Based on @padenot and @paulrouget vimrc's,
" http://nvie.com/posts/how-i-boosted-my-vim/
" martius@martiusweb.net

""" Preamble
" not compatible with vi
set nocp
" pathogen plugins loader
call pathogen#infect()
" See install.sh and submodules to know which plugins I use

""" Customizables settings
let mapleader = ","
let maplocalleader = "!"

" Things I write all the time
iabbrev m@ martius@martiusweb.net
iabbrev j@ martin@jolitv.com

" Typos I do all the time
iabbrev whiel while
iabbrev tehn then

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
" Ctrl+space for functions autocompletion
inoremap <c-space> <c-x><c-o>
" F2 to display my cheat sheet
noremap <f2> :help mts-cheat<cr>
inoremap <f2> :help mts-cheat<cr>
" F5 display Gundo
nnoremap <f5> :GundoToggle<cr>
" Toggle invisible characters
noremap <leader>pi :set list!<cr>
inoremap <leader>pi :set list!<cr>
" New tab 
noremap gN :tabnew<cr>

""" Operator-pending mappings
" between parentheses (try dp between parentheses)
onoremap p i(

""" Commands
" w!! forces sudo mode, useful when I forgot to sudo while configuring
" something
cmap w!! w !sudo tee % >/dev/null

""" Ban bad habits 
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

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
autocmd GuiEnter * set t_vb=
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
" Pressing F3 will disable smart indentation, useful when using terminal pasting
set pastetoggle=<f3>
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
" Use tabs, not spaces, A tab is displayed as a 2 spaces
set noexpandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0
set copyindent
set preserveindent
" vim magic line :set noet ci pi sts=0 sw=2 ts=2
" Autoindentation
set autoindent
set smartindent

""" File pattern matching
set wildignore=*.swp,*.back
" Use wildmenu
set wildmenu
" Complete until longest common string, then list matching in a one-line menu
set wildmode=longest:full

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1

""" Filetype specific configuration 
filetype plugin indent on
augroup filetypedetect
  " Detect custom filetypes
  autocmd BufNewFile,BufRead *.rst set syntax=rest
  autocmd BufRead,BufNewFile *.sjs set ft=javascript

  " Display tabs & spaces at the begining of the line (indent-guides plugin)
  autocmd FileType * IndentGuidesEnable
  let g:indent_guides_guide_size = 2
	" auto_colors does not work with my colorschemes...
	" let g:indent_guides_auto_colors = 1
	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey30 ctermbg=darkgrey
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=grey40 ctermbg=lightgrey

  " Disable smart indentation with text files
  autocmd BufNewFile,BufRead {*.tex,*.md,*.mdwn,*.markdown,*.txt} set noautoindent

  "	Respect PEP8 while editing python
  autocmd FileType python  set tabstop=4 textwidth=79

  " When using make, we shouldn't expand tabs.
  autocmd FileType make set noexpandtab

	" for loop with i as index in Javascript,c,cpp
	autocmd FileType javascript,c,cpp :iabbrev <buffer> fori for(i = 0; i < ; ++i)<left><left><left><left><left><left>

	" Autocomplete for filetypes I deal with for current projects
	" (I sometimes miss c/cpp)
	autocmd FileType python set omnifunc=pythoncomplete#Complete
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
	autocmd FileType php set omnifunc=phpcomplete#CompletePHP
	" Hide autocomplete tip window when I do something in insert mode (or
	" I leave it)
	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif

	" Don't fold by default
	autocmd Syntax python,javascript,html,css,xml,php setlocal foldmethod=syntax
	autocmd Syntax python,javascript,html,css,xml,php normal zR 
	
	""" PHP stuff
	" abbreviations and typos
	autocmd FileType php :iabbrev <buffer> fori for($i = 0; $i < ; ++$i)<left><left><left><left><left><left><left>
	autocmd FileType php :iabbrev <buffer> <?= <?php echo; ?><left><left><left><left>
	"autocmd FileType php :iabbrev <buffer> <?__ <?php echo __(); ?><left><left><left><left><left>
	" highlight sql and html
	let php_sql_query=1
	let php_htmlInStrings=1

	""" Jekkyll
	" Highlight YAML preambles in Jekyll posts
	autocmd BufNewFile,BufRead */_posts/*.textile,*/_posts/*.mdwn syntax match Comment /\%^---\_.\{-}---$/
	" Highlight code blocks in Jekyll posts
	autocmd BufNewFile,BufRead */_posts/*.textile,*/_posts/*.mdwn syntax region Comment start=/^{% highlight .* %}$/ end=/{% endhighlight %}/

augroup END
