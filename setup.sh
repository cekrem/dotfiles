#!/bin/bash

# Install Apple Command Line Tools
xcode-select --install

# Install brew and brew packages
if [ ! -f /usr/local/bin/brew ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install python3 neovim go fish yarn ctags ruby

# Install python packages
pip3 install neovim requests bpython

# Install ruby gems
gem install colorls neovim

# Install npm packages
yarn global add neovim typescript

# Install go packages
go get -u github.com/mdempsky/gocode
go get -u github.com/sourcegraph/go-langserver

# Symlink gocode and go-langserver
ln -sf ~/go/bin/gocode /usr/local/bin/gocode
ln -sf ~/go/bin/go-langserver /usr/local/bin/go-langserver

# Add yarn package installs to path
if grep -q "yarn" /etc/paths
then
	echo "yarn already in path!"
else
	sudo echo ~/.config/yarn/global/node_modules/.bin/ >> /etc/paths
fi

if grep -q "fish" /etc/shells
then
	echo "Fish shell already in allowed shells"
else
	sudo echo /usr/local/bin/fish >> /etc/shells
fi

chsh -s /usr/local/bin/fish

rsync -a ./ ~/;
nvim -c PlugInstall -c UpdateRemotePlugins
