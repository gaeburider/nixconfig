" INTRODUCTION {{{
" using Vim (at least) since 6. Mai 2014
set nocompatible
" }}}

" get variables os_fullname and os_shortname {{{
if has('win32')
    let os_shortname='nt'
    let os_fullname='win'
elseif has('macunix') " max is also unix -> check before linux/unix
    let os_shortname='posix'
    let os_fullname='mac'
elseif has('unix')
    let os_shortname='posix'
    let os_fullname='unix'
else
    echo "unknown operating system"
endif
" }}}

" LINE NUMBERS {{{
" show line numbers relative to the current line
set number
set relativenumber
" }}}

" UNDO, SWAP and BACKUP {{{
" persistent undo
set undofile
set undolevels=10000

" enable backup files
set backup
set writebackup

" store command history
set history=1000

if os_shortname is 'posix'
	set backupdir=$HOME/.nixconfig/vim/backup
	set directory=$HOME/.nixconfig/vim/swap
	set undodir=$HOME/.nixconfig/vim/undo
elseif os_shortname is 'nt'
	set backupdir=$VIM/backup
	set directory=$VIM/swap
	set undodir=$VIM/undo
else
	echo 'unknown os'
endif
" }}}

" INDENT {{{
" insert extra tab after c-like block/curly bracket
set smartindent
" tab width = 4 space characters
set softtabstop=4
set tabstop=4
set shiftwidth=4
" convert indent tabs to spaces
set expandtab
" }}}

" SEARCH {{{
" generally case insesitive, except when searching after uppercase letters
set ignorecase
set smartcase

" highlight search while typing (incsearch) and highlight all found matches (hlsearch)
set hlsearch
set incsearch
" }}}

" LINE WIDTH and WORD WRAPPING {{{
" disable word wrapping after 80 characters
set textwidth=0
" display as if word wrapping at the end of editor width (does not insert newline charactes)
set wrap linebreak nolist
" }}}

" ENCODING {{{
" save new files with unix new lines, doesn't do converting automatically
set fileformats=unix,dos,mac
" set encoding
set encoding=utf8
set fileencoding=utf8
" }}}

" AUTOCOMPLETION {{{
" TODO do googling
set completeopt=longest,menuone,preview
set wildmenu
set wildmode=list:longest,full
" }}}

" VARIA OPTIONS {{{
" automatically reload file if changed on filesystem
set autoread
" set backspace do expected behaviour
set backspace=indent,eol,start
" show already typed command characters of combo in the status line
set showcmd
" don't close buffers, just hide them when switching to new buffer (e.g with :e)
set hidden
" disable mouse
set mouse=
" when closing a parenthises, briefly jump to the opening and jump back (as a visual indicator)
set showmatch
" tell vim we're using a modern and fast terminal so it can redraw more smoothly
set ttyfast
" enable spell checking
set spell
" set folding to marker (three braces)
set foldmethod=marker
" start scrolling when we're x lines away from margins
" -> keep cursor if possible x lines over bottom / under top
" set sidescroll(off) not used since wrapping is enabled
set scrolloff=4
" show as much as possible of the last line (applies only if last line is wrapped, otherwise would show the entire line as @))
set display+=lastline
" }}}

" PLUGINS via vim-plug {{{

" autoinstall of vim-plug if not already installed {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'sickill/vim-monokai'
" better status bar (bottom)
Plug 'vim-airline/vim-airline'
" themes for airline
Plug 'vim-airline/vim-airline-themes'
" mark every occurence of a keyword with a lightmarker
Plug 't9md/vim-quickhl'
" advanced text objects
" e.g 'da,' to delete entry in csv, 'daa' to delete argument in function header
Plug 'wellle/targets.vim'
" fuzzy search finder
Plug 'ctrlpvim/ctrlp.vim'
" keybindings for surroundings
" e.g 'cs"<' inside "hello world" to change to <hello world>
Plug 'tpope/vim-surround'
" repeat surroundings with '.'
Plug 'tpope/vim-repeat'
" expand visual selection, hit '+' to increase, hit '-' to decrease
Plug 'terryma/vim-expand-region'
" true sublime multiple selections
Plug 'terryma/vim-multiple-cursors'
" sneaky movement
Plug 'cuviper/vim-sneak'
" fast comments
Plug 'tpope/vim-commentary'

call plug#end()
" }}}

" VISUALS colorschemes, highlighting, cursor and gui options {{{
" set colorscheme
" either uncommented for the default or 'monokai'
" coloscheme default 
" set airline theme
let g:airline_theme='luna'
" show airline even when there's only one file / no split (yet)
set laststatus=2
" highlight line where the cursor is currently
set cursorline
" show leading spaces / tabs and trailing spaces
set list
set list listchars=tab:\|\ ,trail:· 

if has('gui_running')
	" overwrite colorscheme for gvim because default looks awful
	colorscheme monokai
    " make gvim look/feel like terminal, no top-menu-list, terminal-like dialogs
    set guioptions=cm
	" maximize
	au GUIEnter * simalt ~x
	"change gui font, \ to escape space
	if os_shortname is 'posix'
		set guifont=CMU\ Typewriter\ Text\ Medium\ 10
	endif
	" set gvim language to english
	set langmenu=en_US
	let $LANG = 'en_US'
else
	highlight clear SpellBad
	highlight SpellBad cterm=underline " italic
endif
" }}}

" REMAPPINGS {{{
" move across visual (wrapped) lines
map j gj
map k gk
map <down> gj
map <up> gk

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy
map Y y$

" TODO all needed
let mapleader = "\<Space>"
nnoremap <Leader>e :Ex<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>W :bd<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" TODO controversials {{{
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:sneak#streak = 1
let g:surround_no_mappings = 1

    " surround plugin should use z as operator, thus sneak can use s
    " for every surround command use z instead of s
	nmap dz  <Plug>Dsurround
	nmap cz  <Plug>Csurround
	nmap yz  <Plug>Ysurround
	nmap yZ  <Plug>YSurround
	nmap yzz <Plug>Yssurround
	nmap yZz <Plug>YSsurround
	nmap yZZ <Plug>YSsurround
	xmap Z <Plug>VSurround
	xmap gZ  <Plug>VgSurround
    omap z <Plug>surround
    omap Z <Plug>Surround

 " 1-character enhanced 'f'
	nmap f <Plug>Sneak_f
	nmap F <Plug>Sneak_F
	" visual-mode
	xmap f <Plug>Sneak_f
	xmap F <Plug>Sneak_F
	" operator-pending-mode
	omap f <Plug>Sneak_f
	omap F <Plug>Sneak_F

	" 1-character enhanced 't'
	nmap t <Plug>Sneak_t
	nmap T <Plug>Sneak_T
	" visual-mode
	xmap t <Plug>Sneak_t
	xmap T <Plug>Sneak_T
	" operator-pending-mode
	omap t <Plug>Sneak_t
	omap T <Plug>Sneak_T

	omap s <Plug>Sneak_s
	omap S <Plug>Sneak_S

    " remap colors for Sneak_s
    " hi! SneakPluginTarget guifg=white guibg=blue ctermfg=black ctermbg=cyan
    " hi! SneakPluginScope guifg=white guibg=blue ctermfg=black ctermbg=cyan
    hi! SneakStreakTarget guifg=red guibg=darkgreen ctermfg=white ctermbg=darkgreen
    hi! SneakStreakMask guifg=white guibg=cyan ctermfg=green ctermbg=darkgreen

" }}}
" }}}

" VARIA COMMANDS {{{
if os_shortname is 'posix'
   " Allow saving of files as sudo when I forgot to start vim using elevated rights
   cmap w!! w !sudo tee > /dev/null %
endif
" }}}

" MISCELLANIOUS {{{

" Highlight TODO, FIXME, NOTE, etc.
" See http://legacy.python.org/dev/peps/pep-0350/#mnemonics for explanations
" copyright notes: copied from http://stackoverflow.com/a/6577688/2529745 on 2017-05-15
if has("autocmd")
    if v:version > 701
            autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|NOBUG\|RFE\|???\|!!!\|CAVEAT\|HACK\)')
            autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|FAQ\|SEE\|STAT\|RVD\)')
    endif
endif


" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" copyright notes: copied from neovim/runtime/vimrc_example.vim
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif

" }}}

" FILETYPES {{{
au BufRead,BufNewFile *.asciidoc.txt set syntax=asciidoc
" }}}
