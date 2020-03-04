# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
if [[ "$OSTYPE" == "darwin"* ]]; then
  export ZSH="/Users/cekrem/.oh-my-zsh"
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

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
#

# Add private vars to env:
touch ~/.private.env
source ~/.private.env

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias python=/usr/local/bin/python3
  alias pip=/usr/local/bin/pip3
  alias afk="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"
  alias sed="gsed"
  alias vim="nvim"
  export VISUAL=nvim
else
  export VISUAL=vim
fi

export EDITOR="$VISUAL"
alias vi="vim"
alias azc="az interactive"
alias cli="az interactive"
alias pr="hub pr show"
alias mpboard="open 'https://vippsas.atlassian.net/secure/RapidBoard.jspa?rapidView=1'"
alias lint="golangci-lint run --disable-all -p style -p complexity -p bugs -p format"

# gnu version of bsd built-ins

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Go private repos
export GOPRIVATE="github.com/vippsas/golib"

# Extend PATH
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/envVars
export PATH=$PATH:~/utils

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

