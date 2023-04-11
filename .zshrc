# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
if [[ "$OSTYPE" == "darwin"* ]]; then
  export ZSH="/Users/christian.ekrem/.oh-my-zsh"
else
  export ZSH="/home/vagrant/.oh-my-zsh"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.

# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  kubectl
  docker
  golang
  yarn
  brew
  postgres
  rsync
  web-search
  taskwarrior
)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
#

# Add private vars to env:
touch ~/.private.env
source ~/.private.env

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias python3="python3.10"
  alias python=python3
  alias pip3="python -m pip"
  alias pip="pip3"
  alias afk="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"
  alias sed="gsed"
  alias vim="$(brew --prefix vim)/bin/vim"
fi

alias lvim=$HOME/.local/bin/lvim
alias vim=nvim
editor=nvim

export VISUAL=$editor
export EDITOR=$editor
alias vi=$editor
alias todo="vim -o ~/Jottacloud/todo.txt <(week -t)"

alias azc="az interactive"
alias cli="az interactive"
alias pr="hub pr show"
alias mpboard="open 'https://vippsas.atlassian.net/secure/RapidBoard.jspa?rapidView=1'"
alias lint="golangci-lint run --disable-all -p style -p complexity -p bugs -p format"
alias sbcl-cli="rlwrap ros run"
alias git-report="~/code/git-report/index.js ~/code"
alias git-report-short="~/code/git-report/index.js ~/code | tail -1"

# Sorted and nice disk usage
dunice() {
  du -mh -d1 . | sort -hr
}

# Dev ops helpers
es() {
  source ~/envVars/"$1"
}
aks-forward () {
  if (( $# == 0 ))
  then echo usage: aks-forward app-name...; fi
  sudo kubefwd svc -n uat -l "app in($@)"
}
aks-forward-mt () {
  if (( $# == 0 ))
  then echo usage: aks-forward app-name...; fi
  sudo kubefwd svc -n mt -l "app in($@)"
}
encrypt() {
  if (( $# == 0 ))
  then echo usage: encrypt filename; fi
  fileIn="$1"
  fileOut="$1.enc"
  echo "creating $fileOut..."
  openssl enc -blowfish -salt -in $fileIn -out $fileOut -md SHA256 -k $ENCRYPTION_SECRET
  echo decrypt by doing: openssl enc -d -blowfish -in $fileOut -out $fileIn -md SHA256 -k INSERT_SECRET_HERE
}
decrypt() {
  if (( $# == 0 ))
  then echo usage: decrypt filename; fi
  fileIn="$1"
  fileOut=$(basename $1 .enc)
  echo "creating $fileOut..."
  openssl enc -d -blowfish -in $fileIn -out $fileOut -md SHA256 -k $ENCRYPTION_SECRET
}

gradle-clean() {
  ./gradlew --stop && ./gradlew clean aUD --no-build-cache
}

stuff() {
  vi ~/stuff.org
}

android-release() {
  vi ~/android-release.org
}


# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Vagrant default provider
VAGRANT_DEFAULT_PROVIDER=virtualbox

# Go private repos
export GOPRIVATE="github.com/vippsas/golib"

# ripgrep / fzf settings
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs --glob "!{node_modules,.git}"'
export FZF_DEFAULT_OPTS="--ansi"
export NOTE_PATH=/Users/christian.ekrem/Jottacloud/ideas

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias rn="ripnote"
alias intent="adb shell am start -a android.intent.action.VIEW -d"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zprofile

lgtms=$(cat << EOF
Let's Go To Mars!
Let's Get This Merged!
Lets Get Ten More
Lonely Giraffe Tickled Me
Legendary Genius Transformative Methods
Let's Gamble, Try Merging
Lines Geared Towards Mischief
Let's Go To McDonald's
Large Gray Torqued Monkeys
Lazy Graphic Transformation Methods
Leave Garfield To Me
Lines Golf Tripods Metaphysics
Looks Good Till Morning
Let's Golf Together in Mars
EOF
)

alias lgtm='echo $lgtms | shuf -n 1 | tee >(pbcopy)'
alias vlime='sbcl --load ~/.local/share/nvim/lazy/vlime/lisp/start-vlime.lisp'

#week -r

