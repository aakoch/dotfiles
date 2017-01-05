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

# make **/ match files in the current directory and its subdirectories recursively
# ie. rm **/*.bak
shopt -s globstar
