set nocompatible

filetype off
filetype plugin indent on
syntax enable


" setup plugins...
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'WolfgangMehner/awk-support'

call plug#end()
" end plugins


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

" tab == 4 spaces; always use spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set cindent

" idk what is this
set whichwrap=<,>

" to make lightline work better
set laststatus=2
set ttimeout ttimeoutlen=50
set noshowmode

" Ctrl+P setup
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" bind ctrl+o for nerdtree
map <C-o> :NERDTreeToggle<CR>

" line number
set number

" some bindings...
set pastetoggle=<f5>
nnoremap <f4> :set nonumber!<CR>

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

