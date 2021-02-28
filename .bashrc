echo 'sourcing bashrc'
# Note:
# - bashrc (current file) is source only in non-interactive shells
# - bash_profile is sourced only in login shell, after bashrc
# - profile is sourced only in login shell, after bash_profile
#   (may also read by Zsh in compatibility mode)

# If not running interactively, don't do anything
[ -z "${PS1}" ] && return


# =========================
# PATH management utilities
# ========================= {{{
  __append_path()
  {
    while IFS=":" read -ra path_array; do
      for entry in "${path_array[@]}" ; do
        [[ "$entry" == "$new_entry" ]] && return
      done
    done <<< $PATH
    export PATH="$new_entry:$PATH"
  }

  __try_append_path()
  {
    local new_entry=$(echo $1 | sed 's#/*$##')
    [[ -d "$new_entry" ]] && __append_path "$new_entry"
  }

  __must_append_path()
  {
    local new_entry=$(echo $1 | sed 's#/*$##')
    if [[ -d "$new_entry" ]]; then
      __append_path "$new_entry"
      return $?
    else
      >&2 echo "error while appending PATH: \"$new_entry\" is not a valid directory"
      return 1
    fi
  }

  __try_source_script()
  {
    [[ -s "$1" ]] && source "$1"
  }

  __try_append_path ${HOME}/bin 2>&1 >/dev/null || true
# }}}


# ==================
# Pre Initialization
# ================== {{{
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  if [[ -x $(which nvim) ]]; then
      export EDITOR="nvim"
  elif [[ -x $(which vim) ]]; then
      export EDITOR="vim"
  elif [[ -x $(which emacs) ]]; then
      export EDITOR="emacs"
  fi
  export USE_EDITOR=${EDITOR}
  export VISUAL=${EDITOR}

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

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "${TERM}" in
      xterm-color|xterm-256color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  #force_color_prompt=yes

  if [ -n "${force_color_prompt}" ]; then
      if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
      else
      color_prompt=
      fi
  fi

  if [ "${color_prompt}" = yes ]; then
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
      PS1='\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "${TERM}" in
  xterm*|rxvt*)
      PS1="\[\e]0;\u@\h: \w\a\]${PS1}"
      ;;
  *)
      ;;
  esac
# }}}


# ===================
# Post Initialization
# =================== {{{
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
  alias md='mkdir'

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
# }}}


# ==============================
# PATH and 3rd Party Shell Tools
# ============================== {{{
  # my shell scripts
    __try_source_script $HOME/bin/cdipPathUtils.sh
    __try_source_script $HOME/bin/cdipSrcUtils.sh

  # Set color for less and man page
    #__try_source_script "$HOME/.sh_manpage_color"

  # for direnv
    #( which direnv 2>&1 >/dev/null ) && eval "$(direnv hook bash)"

  # for Python
    #[[ -d "$HOME/.pyenv" ]] && export PYENV_ROOT="$HOME/.pyenv"
    #if [[ -d "$PYENV_ROOT" ]]; then
    #  __must_append_path "$PYENV_ROOT/bin"
    #  eval "$(pyenv init -)"
    #  eval "$(pyenv virtualenv-init -)"
    #fi

  # for Ruby
    #__try_source_script "$HOME/.rvm/scripts/rvm"
    #( which rbenv 2>&1 >/dev/null) && eval "$(rbenv init - bash)"

  # for Java development
    #export JAVA_HOME=/usr/lib/java-1.5.0-sun
    #export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

  # for Android development
    #__try_append_path ${HOME}/tools/adt-bundle-mac-x86_64/sdk/platform-tools
    #__try_append_path ${HOME}/tools/adt-bundle-mac-x86_64/sdk/tools

  # for scala
    #SCALA_HOME=/home/coldturnip/bin/scala-2.8.0.RC1
    #__try_append_path $SCALA_HOME/bin

  # for Go
    # system variables for compiler
    #export GOROOT=/usr/local/opt/go/libexec
    #export GOHOSTARCH=amd64
    #export GOHOSTOS=darwin
    #export GOARCH=amd64
    #export GOOS=darwin
    #export GOPATH=${HOME}
    #export GOBIN=${HOME}/bin
    #export GO15VENDOREXPERIMENT=1
    #__try_append_path ${GOBIN}

  # for Rust
    #__try_append_path "$HOME/.cargo/bin"

# }}} PATH and 3rd Party Shell Tools


# ==================
# End of Shell Initialization
# ================== {{{
  # destroy PATH management utils (defineded in .zprofile) {{{
    unset -f __try_source_script
    unset -f __try_append_path
    unset -f __must_append_path
    unset -f __append_path
  # }}}
# }}}
