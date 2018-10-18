#!/bin/bash

echo "starting dev environment configuration"

install () {
	local program=$1
	local output=$(command -v $program)
	
    if [ "$output" = "" ]; then
		echo "$program not found - installing"
		sudo apt-get -y install $program
	else
		echo "$program already installed - skipping"
	fi
}

install tmux
install direnv
install arduino

link_dir_path=$(pwd)

# install vim plug
if [ -e ~/.vim/autoload/plug.vim ]; then
  echo "vim-plug already installed - skipping"
else
  echo "installing vim-plug"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install go
if [ -e /usr/local/go ]; then
	echo "$(go --version) already installed - skipping"
else
  echo "installing go v1.11"
  # need to compile go from source here
  # curl -Lo go1.4-bootstrap-20171003.tar.gz https://dl.google.com/go/go1.4-bootstrap-20171003.tar.gz
  # tar -xvf go1.4-bootstrap-20171003.tar.gz -C
  #curl -Lo go1.11.1.linux-amd64.tar.gz https://dl.google.com/go/go1.11.1.linux-armv6l.tar.gz
  #curl -Lo go1.11.1.linux-amd64.tar.gz https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz
  # tar -xvf go1.11.1.linux-amd64.tar.gz -C /usr/local && rm go1.11.1.linux-amd64.tar.gz
  # echo "installed $(go --version)"
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

if [ -e ~/.bash_profile ]; then
	echo ".bash_profile already exists - skipping"
else
	echo "symlinking ~/.bash_profile from $link_dir_path/.bash_profile"
	ln -s "$link_dir_path/.bash_profile" ~/.bash_profile
fi
