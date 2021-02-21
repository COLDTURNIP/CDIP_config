# ==================
# Pre Initialization
# ================== {{{
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

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
  [[ -f "${HOME}/.p10k.zsh" ]] && source "${HOME}/.p10k.zsh"
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
  [[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"
  [[ -f "${HOME}/.zsh_alias" ]] && source "${HOME}/.zsh_alias"

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
  # PATH management utils {{{
    __appendPathSafely()
    {
        local oriTargetPath="$@"
        if [ ! \( -d ${oriTargetPath} \) ]; then
            printf "ZSH Error: Invalid path %s\n    Please check ~/.zshrc\n" ${oriTargetPath}
        else
            local targetPath=$(echo ${oriTargetPath} | sed "s/\/\+$//")
            export PATH=${targetPath}:${PATH/$targetPath/}
        fi
    }

    __sourcingConfigSafely()
    {
        if [[ -s $@ ]]; then
            source $@
        else
            printf "ZSH Error: Invalid sourcing path %s\n    Please check ~/.zshrc\n" $@
        fi
    }
  # }}}

  # Set color for less and man page
    __sourcingConfigSafely ${HOME}/.sh_manpage_color

  # Import my script functions
    __sourcingConfigSafely ${HOME}/.zsh/plugin-setup.zsh
    #__sourcingConfigSafely ${HOME}/bin/cdipPathUtils.sh
    #__sourcingConfigSafely ${HOME}/bin/cdipSrcUtils.sh

  # for ${HOME}/bin
    __appendPathSafely ${HOME}/bin

  # for Perforce version control system
    #export P4CONFIG='.p4settings'
    #export P4EDITOR=vim
    #export P4CLIENT=git-p4

  # for direnv
    #[[ -x $(which direnv 2>&1 >/dev/null) ]] && eval "$(direnv hook zsh)"

  # for Java development
    #export JAVA_HOME=/usr/lib/java-1.5.0-sun
    #export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

  # for Android development
    #__appendPathSafely ${HOME}/tool/adt-bundle-mac-x86_64/sdk/platform-tools
    #__appendPathSafely ${HOME}/tool/adt-bundle-mac-x86_64/sdk/tools

  # for scala
    #SCALA_HOME=/home/coldturnip/bin/scala-2.8.0.RC1
    #__appendPathSafely $SCALA_HOME/bin

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
    #__appendPathSafely ${GOBIN}

  # for Python
    #export PYENV_ROOT="/usr/local/opt/pyenv"
    #__appendPathSafely ${PYENV_ROOT}/bin
    #if which pyenv > /dev/null; then
    #  eval "$(pyenv init -)"
    #  eval "$(pyenv virtualenv-init -)"
    #fi

  # for Ruby
    # RVM
    # note: shell function sourcing is moved to .zlogin
    #__appendPathSafely "${HOME}/.rvm/bin" # Add RVM to PATH for scripting

  # for OCaml
    #__sourcingConfigSafely ${HOME}/.opam/opam-init/init.zsh

  # for Please build system
    # https://please.build
    #source <(plz --completion_script)

  # destroy PATH management utils {{{
    unfunction __appendPathSafely
    unfunction __sourcingConfigSafely
  # }}}
# }}} PATH and 3rd Party Shell Tools
