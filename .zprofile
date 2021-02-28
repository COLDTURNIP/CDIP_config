# Note:
# - zshenv is sourced every shell initialization
#   (thus it should only include envvar-related settings)
# - zprofile (current file) is sourced only in login shell, before zshrc
# - zshrc is source in every interactive shells
# - zlogin is sourced only in login shell, after zshrc


# ====================
# 3rd Party Tools
# ==================== {{{
  # for Python
    [[ -d "$HOME/.pyenv" ]] && export PYENV_ROOT="$HOME/.pyenv"
# }}}
