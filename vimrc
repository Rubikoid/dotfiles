set nocompatible
filetype off

filetype plugin indent on

syntax enable

"set termguicolors
set background=dark
"let g:solarized_italics=0
"colorscheme twilight-anti-bright
"colorscheme darkblue 
"colorscheme solarized
"colorscheme solarized8
colorscheme hybrid
set term=xterm-256color

set tabstop=4
set expandtab
set autoindent
set number
set whichwrap=<,>
au filetype asm set filetype=nasm

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif


let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_ViewRule_pdf='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe file://'

" Fix auto-indentation for YAML files
augroup yaml_fix
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
augroup END
