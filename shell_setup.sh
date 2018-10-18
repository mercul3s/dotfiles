#!/bin/bash

echo "starting dev environment configuration"

install () {
	local program=$1
	local output=$(command -v $program)
	
    if [ "$output" = "" ]; then
		echo "$program not found - installing"
		sudo apt-get install $program
	else
		echo "$program already installed - skipping"
	fi
}

install tmux

link_dir_path=$(pwd)

# install vim plug
if [ -e ~/.vim/autoload/plug.vim ]; then
  echo "vim-plug already installed - skipping"
else
  echo "installing vim-plug"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# symlink config files 
if [ -e ~/.vimrc ]; then
	echo ".vimrc exists - skipping"
else
	echo "symlinking ~/.vimrc from $link_dir_path/.vimrc"
	ln -s  "$link_dir_path/.vimrc" ~/.vimrc
fi

if [ -e ~/.gitconfig ]; then
	echo ".gitconfig already exists - skipping"
else
	echo "symlinking ~/.gitconfig from $link_dir_path/.gitconfig"
	ln -s "$link_dir_path/.gitconfig" ~/.gitconfig
fi

