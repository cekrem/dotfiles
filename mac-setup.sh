#!/bin/bash

# Install Apple Command Line Tools
xcode-select --install

# Install brew and brew packages
if [ ! -f /usr/local/bin/brew ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install hub python3 neovim go zsh yarn ctags cquery ruby ag tmux fpp sed extract_url
brew cask install alacritty
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
ACCEPT_EULA=y brew install --no-sandbox msodbcsql mssql-tools

# Add yarn package installs to path
if grep -q "yarn" /etc/paths
then
	echo "yarn already in path!"
else
	sudo echo ~/.config/yarn/global/node_modules/.bin/ >> /etc/paths
fi

# Install neovim plugins
nvim -c PlugInstall -c UpdateRemotePlugins

./setup-sub-packages.sh