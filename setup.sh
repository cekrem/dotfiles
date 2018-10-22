#!/bin/bash

# Install go binaries
go get -u github.com/mdempsky/gocode
go get -u github.com/sourcegraph/go-langserver

ln -sf ~/go/bin/gocode /usr/local/bin/gocode
ln -sf ~/go/bin/go-langserver /usr/local/bin/go-langserver

rsync -a ./ ~/;
nvim +PlugInstall
