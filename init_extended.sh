#!/usr/bin/env bash

~/dotfiles/init.sh

# latex
ln -s ~/dotfiles/latex_indentconfig.yaml ~/.indentconfig.yaml

# cheat
mkdir -p ~/.config
ln -s ~/dotfiles/cheat ~/.config/cheat

# ssh
ln -s ~/dotfiles/ssh/config ~/.ssh/config

# ansible
ln -s ~/dotfiles/ansible/ansible.cfg ~/.ansible.cfg

# git
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
