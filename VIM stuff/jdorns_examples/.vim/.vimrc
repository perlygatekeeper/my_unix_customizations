syntax enable
set nocompatible
set bs=2
set tabstop=4
set shiftwidth=4
let &ai=0
let &expandtab=1
set nowrap
set hlsearch
set incsearch
set noscrollbind
set ruler
set number
set mouse=a
set autoindent
set autoread
set shell=bash\ --login\ --rcfile\ ~/.vimbashrc
set showtabline=2

"ab :sw :%s/\s\+$//

" Allow F5 to sync syntax highlighting
noremap <F5> <Esc>:syntax sync fromstart<CR>
inoremap <F5> <Esc>:syntax sync fromstart<CR>i
noremap <F8> <C-w>gf
inoremap <F8> <Esc><C-w>gfi

" Allow Ctrl+Up/Down to move line with cursor
noremap <C-Down> ddp
noremap <C-Up> kddpk
inoremap <C-Down> <Esc>ddpi
inoremap <C-Up> <Esc>kddpki

" Ctrl+B makes current line blank (destructively)
inoremap <C-b> <Esc>ddO

" make <Home> point to first non-whitespace
" allow for <Home> double-tap to go to 0
map <Home> ^
imap <Home> <Esc>^i
map <Home><Home> 0
imap <Home><Home> <Esc>0i

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" spell check
" setlocal spell spelllang=en_us
colorscheme tiger256
" colorscheme vydark

augroup filetypedetect
augroup END

if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif

  autocmd Filetype *
  \ if exists('&ofu') && &ofu == "" |
  \   source $VIMRUNTIME/autoload/syntaxcomplete.vim |
  \ endif
  filetype indent off
  filetype plugin indent off
endif

" Allow for entry of a single character without entering insert mode
nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" Make search results appear in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"if &term =~ "xterm"
"    :silent !echo -ne "\033]12;white\007"
"    let &t_SI = "\033]12;black\007"
"    let &t_EI = "\033]12;white\007"
"    autocmd VimLeave * :!echo -ne "\033]12;black\007"
"endif

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

