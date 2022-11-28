#!/usr/bin/env bash

# tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# zshrc
ln -s ~/dotfiles/zshrc ~/.zshrc

# vim
mkdir -p ~/.cache/vim/{backups,undos}
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim


