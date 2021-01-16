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

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)
#(cat ~/.urxvt/sequences &)

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias rm='rm -i'

# alias for ssh
alias szulu='ssh -Y turner@zulu.uwyo.edu -t exec bash -l'
alias sshone='ssh -Y turner@shoshone.uwyo.edu'
alias fzulu='sftp turner@zulu.uwyo.edu:tmp'
alias scher='ssh -Y turner@10.212.212.13'
alias fcher='sftp turner@10.212.212.13'
alias suw='ssh -Y turner@uwpa.uwyo.edu -t exec bash -l'
alias fuw='sftp turner@uwpa.uwyo.edu'

# rsync alias for backing up statham to cherokee
alias backup='sudo rsync -rav --delete /home/jordan/ --exclude ".cache" --exclude ".config" --exclude ".local/share/Steam/" --exclude ".local/share/Trash/" --exclude "Documents/ASTR5160/" --exclude ".mozilla" --exclude "tmp/" --exclude "tools/Arduino" --exclude ".gdfuse" --exclude "tools/jre" -e "ssh turner@zulu.uwyo.edu ssh" turner@10.212.212.76:/cherokee1/turner/statham/'

# rsync alias for syncing papers directory from statham to cherokee
alias syncpapers='rsync -a /home/jordan/Documents/papers/ -e "ssh turner@zulu.uwyo.edu ssh" turner@10.212.212.13:/home/turner/papers/' 

# alias for programs
alias s='/usr/bin/subl'
alias e='evince'
alias o='okular'
alias todo='todo.sh'
alias feh='feh --reload 0.5'
alias z='zathura'

alias p='ps aux | grep'
alias f='find . | grep'

# svn alias
alias 5160='cd ~/Documents/ASTR5160/'
alias ci='svn ci'
alias up='svn up'
alias add='svn add'

# command line wifi stuff (for i3)
alias wifiscan='nmcli d wifi list'
alias disconnect='nmcli d disconnect wlp7s0'
alias connect='nmcli d connect wlp7s0'
alias netdisconnect='nmcli c down'
alias netconnect='nmcli c up'

# logout of qtile
alias logout='qtile-cmd -o cmd -f shutdown'

# dual monitor output through hdmi
alias hdmimirror='xrandr --output HDMI1 --mode 1920x1080 --same-as eDP1'
alias hdmioff='xrandr --output HDMI1 --off'
alias hdmisingle='xrandr --output HDMI1 --mode 1920x1080 && xrandr --output eDP1 --off'
alias hdmisingleoff='xrandr --output eDP1 --mode 1366x768 && xrandr --output HDMI1 --off'
alias hdmiabove='xrandr --output HDMI1 --mode 1920x1080 --above eDP1'
alias hdmileft='xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1'
alias hdmiright='xrandr --output HDMI1 --mode 1920x1080 --right-of eDP1'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

export PATH="/home/jordan/.local/bin:$PATH"

# powerline-shell
# function _update_ps1() {
#     PS1=$(powerline-shell $?)
# }

# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

if [ "$USER" == "jordan" ]; then
    export PS1="\[\e[1;31m\]\w\[\e[1;31m\] > \[\e[0m\]"
elif [ "$USER" == "root" ]; then
    export PS1="\[\e[01;36m\]\u \[\e[1;31m\]\w \[\e[1;31m\]> \[\e[0m\]"
fi

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$(CONDA_REPORT_ERRORS=false '/home/jordan/tools/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     \eval "$__conda_setup"
# else
#     if [ -f "/home/jordan/tools/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/jordan/tools/anaconda3/etc/profile.d/conda.sh"
#         CONDA_CHANGEPS1=false conda activate base
#     else
#         \export PATH="/home/jordan/tools/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda init <<<

# export PATH="/home/jordan/tools/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jordan/tools/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jordan/tools/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jordan/tools/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jordan/tools/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

