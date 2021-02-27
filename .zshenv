# Note:
# - zshenv (current file) is sourced every shell initialization
#   (thus it should only include envvar-related settings)
# - zlogin is sourced only in login shell
# - zshrc is source in every interactive shells

# ====================
# Zsh Built-in Variables
# ==================== {{{
fpath=(${HOME}/.zsh/completion $fpath)

# ====================
# Zim Plugin Framework
# ==================== {{{
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
# }}}
