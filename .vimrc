set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'LaTeX-Suite-aka-Vim-LaTeX'

call vundle#end()
filetype plugin indent on


syntax enable
set background=dark
colorscheme darkblue 
"colorscheme solarized
set tabstop=4
set expandtab
set autoindent
set number
set whichwrap=<,>

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_ViewRule_pdf='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe file://'
