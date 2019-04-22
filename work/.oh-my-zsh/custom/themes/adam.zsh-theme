#
# Main prompt
#
export PATH=$PATH:/usr/local/bin/

local date="%w %T"
local path_string="%1~"
local prompt_string=">"

# Make prompt_string red if the previous command failed.
local return_status="%(?:%{$fg[blue]%}$prompt_string:%{$fg[red]%}$prompt_string)"

local day="%D{%f}"
local day="%(1d.the 1st.%(3d.the 3rd.%D{%f}))"
local monday="$emoji[pensive_face] Monday ${day} %T"
local tuesday="$emoji[calendar] Tuesday ${day} %T"
local wednesday="$emoji[dromedary_camel]  Hump day! ${day} %T"
local thursday="$emoji[baby] Friday JR. ${day} %T"
local friday="Friday! ${day} %T"
local formatted_date="%(1w.${monday}.%(2w.${tuesday}.%(3w.${wednesday}.%(4w.${thursday}.%(5w.${friday}.${date})))))"
PROMPT='${formatted_date} ${path_string} ${return_status} %{$reset_color%}'
#RPROMPT='$ZSH_COMMAND_TIME_MSG $timer_show'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $@"
alias ll="ls -Ahl"
alias lr="ll -rth"
alias gs="git status"
#alias oldfind="find"
#alias find="mdfind"

# https://github.com/popstas/zsh-command-time
# ZSH_COMMAND_TIME_COLOR="red"
ZSH_COMMAND_TIME_MSG='⏱ %s'

# key bindings
bindkey "^[[1;5C" forward-word
bindkey "^ [[1;5D" backward-word
bindkey "^[^?" backward-kill-word
