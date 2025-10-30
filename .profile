touch ~/.private.env
source ~/.private.env
alias chatgpt="/opt/homebrew/bin/chatgpt"

export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/envVars
export PATH=$PATH:~/utils
export PATH=$PATH:~/.roswell/bin/
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export PATH=$PATH:~/code/kotlin-language-server/server/build/install/server/bin
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/Applications/Racket\ v8.8/bin
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# gnu coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"

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
export JAVA_HOME="/opt/homebrew/Cellar/openjdk@21/21.0.8/libexec/openjdk.jdk/Contents/Home/"

# Android emulator
alias emulator="/opt/homebrew/share/android-commandlinetools/emulator/emulator"
alias android="/opt/homebrew/share/android-commandlinetools/emulator/emulator -avd Pixel_6_Pro_API_34_PlayStore_ARM -gpu on -skin 1440x3120"
alias ios="open -a Simulator.app"
alias emulators="ios && android"

# Dotnet from Rider
export PATH="$HOME/.dotnet:$PATH"

# Haskell (ghcup)
export PATH=$PATH:~/.ghcup/bin

echo "$PATH" >~/path

eval "$(/opt/homebrew/bin/brew shellenv)"

# fix key holding
defaults write -g ApplePressAndHoldEnabled -bool false

# Lovdata stuff
# Node version 20
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

# Aliases
alias lov-sync="~/code/lovdata/update.sh" # update: not syncing proto, just everything else
alias lov-config="~/code/lovdata/sync-config.sh"
alias lov-mount="~/code/lovdata/mount.sh mount"
alias lov-umount="~/code/lovdata/mount.sh unmount"
alias lov-remount="lov-umount && lov-mount"
alias lov-backend="lsof -i :8089 >/dev/null && echo 'Port 8089 is already in use. Aborting.' || (cd /Users/cekrem/code/lovdata/workspace/lovdata-proto/backend && mvn exec:java -Dexec.mainClass='no.lovdata.proto.ProKt' -Dio.ktor.development=true)"
alias lov-kill="pkill -9 -f maven || echo 'lovdata backend is not running'"
alias lov-reboot="lov-kill && lov-remount && lov-backend"
alias lov-fix="yarn format && yarn review:fix && git status"
alias lov-build="mvn clean install -Dmaven.test.skip=true"
alias elm-land-fork="~/code/elm-land/projects/cli/src/index.js"
alias lov-sql="ssh -L 33306:dbaas-staging.lovdata.c.bitbit.net:3306  christianekrem@stage02.lovdata.c.bitbit.net -N"
