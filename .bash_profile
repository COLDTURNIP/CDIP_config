echo 'sourcing .bash_profile'
# Note:
# - bashrc is source only in non-interactive shells
# - bash_profile (current file) is sourced only in login shell, after bashrc
# - profile is sourced only in login shell, after bash_profile
#   (may also read by Zsh in compatibility mode)

# ====================
# Basic Setup
# ==================== {{{
  homebrew=/usr/local/bin:/usr/local/sbin
  [[ -f $HOME/.bashrc ]] && source $HOME/.bashrc
# }}}
