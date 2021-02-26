# ====================
# Basic Setup
# ==================== {{{
  homebrew=/usr/local/bin:/usr/local/sbin
  export PATH="$HOME/.cargo/bin:$homebrew:$PATH"
  if [ -f ~/.bashrc ]; then
      source ~/.bashrc
  fi

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
    [[ -x $(which rbenv 2>/dev/null) ]] && eval "$(rbenv init - bash)"
# }}}
