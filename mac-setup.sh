#!/bin/bash
set -e

# Install Apple Command Line Tools, if not present
xcode-select --install || echo "command line tools already present"

# Move Everything™ to home
rsync -a ./ ~./

# Install brew and brew packages
if [ ! -f /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew tap homebrew/bundle || echo "brew tap not required"
brew bundle install

# Install proper emacs (not in use)
#brew tap railwaycat/emacsmacport
#brew install emacs-mac

#rm -rf ~/.emacs.d ~/.emacs
#git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.doom.d
#ln -s ~/.emacs.doom.d ~/.emacs.d

# Install vim plugins (not in use, using neovim/lazyvim)
#vim -c PlugInstall -c UpdateRemotePlugins

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install python packages
#pip3 install neovim requests bpython beautifulsoup4 html5lib python-language-server
#pip3 install -U -e git+https://github.com/amjith/pgcli.git#egg=pgcli
#pip2 mssql-cli

# Install npm packages
yarn global add neovim typescript onchange import-js scmindent

# Install go packages
go install github.com/mdempsky/gocode@latest
go install github.com/sourcegraph/go-langserver@latest
go install github.com/saibing/bingo@latest
go install golang.org/x/tools/cmd/gopls@latest
go install github.com/cjbassi/gotop@latest

# Intsall lisp stuff with roswell
ros install sbcl
ros install cxxxr/sblint
