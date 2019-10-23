#!/bin/bash

# Install go packages
go get -u github.com/mdempsky/gocode
go get -u github.com/sourcegraph/go-langserver
go get -u github.com/saibing/bingo 
go get -u golang.org/x/tools/cmd/gopls
go get -u github.com/cjbassi/gotop

# Install python packages
pip install neovim requests bpython beautifulsoup4 html5lib python-language-server
pip install -U -e git+https://github.com/amjith/pgcli.git#egg=pgcli
pip2 mssql-cli

# Install ruby gems
gem install colorls neovim sqlint

# Install npm packages
yarn global add neovim typescript onchange import-js

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

