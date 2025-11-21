# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source ~/.zprofile

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  golang
  yarn
  brew
  rsync
  web-search
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

alias vim=nvim
editor=nvim

export VISUAL=$editor
export EDITOR=$editor
alias vi=$editor
alias todo="vim -o ~/Jottacloud/todo.txt <(week -t)"

alias azc="az interactive"
alias cli="az interactive"
alias pr="hub pr show"
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
if [[ $(hostname) == "Christians-MacBook-Pro-2.local" ]]; then
  export NOTE_PATH=$HOME/notes
else
  export NOTE_PATH=$HOME/Jottacloud/ideas
fi

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
alias tt="vi ~/Jottacloud/ideas/2024-09-09_Tentmaker-Tuesday.md"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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
alias docker-postgres="docker run --name basic-postgres -e POSTGRES_PASSWORD=pw -p 5432:5432 -d postgres"

#week -r

