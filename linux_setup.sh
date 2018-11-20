#!/bin/bash

arch=$1
echo "starting dev environment configuration for $arch"

apt-get update

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
install vim
install curl

link_dir_path=$(pwd)

# install vim plug
if [ -e ~/.vim/autoload/plug.vim ]; then
  echo "vim-plug already installed - skipping"
else
  echo "installing vim-plug"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install go
go_bin="go1.11.2.linux-$arch.tar.gz"
if [ -e /usr/local/go ]; then
	echo "$(go version) already installed - skipping"
else
  echo "installing go binary $go_bin"

  curl -Lo $go_bin https://dl.google.com/go/$go_bin 
  tar -xvf $go_bin -C /usr/local && rm $go_bin 
  
  echo "installed $(go version)"
fi

# install rvm for ruby
if [ -e /usr/share/rvm/bin/rvm ]; then
	echo "rvm already installed - skipping"
else
	echo "installing rvm"
	apt-get install software-properties-common
	apt-add-repository -y ppa:rael-gc/rvm
	apt-get update
	apt-get install rvm -y
	source /etc/profile.d/rvm.sh
	echo "installed $(rvm --version)"
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
