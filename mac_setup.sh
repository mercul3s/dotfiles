#!/bin/bash


install () {
	local program=$1
	local output=$(command -v $program)
	if [ "$output" = "" ]; then
		echo "$program not found - installing"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "$program already installed - skipping"
	fi
}

install brew

brew install tmux
brew install direnv
brew install go

link_dir_path=$(pwd)

# symlink config files
symlink () {
	local dotfile=$1
	echo $HOME/$dotfile
	if [ -e $HOME/$dotfile ]; then
		echo "$HOME/$dotfile exists - skipping"
	else
		echo "symlinking $HOME/$dotfile from $link_dir_path/$dotfile"
		ln -s  "$link_dir_path/$dotfile" $HOME/$dotfile 
	fi
}


symlink .gitconfig
symlink .bash_profile
symlink .vimrc
