# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#auto-startX to tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

set -o vi

export PATH=/home/xwav/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/xwav/.local/bin:/home/xwav/.local/bin:/home/xwav/.config/fzf/bin:/home/xwav/.local/bin:/usr/local/go/bin

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;38m\]\u\[\033[01;32m\]@\[\033[01;36m\]\h \[\033[34m\]\w \[\033[35m\]\$(parse_git_branch)\[\033[00m\]$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias lz='lazygit'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias n="newsboat"
alias c="cmus"
alias sd="shutdown now"
alias rb="reboot"
alias rs="systemctl suspend"
alias t="tmux"
alias mc='. /usr/lib/mc/mc-wrapper.sh'
alias bm=". /home/$USER/.config/bashmount/bashmount"
alias nm="nmtui"
alias xr="xrandr --output LVDS-1 --brightness 0.65"

alias v="nvim"
alias h="cht.sh --shell"
alias j="jmtpfs ~/Poco"
alias z="nvim /home/$USER/.bashrc"

alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -aF --color=always"
alias ll="ls -l"
alias grep="grep --color=always"
alias cp="cp -ia"
alias mv="mv -i"
alias rm="rm -i"
alias psg="ps auxw | grep -i "
alias psptree="ps auxwwwf"
alias tree='tree --dirsfirst -F'
alias df="df -hT"
alias du="du -hc"
alias free="free -m"
alias screen="screen -U -l"
alias passgen="< /dev/urandom tr -cd \[:graph:\] | fold -w 32 | head -n 5"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com" 
alias f="fzf --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --bind shift-up:preview-page-up,shift-down:preview-page-down"

# init bare repo for dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

#Git aliases
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gl='git log --oneline'
alias gb='git checkout -b'
alias gd='git diff'

#mount GoogleDrive
mount | grep "${HOME}/GoogleDrive" >/dev/null || /usr/bin/google-drive-ocamlfuse "${HOME}/GoogleDrive" > /dev/null 

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


# set up the pager for syntax hyghlight in terminal
# export PATH=$PATH:/home/xwav/.local/bin
# export PAGER="most"
export BROWSER="brave-browser"
export XTERM="st"
export EDITOR="nvim"


#add keyboard layout to dwm
setxkbmap us,ua -option grp:ctrl_alt_toggle

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# git clone --bare https://www.github.com/xwav/.dotfiles.git $USER_HOME/.dotfiles

# function dotfiles {
#     /usr/bin/git --git-dir=$USER_HOME/.dotfiles/ --work-tree=$USER_HOME $@
#  }
# mkdir -p $USER_HOME/.dotfiles-backup && \

# dotfiles checkout
# if [ $? = 0 ]; then
#   echo "Checked out config.";
#  else
#   echo "Backing up pre-existing dot files.";
# dotfiles checkout 2>&1 | egrep "\s+\."  | awk {'print $1'} | rev | cut -d/ -f2- | rev | xargs -I{} mkdir -p .dotfiles-backup/{}
# dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
# fi;
# dotfiles checkout
# dotfiles config --local status.showUntrackedFiles no

# echo 'alias dotfiles="/usr/bin/git --git-dir=$USER_HOME/.dotfiles/ --work-tree=$USER_HOME"' >> $USER_HOME/.bashrc

# #to init bare repo on your machine see below

# git init --bare $HOME/.dotfiles
# echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"' >> $HOME/.bashrc
# source ~/.bashrc
# dotfiles config --local status.showUntrackedFiles no

#with 'dotfiles' command execute same commands as with git

# dotfiles status
# dotfiles add .vimrc
# dotfiles commit -m "Add vimrc"
# dotfiles remote add origin https://www.github.com/username/repo.git
# dotfiles push origin master



