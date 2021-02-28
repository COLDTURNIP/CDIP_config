# Note:
# - zshenv is sourced every shell initialization
#   (thus it should only include envvar-related settings)
# - zprofile is sourced only in login shell, before zshrc
# - zshrc (current file) is source in every interactive shells
# - zlogin is sourced only in login shell, after zshrc

# =========================
# PATH management utilities
# ========================= {{{
  __append_path()
  {
    while IFS=":" read -rA path_array; do
      for entry in "${path_array[@]}" ; do
        [[ "$entry" == "$1" ]] && return
      done
    done <<< $PATH
    export PATH="$1:$PATH"
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
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  __try_source_script "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

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

  HISTFILE="${HOME}/.histfile"
  HISTSIZE=10000
  SAVEHIST=10000
  setopt HIST_IGNORE_ALL_DUPS

  setopt NO_BG_NICE

  bindkey -e # emacs-mode command line editing
  zstyle :compinstall filename "${HOME}/.zshrc"

  # user profile
  #source "${HOME}/.profile"

# }}} Pre Initialization

# ===============
# Plugin Settings
# =============== {{{

  # for romkatv/powerlevel10k
  # To customize prompt, run `p10k configure`
  __try_source_script "$HOME/.p10k.zsh"
# }}} Plugin Settings


# ===============================
# Plugin Framework Initialization
# =============================== {{{
  [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]] && source "${ZIM_HOME}/zimfw.zsh" init -q
  source "${ZIM_HOME}/init.zsh"

  # Plugin Post Initialization {{{
    # for zsh-users/zsh-history-substring-search
      # Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # Bind up and down keys
      zmodload -F zsh/terminfo +p:terminfo
      if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
        bindkey ${terminfo[kcuu1]} history-substring-search-up
        bindkey ${terminfo[kcud1]} history-substring-search-down
      fi

      bindkey '^P' history-substring-search-up
      bindkey '^N' history-substring-search-down
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
  # }}}
# }}} Plugin Framework Initialization


# ===================
# Post Initialization
# =================== {{{
  # returning command and folder completion when line is empty
  blanktab() { [[ $#BUFFER == 0 ]] && CURSOR=3 zle list-choices || zle expand-or-complete }
  zle -N blanktab && bindkey '^I' blanktab

  # alias
  __try_source_script "$HOME/.aliases"
  __try_source_script "$HOME/.zsh_alias"

  # keyboard six-key
  bindkey "\e[1~" beginning-of-line
  bindkey "\e[3~" delete-char
  bindkey "\e[4~" end-of-line
  # Bind special keys according to readline configuration
  #eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)" > /dev/null
  # Bind key for Mac
  #bindkey "^[[H" beginning-of-line
  #bindkey "^[[F" end-of-line

  # show time spent for long-runing command (>30 sec)
  export REPORTTIME=30
# }}} Post Initialization


# ==============================
# PATH and 3rd Party Shell Tools
# ============================== {{{
  # Note:
  # - only configuration for interactive shell goes here
  # - PATH managed in .zshenv
  # - shell-level tool initialization in .zlogin

  # Set color for less and man page
    #__try_source_script "$HOME/.sh_manpage_color"

  # for direnv
    #( which direnv 2>&1 >/dev/null ) && eval "$(direnv hook zsh)"

  # for Python
    # PYENV_ROOT defined in .zprofile because of need of non-needed shells
    #if [[ -d "$PYENV_ROOT" ]]; then
    #  __must_append_path "$PYENV_ROOT/bin"
    #  eval "$(pyenv init -)"
    #  eval "$(pyenv virtualenv-init -)"
    #fi

  # for Ruby
    #__try_source_script "$HOME/.rvm/scripts/rvm"
    #( which rbenv 2>&1 >/dev/null) && eval "$(rbenv init - zsh)"

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
    unfunction __try_source_script
    unfunction __try_append_path
    unfunction __must_append_path
    unfunction __append_path
  # }}}
# }}}
