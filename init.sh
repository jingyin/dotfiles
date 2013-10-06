#!/usr/bin/env bash

ln -s -f $HOME/dotfiles/vimrc $HOME/.vimrc 
ln -s -f $HOME/dotfiles/bashrc $HOME/.bashrc 
ln -s -f $HOME/dotfiles/gitconfig $HOME/.gitconfig

source $HOME/.bashrc
