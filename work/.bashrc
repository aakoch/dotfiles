SSH_ENV=$HOME/.ssh/environment
  
# start the ssh-agent
function start_agent {
  echo "Initializing new SSH agent..."
  # spawn ssh-agent
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
   echo succeeded
   chmod 600 "${SSH_ENV}"
   . "${SSH_ENV}" > /dev/null
   /usr/bin/ssh-add
}
			        
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

alias build="cd common/build-project/; mvn clean install -DskipTests=true"
alias edit='function edit() { nohup "/c/Program Files (x86)/Notepad++/notepad++.exe" $1 &};edit'
alias reload="echo \"Reloading .bashrc...\";source ~/.bashrc"
alias putty='function putty() { nohup "/c/Program Files (x86)/PuTTY/putty.exe" $1 & };putty'

# Git aliases
alias gs='git status'
alias gf='git fetch'
alias gco='git checkout'

# Stolen from bash-it: https://github.com/Bash-it/bash-it
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

function mkcd ()
{
    about 'make a directory and cd into it'
    param 'path to create'
    example '$ mkcd foo'
    example '$ mkcd /tmp/img/photos/large'
    group 'base'
    mkdir -p -- "$*"
    cd -- "$*"
}

# http://unix.stackexchange.com/questions/97920/how-to-cd-automatically-after-git-clone/
git_real_home=`which git`
git()
{
   local tmp=$(mktemp)
   local repo_name

   if [ "$1" = clone ] ; then
     $git_real_home "$@" | tee $tmp
     repo_name=$(awk -F\' '/Cloning into/ {print $2}' $tmp)
     rm $tmp
     printf "changing to directory %s\n" "$repo_name"
     cd "$repo_name"
   else
     $git_real_home "$@"
   fi
}

# make **/ match files in the current directory and its subdirectories recursively
# ie. rm **/*.bak
# shopt -s globstar
# :( didn't work for me

