#!/bin/sh

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

# Preamble
echo "Installing my vim configuration"
echo "By Martin Richard martius@martiusweb.net"
echo "Licensed under GNU GPLv2"
echo

# Install pathogen, colorschemes
mkdir -p autoload bundle colors

echo "Getting dependencies..."
get_if_needed autoload/pathogen.vim  'www.vim.org/scripts/download_script.php?src_id=16224'
get_if_needed colors/desertEx.vim    'http://vimcolorschemetest.googlecode.com/svn/colors/desertEx.vim'
get_if_needed colors/anotherdark.vim 'http://vimcolorschemetest.googlecode.com/svn/colors/anotherdark.vim'
echo "That's all I need"
echo

# Load submodules
git submodule init
git submodule update

# Install fonts
echo -n"installing font... "
cp -f assets/Monaco_Linux-Powerline.otf ~/.fonts
echo "ok"
echo

# Simlinks
ln -s $DIR ~/.vim
ln -s $DIR/vimrc ~/.vim
