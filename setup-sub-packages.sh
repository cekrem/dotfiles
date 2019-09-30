#!/bin/bash

# Install go packages
go get -u github.com/mdempsky/gocode
go get -u github.com/sourcegraph/go-langserver
go get -u github.com/saibing/bingo 
go get -u golang.org/x/tools/cmd/gopls
go get -u github.com/cjbassi/gotop

# Install python packages
pip3 install neovim requests bpython beautifulsoup4 html5lib

# Install ruby gems
gem install colorls neovim sqlint

# Install npm packages
yarn global add neovim typescript onchange import-js

# Add yarn package installs to path
if grep -q "yarn" /etc/paths
then
	echo "yarn already in path!"
else
	sudo echo ~/.config/yarn/global/node_modules/.bin/ >> /etc/paths
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Move git repo to home
rsync -a ./ ~/;

# Install neovim plugins
nvim -c PlugInstall -c UpdateRemotePlugins
