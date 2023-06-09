source "$HOME/.config/zsh/aliases"

autoload -Uz compinit
compinit
zmodload  zsh/complist

bindkey 'jk' vi-cmd-mode
bindkey 'kj' vi-cmd-mode

bindkey -M menuselect j vi-backward-char
bindkey -M menuselect k vi-down-line-or-history
bindkey -M menuselect l vi-up-line-or-history
bindkey -M menuselect \; vi-forward-char

bindkey -a j vi-backward-char
bindkey -a k vi-down-line-or-history
bindkey -a l vi-up-line-or-history
bindkey -a \; vi-forward-char

bindkey \' autosuggest-accept

autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using
setopt PUSHD_SILENT

bindkey -v
export KEYTIMEOUT=1

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
export FZF_DEFAULT_OPTS='--layout=reverse'
export FZF_TMUX_OPTS='-p 80%'
