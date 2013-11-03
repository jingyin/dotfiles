#!/usr/bin/env bash

ln -s -f $HOME/dotfiles/vimrc $HOME/.vimrc 
ln -s -f $HOME/dotfiles/bashrc $HOME/.bashrc 
ln -s -f $HOME/dotfiles/gitconfig $HOME/.gitconfig
ln -s -f $HOME/dotfiles/bash_profile $HOME/.bash_profile
ln -s -f $HOME/dotfiles/sbtconfig $HOME/.sbtconfig
ln -s -f $HOME/dotfiles/emacs $HOME/.emacs
ln -s -f $HOME/dotfiles/Xresources $HOME/.Xresources

source $HOME/.bashrc
