#!/bin/bash
set -e

# Install Apple Command Line Tools
xcode-select --install || echo "command line tools already present"

# Move Everything™ to home
rsync -a ./ ~./

# Install brew and brew packages
if [ ! -f /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

#./setup-sub-packages.sh BROKEN

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
