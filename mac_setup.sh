#/!/bin/bash


install () {
	local program=$1
	local command=$2
	local output=$(command -v $program)
	if [ "$output" = "" ]; then
		echo "$program not found - installing"
		eval $command
	else
		echo "$program already installed - skipping"
	fi
}

install brew '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

package_list=("tmux" "direnv" "go" "dep" "bash-completion" "glide" "hub")

for i in "${package_list[@]}"
do
  brew install $i
done

link_dir_path=$(pwd)
 
symlink () {
	local dotfile=$1
	if [ -e $HOME/$dotfile ]; then
		echo "$HOME/$dotfile exists - skipping"
	else
		echo "symlinking $HOME/$dotfile from $link_dir_path/$dotfile"
		ln -s  "$link_dir_path/$dotfile" $HOME/$dotfile 
	fi
}

# add symlinks for all dotfiles
symlink .gitconfig
symlink .bash_profile
symlink .vimrc

# update default screenshot location
screenshot_location="$HOME/Pictures/Screenshots"
if [ ! -d $screenshot_location ]; then 
    mkdir $screenshot_location
    echo "Updating screenshot location to $screenshot_location"
    defaults write com.apple.screencapture location $screenshot_location 
    killall SystemUIServer
else
    echo "$screenshot_location exists - skipping"
fi
