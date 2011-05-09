# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/coldturnip/.zshrc'

# End of lines added by compinstall


#### Added by COLDTURNIP ####
# proxy setting for ASUS
#export http_proxy="user_name:passwd@addres.to.proxy:port"

# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
# setopt HASH_CMDS		# turns on hashing
setopt ALL_EXPORT
setopt INTERACTIVE_COMMENTS

# Auto complete
setopt AUTO_LIST		# these two should be turned off
setopt AUTO_MENU
setopt MENU_COMPLETE
autoload -U compinit
compinit

zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# Colored complete menu
[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"
zmodload  zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command 'ps -au$USER'

# Kill completion
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:::kill:' menu yes select
zstyle ':completion:::::processes' force-list always
zstyle ':completion::processes' command 'ps -au$USER'

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

# Aliases
source $HOME/.zsh_alias

# Set prompt
autoload -Uz promptinit
promptinit
prompt walters
PS1=$'%{\e[0;37m%}%B%*%b|%{\e[0;33m%}%m:%{\e[0;37m%}%~%(!.#.$) %{\e[00m%}'

# set $PATH
__apendPathSavely()
{
    local oriTargetPath="$@"
    if [ ! \( -d $oriTargetPath \) ]; then
        printf "ZSH Error: Invalid path %s\n    Please check ~/.zshrc\n" $oriTargetPath
    else
        local targetPath=`echo :$oriTargetPath | sed "s/\/\+$//"`
        export PATH=${PATH/$targetPath/}$targetPath
    fi
}

  # for $HOME/bin
    __apendPathSavely $HOME/bin

  # for Java development
    #export JAVA_HOME=/usr/lib/java-1.5.0-sun
    #export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

  # for Android development
    #__apendPathSavely $HOME/tools/android-sdk-linux_x86/platform-tools
    #__apendPathSavely $HOME/tools/android-sdk-linux_x86/tools

  # for scala
    #SCALA_HOME=/home/coldturnip/bin/scala-2.8.0.RC1
    #__apendPathSavely $SCALA_HOME/bin

  # for Go language
    # system variables for compiler
    #export GOROOT=$HOME/go
    #export GOARCH=amd64
    #export GOOS=linux
    #export GOBIN=$GOROOT/bin
    #__apendPathSavely $GOBIN

    # PYTHONPATH for Go Scons
    #__apendPathSavely $HOME/src/goscons


  # for Google Storage client (gsutil)
    #__apendPathSavely $HOME/bin/gsutil_client


  # end set $PATH
  unfunction __apendPathSavely

# Set less options
if [[ -x $(which less) ]]
then
    export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    if [[ -x $(which lesspipe.sh) ]]
    then
	LESSOPEN="| lesspipe.sh %s"
	export LESSOPEN
    fi
fi

# Set default editor
if [[ -x $(which vim) ]]
then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi

# Zsh settings for history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY		# puts timestamps in the history

# Set six-key on keyboard
bindkey "\e[1~" beginning-of-line
bindkey "\e[3~" delete-char
bindkey "\e[4~" end-of-line
# Bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)" > /dev/null
# Bind key for Mac
#bindkey "^[[H" beginning-of-line
#bindkey "^[[F" end-of-line

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

# Zsh spelling correction options
setopt CORRECT

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don’t write over existing files with >, use >! instead
#setopt NOCLOBBER

# Don’t nice background processes
setopt NO_BG_NICE

# Watch other user login/out
watch=notme
export LOGCHECK=60

# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
  if [[ -x `which dircolors` ]]; then
    eval `dircolors -b`
    alias 'ls=ls --color=auto'
  fi
fi

# Command sudo adder: ESC EXC to add sudo at begining
sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
  zle end-of-line
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

# Import my script functions
  #source ~/bin/cdipPathUtils.sh
  #source ~/bin/cdipSrcUtils.sh
