#!/bin/bash

# Install Apple Command Line Tools
xcode-select --install

# Install brew and brew packages
if [ ! -f /usr/local/bin/brew ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install python3 neovim go fish yarn ctags

# Install python packages
pip3 install neovim requests bpython

# Install ruby gems
gem install colorls neovim

# Install npm packages
yarn global add neovim

# Install go packages
go get -u github.com/mdempsky/gocode
go get -u github.com/sourcegraph/go-langserver

# Symlink gocode and go-langserver
ln -sf ~/go/bin/gocode /usr/local/bin/gocode
ln -sf ~/go/bin/go-langserver /usr/local/bin/go-langserver

rsync -a ./ ~/;
nvim -c PlugInstall -c UpdateRemotePlugins
