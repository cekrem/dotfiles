export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/envVars
export PATH=$PATH:~/utils
export PATH=$PATH:~/.roswell/bin/
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export PATH=$PATH:~/code/kotlin-language-server/server/build/install/server/bin
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:~/.local/bin
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# Python 3.7
export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/python@3.7/lib"
export PKG_CONFIG_PATH="/usr/local/opt/python@3.7/lib/pkgconfig"

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

echo "$PATH" > ~/path

eval "$(/opt/homebrew/bin/brew shellenv)"

# fix key holding
defaults write -g ApplePressAndHoldEnabled -bool false
