# Note:
# - bashrc is source only in non-interactive shells
# - bash_profile is sourced only in login shell, after bashrc
# - profile (current file) is sourced only in login shell, after bash_profile
#   (may also read by Zsh in compatibility mode)
echo 'soucing .profile'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ===============
# PATH management
# =============== {{{
  export PATH=$(
    path_arr=(
      "$HOME/.cargo/bin"
      "$HOME/bin"
      "$PATH"
    );
    IFS=:; echo "${path_arr[*]}"
  )
# }}}


# ====================
# 3rd Party Tools
# ==================== {{{
  # for Python
    [[ -d "$HOME/.pyenv" ]] && export PYENV_ROOT="$HOME/.pyenv"
# }}}
