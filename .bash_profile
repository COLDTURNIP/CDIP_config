homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
