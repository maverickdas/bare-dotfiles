# Environment variables
set -gx GTK_THEME Adwaita:dark
set -gx PDFR /usr/bin/zathura
set -gx VISUAL vim
set -gx EDITOR nvim
set -gx BROWSER /usr/bin/google-chrome-stable
# $TERMINAL made use of by mimeapps for xdg-open
# set -gx TERMINAL /usr/local/bin/st -f 'Source Code Pro Medium:size=12'
set -gx TERMINAL /usr/bin/termite
set -gx TALPHA 0.80
set -gx WALLPDIR ~/Pictures/Wallpapers
set -gx TESTBENCH ~/Dev/Testbench
set -gx CONFIGS ~/.config
set -gx SCRIPTS $CONFIGS/scripts
set -gx RANGER_LOAD_DEFAULT_RC "FALSE"
set -gx QT_SCALE_FACTOR 1
set -gx MANPATH /usr/local/man:/usr/local/share/man:/usr/share/man:/usr/man
set -gx MANPAGER less
# set -gx ANDROID_HOME /home/abhirup/Android/Sdk
# set FLUTTER_BIN /home/abhirup/Documents/Boost_Codes/Flutter/flutter/bin
set -gx GOPATH $HOME/go
set -gx PATH $PATH $SCRIPTS $HOME/.local/bin $GOPATH/bin
set -gx megadir $HOME/MEGAsync
set -gx vinit $HOME/.config/nvim/init.vim

# Configuring bare git repository
set -x bare_dir $HOME/mydotfiles
set -x bare_includes $bare_dir/.includes
alias baredot="git --git-dir=$bare_dir --work-tree=$HOME"

function bare_include_file
    set lines (cat $bare_includes)
    set key (realpath $argv)
    for line in $lines
        if [ $key = $line ]
            echo "$key already exists in $bare_includes"
            return
        end
    end
    echo $key >>$bare_includes
end

function bare_add_all
    cat $bare_includes | xargs -I{} fish -c "baredot add {}"
end

function git_productivity
    echo "Between "$argv[1]" and "$argv[2]" --"
    git log --shortstat --since=$argv[1] --until=$argv[2] \
        | grep "files changed\|Author\|Merge:" \
        | awk '{ \
		    if ($1 == "Author:") {\
		      currentUser = $2;\
		    }\
		    if ($2 == "files") {\
		      files[currentUser]+=$1;\
		      inserted[currentUser]+=$4;\
		      deleted[currentUser]+=$6;\
		    }\
		  } END {\
		    for (i in files) {\
		      print i ":", "files changed:", files[i], "lines inserted:", inserted[i], "lines deleted:", deleted[i];\
		    }\
		  }'
end

# Useful functions

function noerr --description 'Redirects error of command to /dev/null'
    $argv >/dev/null 2>&1
end

function capture --description 'Stores output of given command in $pop'
    set -gx pop (eval $argv)
    echo $pop
    echo "Captured output to pop"
end

function fbash --description 'Run bash commands from fish'
    exec bash -c "$argv"
end

function .runsudo --description 'Prefix given command with sudo'
    set cursor_pos (echo (commandline -C) + 5 | bc)
    commandline -C 0
    commandline -i 'sudo '
    commandline -C "$cursor_pos"
end
bind \es ".runsudo"

function .suffixfzf --description 'Pipe command to fzf'
    commandline -i ' | fzf'
end
bind \ef ".suffixfzf"

function .outputfzf --description 'Use output from (fzf)'
    commandline -i ' (fzf)'
end
bind \eF ".outputfzf"

function mkcd --description 'Create directory and cd into it'
    mkdir $argv[1]
    cd $argv[1]
end

# Generating metadata from video
# function ffmcreate
#     ffprobe -v quiet $argv   -print_format json -show_entries stream=index,codec_type:stream_tags=creation_time:format_tags=creation_time >  $argv.txt
# end

# function -e fish_preexec _run_fasd
#     fasd --proc (fasd --sanitize "$argv") > "/dev/null" 2>&1
# end
# function j
#     cd (fasd -d -e 'printf %s' "argv")
# end

function sample
    echo $argv[1]:$argv[2] | awk -F: -v name=$argv[3] '{print $1 " " name " " $2}'
end
function fzl
    ls $argv | fzf
end
# Keybindings
bind RR "ranger"

alias yuy="yay --answerclean N --answerdiff N -Syyu"
alias zra="zathura"
alias st="st -f 'Source Code Pro Medium:size=12'"
alias rn="ranger"
alias la="ls -a"
alias ll="ls -l"
alias lgrep="ls | grep"
alias rrf="rm -rf"
alias grep="grep --color"
alias diff="diff --color"
alias open="xdg-open"
alias vi="nvim"
alias svi="sudo nvim"
alias med="medit > /dev/null 2>&1"
alias git-cred-store="git config credential.helper 'cache --timeout 3600'"
alias reflector_update="sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak \
         && sudo reflector --verbose --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias logoff="kill -9 -1"
alias chcaps="setxkbmap -option \"caps:swapescape\""
alias chback="setxkbmap -option "
alias rmpv="mpv --input-ipc-server=/tmp/mpvsocket"
alias ampv="mpv --no-video"
alias ympv="mpv --no-config --slang=en -ytdl-raw-options=write-auto-sub=,sub-lang=en"
alias ytdl="youtube-dl --write-auto-sub --sub-lang en"

# aliases just to avoid Gtk error
# alias evince="noerr evince"

# Abbreviations
# if not set -q abbrs_initialized
#   set -U abbrs_initialized
#   echo -n 'Setting abbreviations...'

abbr rs 'reset'
abbr ssn 'shutdown now'
abbr ne 'noerr'
abbr dwn '~/Downloads'
abbr mus '~/Music'
abbr dcs '~/Documents'

abbr pi 'sudo pacman -S'
abbr pu 'pacman -Syy'
abbr pq 'pacman -Qs'
abbr pr 'sudo pacman -Rns'

abbr sup 'sudo updatedb'
abbr sct 'sudo systemctl'
abbr bt 'baredot'
abbr clipb 'xclip -selection clipboard'
abbr cap 'capture'

abbr cl 'git clone'
abbr gs 'git status'
abbr gA 'git add .'
abbr ga 'git add'
abbr gP 'git push -u origin master'
abbr gp 'git push'
abbr gc 'git commit -m "'

abbr cf 'nvim ~/.config/fish/config.fish'
abbr cnv 'nvim ~/.config/nvim/init.vim'
abbr ccm 'nvim ~/.config/compton.conf'
abbr ci3 'nvim ~/.config/i3/config'
abbr ytd 'youtube-dl'
# echo -n 'Done'
# end

# fish_vi_key_bindings
fish_default_key_bindings
#Swap CapsLock and Escape
chcaps

# Event listener functions
function dostuff --on-event fish_prompt
    pwd >/tmp/whereami
end


# Colors
set default (tput sgr0)
set red (tput setaf 1)
set green (tput setaf 2)
set purple (tput setaf 5)
set orange (tput setaf 9)
# "Less" colors for man pages
set -gx PAGER less
# Begin blinking
set -gx LESS_TERMCAP_mb $red
# Begin bold
set -gx LESS_TERMCAP_md $orange
# End mode
set -gx LESS_TERMCAP_me $default
# End standout-mode
set -gx LESS_TERMCAP_se $default
# Begin standout-mode - nfo box
set -gx LESS_TERMCAP_so $purple
# End underline
set -gx LESS_TERMCAP_ue $default
# Begin underline
set -gx LESS_TERMCAP_us $green

source ~/.cache/wal/colors.fish
wal -enqi (cat ~/.cache/wal/wal)
