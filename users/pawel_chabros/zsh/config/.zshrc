source "$HOME/.config/zsh/aliases"

autoload -Uz compinit
zmodload zsh/complist

bindkey -M menuselect j vi-backward-char
bindkey -M menuselect k vi-down-line-or-history
bindkey -M menuselect l vi-up-line-or-history
bindkey -M menuselect \; vi-forward-char

bindkey 'jk' vi-cmd-mode
bindkey 'kj' vi-cmd-mode

bindkey -a j vi-backward-char
bindkey -a k vi-down-line-or-history
bindkey -a l vi-up-line-or-history
bindkey -a \; vi-forward-char

bindkey ' ;' autosuggest-accept

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using
setopt PUSHD_SILENT

bindkey -v
export KEYTIMEOUT=1

export FZF_DEFAULT_OPTS='--layout=reverse'
export FZF_TMUX_OPTS='-p 80%'
