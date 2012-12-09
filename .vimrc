" @(#)Vimrc 2.0 Steve Parker Mon Sep 12, 2011
set nocompatible   		     	" Use Vim defaults (much better!)
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
"
" or <-lines/register '-prev-files-marks, /-searches, :-command-lines, @-input-lines???
" c-vim-info-encoding, f-marks
"
set viminfo='128,f1			" read/write a .viminfo file, don't store more
								" than 50 lines of registers
set history=1024          		" keep XX lines of command line history
set ht=4						" horizontal tab set at 8
set ts=4						" tab stop at 8
set mps=(:),{:},[:],<:>			" match pairs for % command
set noslowopen
set hidden						" Hide other buffers instead of abandoning them.
set number						" display line numbers

syntax on						" turn on syntax detection
filetype on           			" Enable filetype detection
filetype indent on    			" Enable filetype-specific indenting
filetype plugin on    			" Enable filetype-specific plugins

set report=2					" report yanks/deletes of 2 or more lines
set showcmd						" Status bar stuff.
set showmode					" show current mode
set ruler      		         	" show the cursor position all the time

set hlsearch					" highlighted searching
set incsearch					" incremental searching
set ignorecase					" usually ignore case when searching
set smartcase					" unless I explicitly use an UPPER CASE character

set autoindent					" autoindent by default
nnoremap << :set noautoindent<Cr>:filetype indent off<Cr>
nnoremap >> :set   autoindent<Cr>:filetype indent on<Cr>

if has("autocmd")
  " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif


" Colorscheme stuff
colorscheme vibrantink
set background=dark
nnoremap =0 :set background=dark<Cr>
nnoremap =1 :set background=light<Cr>
nnoremap =- :colorscheme default<Cr>
nnoremap == :colorscheme vibrantink<Cr>
nnoremap =_ :colorscheme wombat<Cr>
nnoremap =+ :colorscheme tibet<Cr>

nnoremap q :q!|
" nnoremap v ~
nnoremap =.. :!swc sync<Cr>
nnoremap =} !} perl -pe 's///g;'
nnoremap =% !% perl -pe 's///g;'
nnoremap =3 !G rot13
nnoremap => !} crk '^(.)' '\t$1'<Cr>
" edit alternate file.
nnoremap =b :e#<Cr>
" nnoremap =c !} cut -c
" nnoremap =f !} fmt -c -78
" nnoremap =F !} fold -
" nnoremap =g !2} glue -b
" nnoremap =G !G glue -b
"" add '> ' to beginning of rest of the lines in the buffer
" nnoremap =n :.,$ s/^> >/>> /<Cr>

" template stuff for HTML(h), make(m), perl(p), tcsh(t) and python(y)
" lowercase character prompts to read in a template
" uppercase character prompts to read in a directory listing
nnoremap =# :set number!<Cr>
nnoremap =? :help<Cr>:only<Cr>
nnoremap =h :r ~/etc/htmllib/
nnoremap =H :r! ls -C ~/etc/htmllib/
nnoremap =m :r ~/etc/makelib/
nnoremap =M :r! ls -C ~/etc/makelib/
nnoremap =p :r ~/etc/perllib/
nnoremap =P :r! ls -C ~/etc/perllib/
nnoremap =t :r ~/etc/tcshlib/
nnoremap =T :r! ls -C ~/etc/tcshlib/
nnoremap =y :r ~/etc/pylib/
nnoremap =Y :r! ls -C ~/etc/pylib/

nnoremap =f f{f(f[f<zf%
"nnoremap =F 

nnoremap =u 1G!Gdos2unix<Cr>
nnoremap =d 1G!Gunix2dos<Cr>

nnoremap =q !}crk QQQ '\o'<Cr>
nnoremap =Q !Gcrk QQQ '\o'<Cr>
nnoremap =r !Gcrk '^(\s*)\d+' '\1\o'<Cr>

"nnoremap =s !} sort -t, +1<Cr>
"nnoremap =S !} sort -n

" url_decode
nnoremap =U !} perl -pe "tr/+/ /; s/\%([a-fA-F0-9][a-fA-F0-9])/pack('C', hex($1))/eg;"


nnoremap =x :e!
nnoremap =X :.!sh
nnoremap =w :w!

nnoremap =<C-A> :%s/|
nnoremap =<C-K> i <Esc>|
nnoremap =<C-O> :. s/|
nnoremap =<C-P> :1,. s/|
nnoremap =<C-R> :.,$ s/|
nnoremap =<C-W> :w<Cr>
nnoremap =<C-N> :n<Cr>
nnoremap =<C-T> xp

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

" Map ^L to do what it does, but also clear search highlighting.
nnoremap <C-L> :nohlsearch<CR><C-L>

" Shortcut for :bnext and :bprevious.
nnoremap <A-Left> :bprevious<CR>
nnoremap <A-Right> :bnext<CR>

let g:snipMate = {}
let g:snipMate.scope_aliases = {} 
let g:snipMate.scope_aliases['html'] = 'html,tt'

"augroup filetype
"        autocmd BufNewFile,BufRead ~/MantaDev/*.html set filetype=tt
"augroup END
