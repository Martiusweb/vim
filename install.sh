#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

function get_if_needed() {
	if [ ! -f $1 ]
	then
		echo Getting $1 from $2
		curl $2 > $1
	else
		echo $1 already available
	fi
}

function test_cmd() {
	echo -n "checking $1..."
	if which $1 > /dev/null 2>&1
	then
		echo "ok"
	else
		echo "fail!"
		ask_leave "$1 is missing, continue however?"
	fi
}

function test_prerequisites() {
	echo "Testing prerequisites..."
	test_cmd curl
	test_cmd bundle
	test_cmd rake
	test_cmd ctags
	test_cmd cmake
}

function ask() {
	echo -n $* " (y/n) : "
	read -n1 result
	echo

	if [ "$result" = "y" ]
	then
		return 0
	else
		return 1
	fi
}

function ask_leave() {
	ask $1
	if [ $? -ne 0 ]
	then
		exit 1
	fi
}

# Preamble
echo "Installing my vim configuration"
echo "By Martin Richard martius@martiusweb.net"
echo "Licensed under GNU GPLv2"
echo

test_prerequisites

# Install pathogen, colorschemes
mkdir -p autoload bundle colors

echo "Getting dependencies..."
get_if_needed autoload/pathogen.vim  'www.vim.org/scripts/download_script.php?src_id=16224'
get_if_needed colors/desertEx.vim    'https://raw.githubusercontent.com/vim-scripts/desertEx/master/colors/desertEx.vim'
get_if_needed colors/anotherdark.vim 'https://raw.githubusercontent.com/rodnaph/vim-color-schemes/master/colors/anotherdark.vim'
echo "That's all I need"
echo

# Load submodules
echo -n "Fetching submodules... "
if [ -d bundle/vim-powerline ]
then
	git submodule update --init --recursive > /dev/null 2>&1
else
	git submodule update --recursive > /dev/null 2>&1
fi
echo "ok"
echo

# Powerline
if [ `which yaourt` ]
then
    echo -n "installing Powerline... "
    yaourt -S python-powerline-git
else
    echo "Powerline is only auto-installable for archlinux via yaourt!"
    echo "For a manual installation please see:"
    echo "https://powerline.readthedocs.org/en/latest/installation/linux.html#installation-linux"
fi

# YouCompleteMe...
echo -n "installing YouCompleteMe..."
cd bundle/YouCompleteMe
./install.sh --clang-completer
cd $DIR
echo "ok"
echo

# Install fonts
echo -n "installing font... "
if [ ! -f .fonts/Monaco_Linux-Powerline.otf ]
then
	mkdir -p ~/.fonts
	cp -f assets/Monaco_Linux-Powerline.otf ~/.fonts
fi
echo "ok"
echo

# Symlinks
echo -n "Create symbolic links..."
rm -rf ~/.vim ~/.vimrc
ln -s $DIR ~/.vim
ln -s $DIR/vimrc ~/.vimrc
echo "ok"
echo

echo "Yay! Vim is ready, it's up to you to shine"
echo "By the way, call :Helptags at least once to update help contents with plugins documentation."
