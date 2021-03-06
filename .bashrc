#
# ~/.bashrc

#set Vim mode in bash
set -o vi
#set Emacs mode in bash
#set -o emacs

# List of important system path shortcuts
TERM=xterm
CONFIGS=$HOME/.config
SCRIPTS=$CONFIGS/scripts
WIN="/mnt/c/Users/amit"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# Coloured Bash Prompt
bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
yellow=$(tput setaf 3)
reset=$(tput sgr0)
undl=$(tput smul)
rmundl=$(tput rmul)
RED='\033[1;33m'

if [[ ${EUID} == 0 ]]; then
  # show root@ when we don't have colors
  # PS1='\[$yellow\][[\u:\W]]\[$reset\]\[$green\] '
  PS1='\[$yellow\][[\u:\W]]\[$reset\]\[$green\] '
else
  # PS1='\[$bold\]\[$yellow\][[ \[$yellow\]\[$red\]\u:\[$green\]\w\[$yellow\] ]]\[$reset\] '
  PS1='\[$bold\]\[$red\]\u:\[$green\]\w>\[$reset\] '
fi
# reduces the Path prompt to specified length
prompt_dir() {
  PROMPT_DIRTRIM=$1
}


# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
# # Append history across sessions, is Questionable!
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -n"
## Current version is alias activated
alias hsync="history -a; history -c; history -r"

# Git VCS symbols in bash-prompt
# if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
#     GIT_PROMPT_ONLY_IN_REPO=1
#     source $HOME/.bash-git-prompt/gitprompt.sh
# fi

alias ..="cd .."
alias ,="cd -"
alias rn="ranger"
alias open="xdg-open"
alias baredot="git --git-dir=$HOME/mydotfiles --work-tree=$HOME"
alias bt="git --git-dir=$HOME/mydotfiles --work-tree=$HOME"
alias reflector_update="sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak \
         && sudo reflector --verbose --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias ai="sudo apt-get install"
alias au="sudo apt-get update"
alias aug="sudo apt-get upgrade"
alias sup="sudo updatedb"
alias logoff="kill -9 -1"
alias chcaps="setxkbmap -option \"caps:swapescape\""
alias chback="setxkbmap -option "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Python environment setup
alias intelpython="source ~/Software/intelpython3/bin/activate"
alias deepml="source ~/Software/intelpython3/bin/activate && conda activate deepml"
alias cac="conda activate"
alias deac="conda deactivate"

# Tmux configuration
export TERM="xterm-256color"
TMUX_DIR="$HOME/.tmux"
TMUX_CONF="$TMUX_DIR/tmux.conf"
# 'tmux -2' is needed to enforce 256 color support
alias tmux="tmux -2 -f $TMUX_CONF"
# Auto-resurrecting Tmux state after boot
alias mux='pgrep -vx tmux > /dev/null && tmux new -d -s delete-me && tmux run-shell $TMUX_DIR/plugins/tmux-resurrect/scripts/restore.sh && tmux kill-session -t delete-me && tmux attach || tmux attach'

alias em='emacs -q -l my-emacs/.emacs'
export EDITOR="/usr/bin/vim"

#BASE16_SHELL=$HOME/.config/base16-shell/
#[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fzbg(){
    if [ -f ~/.fzf/bin/fzf ]; then
        if [ -f "$CONFIGS/BASE16.txt" ]; then
            eval $(cat "$CONFIGS/BASE16.txt" | fzf)
        else
            alias | grep --color=none 'base16 ' | awk -F"[ =]" '{print $2}' > "$CONFIGS/BASE16.txt"
            echo "wrote to $CONFIGS/BASE16.txt"
        fi
    else
        echo "fzf not installed."
    fi
}
fpchoose(){
    # MAXDEPTH=$2
    [ -f ~/.fzf/bin/fzf ] && echo $(find "$1" | fzf -m)
}

PATH=$PATH:/home/abhirup/.local/bin:~/.cargo/bin:~/go/bin:$SCRIPTS
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/

# WSL settings
#KERNEL=`uname -r`
#if [[ $KERNEL == *microsoft* ]]; then
#    VIP=`ipconfig.exe | awk -F" : " '/IPv4.*172/{print $2}'`
#    export DISPLAY=${VIP/$'\r'/}":0"
#fi

if [ -d ~/.bash_completion.d ]; then
  for file in ~/.bash_completion.d/*; do
    . $file
  done
fi

mkcd() {
    mkdir $1
    cd $1
}
font-match(){
    fc-match -s "$1" | grep -i "$1"
}
#chcaps

alias python=python3

source /home/abhirup/.config/broot/launcher/bash/br
