# ====================
# Zsh Built-in Variables
# ==================== {{{
fpath=(${HOME}/.zsh/completion $fpath)

# =========================
# PATH management utilities
# ========================= {{{
  __append_path()
  {
    while IFS=":" read -rA path_array; do
      for entry in "${path_array[@]}" ; do
        if [[ "$entry" == "$new_entry" ]]; then
          >&2 echo "error while appending PATH: \"$new_entry\" is already exist"
          return 1
        fi
      done
    done <<< $PATH
    export PATH="$new_entry:$PATH"
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

  __try_append_path ${HOME}/bin
# }}}

# ====================
# Zim Plugin Framework
# ==================== {{{
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
# }}}

# ====================
# 3rd Party Tools
# ==================== {{{
# }}}

# =================
# Utilities Cleanup
# ================= {{{
  # performed at the end of .zshrc
# }}}
