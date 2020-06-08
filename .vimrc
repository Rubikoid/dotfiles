set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'vim-dirdiff'

call vundle#end()
filetype plugin indent on


syntax enable
set termguicolors
set background=dark
let g:solarized_italics=0
"colorscheme twilight-anti-bright
"colorscheme darkblue 
"colorscheme solarized
colorscheme solarized8
set term=xterm-256color
set tabstop=4
set expandtab
set autoindent
set number
set whichwrap=<,>
au filetype asm set filetype=nasm

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_ViewRule_pdf='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe file://'
