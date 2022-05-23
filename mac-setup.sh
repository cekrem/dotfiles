#!/bin/bash

# Install Apple Command Line Tools
xcode-select --install

# Move Everything™ to home
rsync -a ./ ~./

# Install brew and brew packages
if [ ! -f /opt/homebrew/bin/brew ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/bundle
brew bundle install

# Install proper emacs
#brew tap railwaycat/emacsmacport
#brew install emacs-mac

#rm -rf ~/.emacs.d ~/.emacs
#git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.doom.d
#ln -s ~/.emacs.doom.d ~/.emacs.d

# Install vim plugins
vim -c PlugInstall -c UpdateRemotePlugins

./setup-sub-packages.sh
