# ====================
# Zim Plugin Framework
# ==================== {{{
  [[ "${ZIM_HOME}/login_init.zsh" ]] && source "${ZIM_HOME}/login_init.zsh" -q &!
# }}}


# ====================
# 3rd Party Shell Tools
# ==================== {{{
  # for direnv
    [[ -x $(which direnv 2>/dev/null) ]] && eval "$(direnv hook zsh)"

  # for Python
    export PYENV_ROOT="/usr/local/opt/pyenv"
    if [[ $(which pyenv 2>&1 >/dev/null) ]]; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi

  # for Ruby
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
    [[ -x $(which rbenv 2>/dev/null) ]] && eval "$(rbenv init - zsh)"
# }}}
