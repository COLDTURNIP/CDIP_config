# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Basic alaises
alias ls='ls -G'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -l'
alias la='ls -Al'
#alias l='ls -CF'
#alias cp='cp -i'
#alias mv='mv -i'

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
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
  fi


# -*-*-*-*- COLDTURNIP's personal setting -*-*-*-*-

#
# utility function
#
function __cdipAppendPathSavely()
{
    local oriTargetPath="$@"
    if [ ! \( -d $oriTargetPath \) ]; then
        printf "BASH Error: Invalid path %s\n    Please check ~/.bashrc\n" $oriTargetPath
    else
        local targetPath=`echo :$oriTargetPath | sed "s/\/\+$//"`
        export PATH=${PATH/$targetPath/}$targetPath
    fi
}

function __cdipAppendPyPathSavely()
{
    local oriTargetPath="$@"
    if [ ! \( -d $oriTargetPath \) ]; then
        printf "BASH Error: Invalid path %s\n    Please check ~/.bashrc\n" $oriTargetPath
    else
        local targetPath=`echo :$oriTargetPath | sed "s/\/\+$//"`
        export PYTHONPATH=${PYTHONPATH/$targetPath/}$targetPath
    fi
}

function __cdipShowPath()
{
    echo $PATH | sed 's/:/\n/g'
}


#
# settings
#

# Set the $HOME/bin to the first executable path
_targetPath="$HOME/bin"
export PATH=$_targetPath:${PATH/$_targetPath:/}


# set bash to vi mode
  #set -o vi

# set default vi locale
  #alias vi='LANG=en vi'

# history control
  # Save history correctly when using multiple terminals
  # Dont save duplicate lines or blank lines in to history
  export HISTCONTROL=ignoreboth
  export HISTSIZE=1000
  # Append changes to history instead of overwrite full file
  alias exit='history -a && exit'

# cscope env variables
  if [ -f /usr/bin/gvim ]; then
      export CSCOPE_EDITOR=gvim
  else
      export CSCOPE_EDITOR=vim
  fi

# my shell scripts
  . ~/bin/cdipPathUtils.sh
  . ~/bin/cdipSrcUtils.sh

# for Java development
  export JAVA_HOME=/usr/lib/java-1.5.0-sun
  export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

# for Android development
  __cdipAppendPathSavely $HOME/android-sdk-mac_86/platform-tools

# for scala
  #SCALA_HOME=/home/coldturnip/bin/scala-2.8.0.RC1
  #__cdipAppendPathSavely $SCALA_HOME/bin

# for Go language
  # system variables for compiler
  export GOROOT=$HOME/go
  export GOARCH=amd64
  export GOOS=linux
  export GOBIN=$GOROOT/bin
  __cdipAppendPathSavely $GOBIN

  # PYTHONPATH for Go Scons
  #__cdipAppendPyPathSavely $HOME/src/goscons


# for Google Storage client (gsutil)
  #__cdipAppendPathSavely $HOME/bin/gsutil_client


#
# finalize setting
#
unset __cdipAppendPathSavely
unset __cdipAppendPyPathSavely
#unset __cdipShowPath

