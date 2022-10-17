set nocompatible

"let skip_defaults_vim=0
"source $VIMRUNTIME/vimrc_example.vim

" this is a vimrc_example/defaults, stolen from vim81.
" ========= DEFAULTS =========
" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200     " keep 200 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set wildmenu        " display completion matches in a status line

set ttimeout        " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
" Revert with ":unmap Q".
map Q gq
sunmap Q

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
"if has('mouse')
"  if &term =~ 'xterm'
"    set mouse=i
"  else
"    set mouse=i
"  endif
"endif

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | exe 'au!' | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

  " Quite a few people accidentally type "q:" instead of ":q" and get confused
  " by the command line window.  Give a hint about how to get out.
  " If you don't like this you can put this in your vimrc:
  " ":augroup vimHints | exe 'au!' | augroup END"
  augroup vimHints
    au!
    autocmd CmdwinEnter *
      \ echohl Todo |
      \ echo 'You discovered the command-line window! You can close it with ":q".' |
      \ echohl None
  augroup END

endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile    " keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
" ========= DEFAULTS =========

set backupdir=~/.cache/vim/backups
set undodir=~/.cache/vim/undos

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

