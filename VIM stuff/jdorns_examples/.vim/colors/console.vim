" [console.vim] XTerm-256color
"
" Maintainer:   Timothy Harewood <stuckpig@gmail.com>
" Last Change:  Date: 2011/06/13
" 

"
" ! TERM environment variable must = 'xterm-256color' !
"

"
" ## .vimrc ##
"
" ## Bindings: F9 To fix syntax highlighting errors - F12 to toggle search highlight ##
" nnoremap <F12> :nohl<CR>
" nnoremap <F9> :syntax sync fromstart<CR>
"
" syntax on
" colorscheme console 
" set ruler
" set number
" set nowrap
" set expandtab
" set autoindent
" set cursorline
" set nocompatible
" set ignorecase smartcase
" set t_Co=256
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4
" set backspace=2
" set hlsearch
"

"
" Color Palette
"
" Black         0
" Bright Blue   45
" Bright Green  154
" Bright Purple 177
" Dark Grey     233
" Dark Purple   98
" Grey          59
" Light Yellow  228
" Orange        214
" Pink          197
" Red           9
" White-ish     230
" Yellow        11
"

set background=dark
hi clear
syntax on
let colors_name="console"

hi Normal       ctermfg=230 
hi Cursor       ctermfg=0       ctermbg=0
hi MatchParen   ctermfg=0     ctermbg=11
hi VertSplit    ctermfg=233
hi Folded       ctermfg=228
hi FoldColumn   ctermfg=228
hi IncSearch    ctermfg=9
hi ModeMsg      ctermfg=82
hi MoreMsg      ctermfg=154
hi NonText      ctermfg=228
hi Question     ctermfg=228
hi Search       ctermfg=0       ctermbg=11      cterm=none
hi SpecialKey   ctermfg=154
hi StatusLine   ctermfg=228     ctermbg=233     cterm=none
hi StatusLineNC ctermfg=233     ctermbg=240
hi Title        ctermfg=154
hi Visual       ctermfg=230     ctermbg=197     cterm=none
hi WarningMsg   ctermfg=214
hi Comment      ctermfg=59
hi Constant     ctermfg=154
hi Identifier   ctermfg=177     cterm=none
hi Statement    ctermfg=45
hi PreProc      ctermfg=214
hi Type         ctermfg=98
hi Special      ctermfg=197     cterm=none
hi Ignore       ctermfg=45
hi Todo         ctermfg=0       ctermbg=197
hi Directory    ctermfg=154
hi ErrorMsg     ctermfg=9       ctermbg=0
hi LineNr       ctermfg=240     ctermbg=233
hi VisualNOS    ctermfg=233
hi WildMenu     ctermfg=233
hi DiffAdd      ctermfg=233
hi DiffChange   ctermfg=233
hi DiffDelete   ctermfg=233
hi DiffText     ctermfg=233
hi Underlined   ctermfg=11
hi Error        ctermfg=9
hi TabLine      ctermfg=59      ctermbg=none    cterm=none
hi TabLineFill  ctermfg=0
hi TabLineSel   ctermfg=214     ctermbg=none
hi CursorLine   ctermfg=none    ctermbg=233     cterm=bold
