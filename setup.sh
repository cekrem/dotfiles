#!/bin/bash

# Install Apple Command Line Tools
xcode-select --install

# Install brew and brew packages
if [ ! -f /usr/local/bin/brew ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install python3 neovim go zsh yarn ctags ruby ag tmux fpp sed
brew cask install alacritty
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
ACCEPT_EULA=y brew install --no-sandbox msodbcsql mssql-tools

# Install python packages
pip3 install neovim requests bpython

# Install ruby gems
gem install colorls neovim sqlint

# Install npm packages
yarn global add neovim typescript onchange import-js

# Install go packages
go get -u github.com/mdempsky/gocode
go get -u github.com/sourcegraph/go-langserver
go get -u github.com/saibing/bingo 
go get -u golang.org/x/tools/cmd/gopls

# Add yarn package installs to path
if grep -q "yarn" /etc/paths
then
	echo "yarn already in path!"
else
	sudo echo ~/.config/yarn/global/node_modules/.bin/ >> /etc/paths
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rsync -a ./ ~/;
nvim -c PlugInstall -c UpdateRemotePlugins
