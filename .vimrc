" @(#)Vimrc 2.0 Steve Parker Mon Apr 13, 2015
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
if has('win32') || has('win64')
"    set runtimepath=path/to/home.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
    set runtimepath=$HOME/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim
else 
    set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-speeddating'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'Spaceghost/vim-matchit'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'tommcdo/vim-exchange'
Plugin 'vim-scripts/Align'
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ----------------------------------------------
set nocompatible   		     	" Use Vim defaults (much better!)
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
"
" or <-lines/register '-prev-files-marks, /-searches, :-command-lines, @-input-lines???
" c-vim-info-encoding, f-marks
"
" NOTE this may be useful: !'mcrk '(\S *)\t' '$1    '
" replaces (X____)\t  with $1 . _ x 4
"

map <C-n> :NERDTreeToggle<CR>

set t_Co=256

" read/write a .viminfo file, don't store more than 128 lines of registers
set viminfo='128,f1
set history=1024
set undolevels=1024
set wildignore=*.swp,*.bak,*.pyc,*.o
set visualbell
set noerrorbells

" horizontal tab set at 4 & tab stop at 4
"set ht=4
set autoindent
set copyindent
set shiftwidth=4
set tabstop=4
set smarttab
set backspace=indent,eol,start
set pastetoggle=<F2>
"set mouse=a
nnoremap << :set noautoindent<Cr>:filetype indent off<Cr>
nnoremap <p :set paste<Cr>
nnoremap >> :set   autoindent<Cr>:filetype indent on<Cr>
nnoremap >p :set nopaste<Cr>

" match pairs for % command
set mps=(:),{:},[:],<:>
set noslowopen

" Hide other buffers instead of abandoning them & display line numbers
set hidden

" Filetype/Syntax detection
" Enable syntax highlighting filetype detection, filetype-specific indenting & plugins
syntax on
filetype off
filetype indent on
filetype plugin on

" Appearance/Reporting/Status 
" report yanks/deletes of 2 or more lines & status bar stuff, current mode & ruler
set report=2
set showcmd	
set showmode
set ruler 

" Search stuff highlighted, incremental, usually ignore case unless I explicitly use an UPPER CASE character

set hlsearch
set incsearch
set ignorecase
set smartcase

if has("autocmd")
  " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif


" Colorscheme stuff
colorscheme tibet
set background=dark
nnoremap =0 :set background=dark<Cr>
nnoremap =1 :set background=light<Cr>
nnoremap =- :colorscheme default<Cr>
nnoremap == :colorscheme vibrantink<Cr>
nnoremap =_ :colorscheme wombat<Cr>
nnoremap =+ :colorscheme tibet<Cr>

nnoremap qq :q!|
" nnoremap v ~
nnoremap =.. :!swc --name comsite5 sync<Cr>
nnoremap =} !} perl -pe 's///g;'
nnoremap =% !% perl -pe 's///g;'
nnoremap =3 !G rot13
nnoremap => !} crk '^(.)' '\t$1'<Cr>
" edit alternate file.
nnoremap =b :e#<Cr>
" nnoremap =c !} cut -c
" nnoremap =g !2} glue -b
" nnoremap =G !G glue -b
" add '> ' to beginning of rest of the lines in the buffer

" nnoremap =n :.,$ s/^> >/>> /<Cr>

" template stuff for HTML(h), make(m), perl(p), tcsh(t) and python(y)
" lowercase character prompts to read in a template
" uppercase character prompts to read in a directory listing
nnoremap =# :set number!<Cr>
nnoremap =? :help<Cr>:only<Cr>
nnoremap =c :colorscheme 
nnoremap =C :r! ls -C ~/.vim/colors/
nnoremap =h :r ~/etc/htmllib/
nnoremap =H :r! ls -C ~/etc/htmllib/
nnoremap =m :r ~/etc/makelib/
nnoremap =M :r! ls -C ~/etc/makelib/
nnoremap =p :r ~/etc/perllib/
nnoremap =P :r! ls -C ~/etc/perllib/
nnoremap =t :r ~/etc/tcshlib/
nnoremap =T :r! ls -C ~/etc/tcshlib/
nnoremap =v :r ~/etc/vimlib/
nnoremap =V :r! ls -C ~/etc/vimlib/
nnoremap =y :r ~/etc/pylib/
nnoremap =Y :r! ls -C ~/etc/pylib/

nnoremap =f gqap
vnoremap =f gqp
" nnoremap =f !} fmt -c -78
" nnoremap =F !} fold -
"nnoremap =f f{f(f[f<zf%

"nnoremap =F 
nnoremap =u 1G!Gdos2unix<Cr>
nnoremap =d 1G!Gunix2dos<Cr>
nnoremap =q !}crk QQQ '\o'<Cr>              " number QQQ's rest of para
nnoremap =Q !Gcrk QQQ '\o'<Cr>              " number QQQ's rest of file
nnoremap =r !Gcrk '^(\s*)\d+' '\1\o'<Cr>
"nnoremap =s !} sort -t, +1<Cr>
"nnoremap =S !} sort -n
"URL_decode
nnoremap =U !} perl -pe "tr/+/ /; s/\%([a-fA-F0-9][a-fA-F0-9])/pack('C', hex($1))/eg;"
nnoremap =x :e!
nnoremap =X :.!sh
nnoremap =w :w!
"nnoremap =<C-A> :%s/|
"nnoremap =<C-K> i <Esc>|
"nnoremap =<C-O> :. s/|
"nnoremap =<C-P> :1,. s/|
"nnoremap =<C-R> :.,$ s/|
"nnoremap =<C-W> :w<Cr>
"nnoremap =<C-N> :n<Cr>
"nnoremap =<C-T> xp
" Backspace in Visual mode deletes selection.
vnoremap <BS> d
" Tab/Shift+Tab indent/unindent the highlighted
" block (and maintain the highlight after changing the indentation). Works for both Visual and
" Select modes.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Map ^L to do what it does, but also clear search highlighting.
nnoremap <C-L> :nohlsearch<CR><C-L>
" Shortcut for :bnext and :bprevious.
nnoremap <A-Left> :bprevious<CR>
nnoremap <A-Right> :bnext<CR>

" Example Maps
" Join all lines in a paragraph 
" nnoremap <S-F7> vipJ
" Format selected lines
" xnoremap Q gq

   :map [[ ?{<CR>w99[{
   :map ][ /}<CR>b99]}
   :map ]] j0[[%/{<CR>
   :map [] k$][%?}<CR>

" short cut abbreviations and common mispellings corrections
"iab oe ohio-state.edu
"iab moe mps.ohio-state.edu
"iab mos Microsoft operating systems
"iab aoe acs.ohio-state.edu
"iab choe chemistry.ohio-state.edu
iab ev environment variable
iab prodcut product
iab produtc product
iab resluts results
iab matna manta
iab chemsitry chemistry
iab direcotry directory
iab St3ve Steve

let g:snipMate = {}
let g:snipMate.scope_aliases = {} 
let g:snipMate.scope_aliases['html'] = 'html,tt'
