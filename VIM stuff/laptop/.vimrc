" @(#)Vimrc 2.0 Steve Parker Mon Sep 12, 2011
set nocompatible        	" Use Vim defaults (much better!)
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set viminfo='20,\"50		" read/write a .viminfo file, don't store more
" than 50 lines of registers
set history=128          	" keep 50 lines of command line history
set ht=8			" horizontal tab set at 8
set ts=8			" tab stop at 8
set mps=(:),{:},[:],<:>		" match pairs for % command
set noslowopen
set hidden			" Hide other buffers instead of abandoning them.

syntax on			" turn on syntax detection
filetype on           		" Enable filetype detection
filetype indent on    		" Enable filetype-specific indenting
filetype plugin on    		" Enable filetype-specific plugins

set report=2			" report yanks/deletes of 2 or more lines
set showcmd			" Status bar stuff.
set showmode			" show current mode
set ruler               	" show the cursor position all the time

set hlsearch			" highlighted searching
set incsearch			" incremental searching
set ignorecase			" usually ignore case when searching
set smartcase			" unless I explicitly use an UPPER CASE character

set autoindent			" autoindent by default
map << :set noautoindent<Cr>	" map << to turn off autoindent
map >> :set   autoindent<Cr>	" map << to turn on  autoindent

" Colorscheme stuff
colorscheme default
map =0 :colorscheme default<Cr>
map =1 :colorscheme vibrantink<Cr>
set background=dark

nnoremap q :q!|					" Jane!  Get me out of this dang file!
" nnoremap v ~					" turn this off, now that I know visual mode is useful
nnoremap =; !} sed 's/
nnoremap =% !% sed 's/
nnoremap =3 !G rot13
nnoremap =b :e#<Cr>				" switch to edit alternate file
nnoremap =c !} cut -c
nnoremap =f !} fmt -c -78
nnoremap =F !} fold -
nnoremap =g !2} glue -b
nnoremap =G !G glue -b
nnoremap =i oif [ \( \) ] ; then<Cr>else<Cr>fi<Esc>
nnoremap => :.,$ s/^\(.\)/> \1/<Cr>''
nnoremap =n :.,$ s/^> >/>> /<Cr>

" template stuff for HTML(h), make(m), perl(p) and python(y)
" lowercase character prompts to read in a template
" uppercase character prompts to read in a directory listing
" perl -pe 's,/export/global/,~/,g'
nnoremap =h :r ~/etc/htmllib/
nnoremap =H :r! ls -C ~/etc/htmllib/
nnoremap =m :r ~/etc/makelib/
nnoremap =M :r! ls -C ~/etc/makelib/
nnoremap =p :r ~/etc/perllib/
nnoremap =P :r! ls -C ~/etc/perllib/
nnoremap =y :r ~/etc/pylib/
nnoremap =Y :r! ls -C ~/etc/pylib/

nnoremap =u 1G!Gdos2unix<Cr>			" filter file through dos2unix
nnoremap =d 1G!Gunix2dos<Cr>			" filter file through unix2dos

nnoremap =q !}crk QQQ '\o'<Cr>			" convert QQQ to occurance numbering in rest of paragraph
nnoremap =Q !Gcrk QQQ '\o'<Cr>			" convert QQQ to occurance numbering in rest of buffer
nnoremap =r !Gcrk '^(\s*)\d+' '\1\o'<Cr>	" renumber numbered lines, preserving leading white space

nnoremap =s !} sort -t, +1<Cr>			" sort rest of current paragraph
nnoremap =S !} sort -n				" sort rest of current paragraph numerically
nnoremap =x :e!					" start a fresh edit on current file
nnoremap =X :.!sh				" execute current line
nnoremap =w :w!					" WRITE current buffer

nnoremap =# :set number!<Cr>			" toggle on numbering 
nnoremap =<C-A> :%s/|				" prompt for a substitutaion on all lines of this buffer
nnoremap =<C-K> i <Esc>|			" quickly insert a single space
nnoremap =<C-O> :. s/|				" prompt for a substitutaion on (this one) current line only
nnoremap =<C-P> :1,. s/|			" prompt for a substitutaion on all previous lines
nnoremap =<C-R> :.,$ s/|			" prompt for a substitutaion on rest of lines
nnoremap =<C-W> :w<Cr>				" write this buffer out to its file
nnoremap =<C-N> :n<Cr>				" move to the next file in the queue
nnoremap =<C-T> xp				" transpose characters

" Backspace in Visual mode deletes selection.
vnoremap <BS> d
"
" Tab/Shift+Tab indent/unindent the highlighted
" block (and maintain the highlight after changing the indentation). Works for both Visual and
" Select modes.
"
vnoremap <Tab>	>gv
vnoremap <S-Tab> <gv

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
iab ev environment variable
iab oe ohio-state.edu
iab moe mps.ohio-state.edu
iab mos Microsoft operating systems
iab aoe acs.ohio-state.edu
iab choe chemistry.ohio-state.edu
iab chemsitry chemistry
iab direcotry directory
iab St3ve Steve

" Map ^L to do what it does, but also clear search highlighting.
nnoremap <C-L> :nohlsearch<CR><C-L>

" Shortcut for :bnext and :bprevious.
nnoremap <A-Left> :bprevious<CR>
nnoremap <A-Right> :bnext<CR>
