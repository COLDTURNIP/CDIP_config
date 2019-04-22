# initialization
if [[ -x $(which emacs) ]]
then
    export EDITOR="emacs"
elif [[ -x $(which vim) ]]
then
    export EDITOR="vim"
fi
export USE_EDITOR=${EDITOR}
export VISUAL=${EDITOR}
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt NO_BG_NICE
bindkey -e # emacs-mode command line editing
zstyle :compinstall filename "${HOME}/.zshrc"
export EDITOR="vim"
export ZPLUG_HOME="${HOME}/.zplug"

# user profile
source "${HOME}/.profile"

# zplug initialization
#[[ ! -f ${ZPLUG_HOME}/init.zsh ]] && git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
source "${ZPLUG_HOME}/init.zsh"

# zplug self-management
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# zplug plugins
zplug "mafredri/zsh-async", from:github, defer:0
zplug "lib/completion", from:oh-my-zsh
#zplug "lib/history", from:oh-my-zsh
#zplug "lib/key-bindings", from:oh-my-zsh
#zplug "lib/termsupport", from:oh-my-zsh
zplug 'hlissner/zsh-autopair', defer:2
zplug 'zdharma/fast-syntax-highlighting', defer:2, hook-load:'FAST_HIGHLIGHT=()'

# zsh startup speed debugging
# (need to install python-psutil: pip install psutil)
zplug "paulmelnikow/zsh-startup-timer"

# theme
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  time
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  pyenv
  golang
  rust
  node
  docker
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_USER_PREFIX=''
SPACESHIP_USER_SUFFIX=''
SPACESHIP_HOST_SHOW=always
SPACESHIP_HOST_PREFIX='@'
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX='['
SPACESHIP_TIME_SUFFIX=']'
SPACESHIP_DIR_PREFIX=' '
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_LOCK_SYMBOL='(!)'
SPACESHIP_CHAR_SYMBOL='» '
zplug 'denysdovhan/spaceship-prompt', use:spaceship.zsh, from:github, as:theme

# zplug finalize
#zplug check || zplug install
zplug load

# zsh misc settings
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



# set $PATH
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


  # Set color for less and man page
  __sourcingConfigSafely ${HOME}/.sh_manpage_color

  # OSX only: correct some colors for iTerm2
  __sourcingConfigSafely ${HOME}/.iterm2_palette.sh

  # Import my script functions
  __sourcingConfigSafely ${HOME}/.zsh/plugin-setup.zsh
  __sourcingConfigSafely ${HOME}/bin/cdipPathUtils.sh
  __sourcingConfigSafely ${HOME}/bin/cdipSrcUtils.sh

  # for ${HOME}/bin
    __appendPathSafely ${HOME}/bin

  # for Perforce version control system
    #export P4CONFIG='.p4settings'
    #export P4EDITOR=vim
    #export P4CLIENT=git-p4

  # direnv
    if which direnv 2>&1 >/dev/null ; then
        eval "$(direnv hook zsh)"
    else
        echo "ZSH Warning: direnv is not installed."
    fi

  # for Java development
    #export JAVA_HOME=/usr/lib/java-1.5.0-sun
    #export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

  # for Android development
    #__appendPathSafely ${HOME}/tools/adt-bundle-mac-x86_64/sdk/platform-tools
    #__appendPathSafely ${HOME}/tools/adt-bundle-mac-x86_64/sdk/tools

  # for scala
    #SCALA_HOME=/home/coldturnip/bin/scala-2.8.0.RC1
    #__appendPathSafely $SCALA_HOME/bin

  # for Go language
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
    export PYENV_ROOT="/usr/local/opt/pyenv"
    #__appendPathSafely ${PYENV_ROOT}/bin
    if which pyenv > /dev/null; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi

  # for Ruby
    # RVM
    # note: shell function sourcing is moved to .zlogin
    #__appendPathSafely "${HOME}/.rvm/bin" # Add RVM to PATH for scripting

  # for Please build system
    # https://please.build
    source <(plz --completion_script)


  # end set $PATH
  unfunction __appendPathSafely
  unfunction __sourcingConfigSafely
