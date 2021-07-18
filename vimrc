set nocompatible
filetype off

filetype plugin indent on

syntax enable

" setup term, because of crazy vim reaction to screen/tmux-256color and broken ctrl+arrow keys
set term=xterm-256color

" i believe this will make colors better
set termguicolors

" dark bg
set background=dark

" theme setup
"let g:clear_background=0
"let g:solarized_italics=0
"colorscheme twilight-anti-bright
"colorscheme darkblue 
"colorscheme solarized
"colorscheme solarized8
"colorscheme hybrid
colorscheme monokai

" make bg transparent 
hi Normal guibg=NONE ctermbg=NONE

" simple tab config
set tabstop=4
set expandtab
set autoindent
set number
set whichwrap=<,>

" asm is nasm
au filetype asm set filetype=nasm

" latex mb?
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_ViewRule_pdf='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe file://'

" Fix auto-indentation for YAML files
augroup yaml_fix
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
augroup END

