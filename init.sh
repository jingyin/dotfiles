#!/usr/bin/env bash

script_dir=$(readlink -e $(dirname ${BASH_SOURCE[0]}))
echo ${script_dir}
ln -sf ${script_dir}/vimrc $HOME/.vimrc 
ln -sf ${script_dir}/gitconfig $HOME/.gitconfig
ln -sf ${script_dir}/sbtconfig $HOME/.sbtconfig
ln -sf ${script_dir}/emacs $HOME/.emacs
ln -sf ${script_dir}/Xresources $HOME/.Xresources
ln -sf ${script_dir}/tmux.conf $HOME/.tmux.conf
