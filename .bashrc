#
# ~/.bashrc

#set Vim mode in bash
#set -o vi
#set Emacs mode in bash
#set -o emacs

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

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

if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\[$yellow\][[\u:\W]]\[$reset\]\[$green\] '
	else
		PS1='\[$bold\]\[$yellow\][[ \[$yellow\]\[$red\]\u:\[$green\]\w\[$yellow\] ]]\[$reset\] '
	fi
#PS1='[\u@\h \W]\$ '
#PS1='\[$red\]\[$bold\]\u\[$reset\]\[$bold\]@\[$green\]\[$bold\]\h\[$reset\]:\[$blue\]\[$bold\]\w\[$reset\]\$ '

# shopt -s autocd


scipwi() {
    ip addr show dev wlp3s0 | grep -E "inet " | awk 'NR==1{print$2}'
}
sciplist(){
    ip addr | grep -E "^[1-5]" | awk -F: '{print $1":"$2}'
}
scip() {
	if [[ $1 == "" ]] ; then
    		ip addr
	else
		ip addr show dev `sciplist | awk -v ln=$1 'NR==ln' | awk -F: '{print$2}'`
	fi
}
PATH=$PATH:/home/abhirup/.local/bin
alias grep="grep --color"
alias open="xdg-open"


alias reflector_update="sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak \
         && sudo reflector --verbose --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias logoff="kill -9 -1"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

