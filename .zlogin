# Note:
# - zshenv is sourced every shell initialization
#   (thus it should only include envvar-related settings)
# - zprofile is sourced only in login shell, before zshrc
# - zshrc is source in every interactive shells
# - zlogin (current file) is sourced only in login shell, after zshrc

# ====================
# Zim Plugin Framework
# ==================== {{{
  [[ "${ZIM_HOME}/login_init.zsh" ]] && source "${ZIM_HOME}/login_init.zsh" -q &!
# }}}
