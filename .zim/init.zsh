zimfw() { source /Users/coldturnip/.zim/zimfw.zsh "${@}" }
fpath=(/Users/coldturnip/.zim/modules/git/functions /Users/coldturnip/.zim/modules/utility/functions /Users/coldturnip/.zim/modules/git-info/functions ${fpath})
autoload -Uz git-alias-lookup git-branch-current git-branch-delete-interactive git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw coalesce git-action git-info
source /Users/coldturnip/.zim/modules/environment/init.zsh
source /Users/coldturnip/.zim/modules/git/init.zsh
source /Users/coldturnip/.zim/modules/input/init.zsh
source /Users/coldturnip/.zim/modules/termtitle/init.zsh
source /Users/coldturnip/.zim/modules/utility/init.zsh
source /Users/coldturnip/.zim/modules/powerlevel10k/powerlevel10k.zsh-theme
source /Users/coldturnip/.zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /Users/coldturnip/.zim/modules/completion/init.zsh
source /Users/coldturnip/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/coldturnip/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/coldturnip/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh