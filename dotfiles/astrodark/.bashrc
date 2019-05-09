# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

## Color stuff

colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}

man() {
    env LESS_TERMCAP_mb=$'\E[01;37m' \
    LESS_TERMCAP_md=$'\E[01;38;5;37m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;37m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;37m' \
    man "$@"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lx='ls -lX'       # sorts by filetype

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

# pywal colors
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.urxvt/sequences &)

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/turner/tools/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/turner/tools/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/turner/tools/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/turner/tools/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# PATH exports
# for xgterm/iraf
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

export VISUAL=vim

# aliases

# alias for moving around
alias ch1='cd /cherokee1/turner'
alias alma='cd /cherokee1/turner/alma'
alias planet='cd /cherokee1/turner/planetarium'
alias ngvla='cd /cherokee1/turner/ngvla/SSINGMA'
alias qac='cd /cherokee1/turner/ngvla/QAC'
alias legma='cd /cherokee1/turner/legus-alma'
alias lvl='cd /cherokee1/turner/lvl'
alias phangs='cd /cherokee1/turner/phangs'

# alias for ssh
alias szulu='ssh -Y turner@zulu.uwyo.edu -t "exec bash -l"'
alias fzulu='sftp turner@zulu.uwyo.edu:tmp'
alias sshone="ssh -Y turner@shoshone.uwyo.edu -t 'exec bash -l'"
alias scrow="ssh -Y turner@crow.uwyo.edu -t 'exec bash -l'"
alias fcrow='sftp turner@crow.uwyo.edu'
alias sarap="ssh -Y turner@10.48.48.155 -t 'exec bash -l'"
alias suw="ssh -Y turner@uwpa.uwyo.edu -t 'exec bash -l'"
alias fuw='sftp turner@uwpa.uwyo.edu'

# alias for simple web server
alias webserver='python -m http.server'

# alias for starting vnc server
alias startvnc='vnc4server -geometry 1366x768 :1'
alias killvnc='vnc4server -kill :1'

# alias for programs
alias s='subl'
alias e='evince'
alias z='zathura'
alias todo='/home/turner/tools/todo.txt_cli-2.11.0/todo.sh'

# apt-get alias
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias update='sudo apt-get update'
alias aremove='sudo apt-get autoremove'
alias upgrade='sudo apt-get upgrade'

# system alias
alias ..='cd ../'
alias .1='cd ../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias p='ps aux | grep'
alias size='du -sh'
alias f='find . | grep'
alias vncls='ps -ef | grep vnc'
alias hm='how_many "$1"'
alias diff='colordiff'
# force prompt for rm
alias rm='rm -i'

# b/c i always mess up the more command
alias mroe='more'
alias m='more'

