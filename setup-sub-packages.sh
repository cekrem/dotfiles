#!/bin/bash
# THIS IS BROKEN!
set -e

# Install go packages
#go install github.com/mdempsky/gocode@latest
#go install github.com/sourcegraph/go-langserver@latest
#go install github.com/saibing/bingo@latest
#go install golang.org/x/tools/cmd/gopls@latest
#go install github.com/cjbassi/gotop@latest

# Install python packages
#pip3 install neovim requests bpython beautifulsoup4 html5lib python-language-server
#pip3 install -U -e git+https://github.com/amjith/pgcli.git#egg=pgcli
#pip2 mssql-cli

# Install ruby gems
#gem install colorls neovim sqlint

# Install npm packages
yarn global add neovim typescript onchange import-js scmindent

# Intsall lisp stuff with roswell
#ros install sbcl
#ros install cxxxr/sblint

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
