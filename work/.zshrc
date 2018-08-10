# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/<<REPLACE ME>>/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="tjkirch"
ZSH_THEME="adam"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  battery
  catimg
  colored-man-pages
  command-time
  copydir
  copyfile
  cp
  emoji
  encode64
  gradle
  history-adam
  pj
  stopwatch
  urltools
  web-search
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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias isodate="gdate --iso-8601=ns"
alias date="gdate"
alias datefilename="echo $(gdate --iso-8601=ns) | tr -c \"[:alnum:]\" \"-\""
alias cc="cat ~/common_commands.txt"
alias copy=pbcopy
alias paste=pbpaste
alias finder="open ."
alias branch="git rev-parse --abbrev-ref HEAD"
alias time_summary="python ~/projects/readdates.py"

export JAVA8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home
export JAVA10_HOME=/Library/Java/JavaVirtualMachines/jdk-10.0.1.jdk/Contents/Home
export PATH=/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home/bin:/Applications/gradle-4.7/bin:/Applications/groovy-2.4.15/bin:$PATH
export NVM_DIR="$HOME/.nvm"

. "/usr/local/opt/nvm/nvm.sh"
PROJECT_PATHS=(~/projects)

bindkey "^?" backward-kill-word
bindkey "^[?" backward-word

function plugins() {
    PLUGIN_PATH="~/.oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; grep -r "^function w*" "$PLUGIN_PATH$plugin/" | awk '{print $2}' | sed 's/()//'| tr '\n' ', '; grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2 }' | sed 's/=.*//' |  tr '\n' ', '
    done
}

function record() {
  echo "$(gdate --iso-8601=seconds) $@" >> ~/Documents/time.txt
  tail ~/Documents/time.txt
}

function gitlog() {
  if [[ $# -eq 0 ]] then
    echo "Please provide which release to get logs for. Example: gitlog \$(gitlatestreleaseversion | sed 's/\./\\\\\./g')"
  else
    git --no-pager log --merges --all --pretty="format:%Cred%h %Cblue%an, %Cgreen%ar %Creset%<(120,mtrunc)%s" --grep="Merge pull request .* to release/$@" --grep="Merge pull request .* to develop$" --since="3 months ago"
fi
}

function gitlatestrelease() {
  git ls-remote --symref origin release\* | sed 's?.*refs/heads/??' | sed '$!d'
}

function gitlatestreleaseversion() {
  git ls-remote --symref origin release\* | sed 's?.*refs/heads/release/??' | sed '$!d'
  #git ls-remote --symref origin release\* | sed 's?.*refs/heads/release/??' | sed '$!d' | sed 's/\./\\\./g'
}

function removeblanklines() {
  sed -i '.bak' '/^$/d' $@
}

function deleteblanklines() {
  removeblanklines $@
}

function proofpoint_url_decode() {
  python3 ~/projects/proofpoint/URLDefenseDecode.py $@
}

# reads file, formats and writes it back
function xmlformat() {
  if [ ! -f $@ ]; then
    echo "File not found"
  else
    xmllint --format --nowarning -o $1 $1
  fi
}

# z - jump-around: https://github.com/rupa/z.git
. ~/Library/z/z.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

