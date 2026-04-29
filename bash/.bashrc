# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# Exports
export TERMINAL=alacritty
export TERM="xterm-256color"
# export PAGER="bat"
export MANPAGER="bat -l man -p"
export VISUAL="nvim"
export EDITOR="$VISUAL"

# AniCLI Settings
export ANI_CLI_MODE=dub
export ANI_CLI_QUALITY=best
alias anime="ani-cli"

# Wikiman
source /usr/share/wikiman/widgets/widget.bash

# starship
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init bash)"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# eza
alias ls="eza -l --color-scale=all --icons=always --group-directories-first --git --git-repos --time-style '+%_d %b %y %_I.%M %p'"
alias la="eza -l --color-scale=all --icons=always --group-directories-first --git --git-repos --time-style '+%_d %b %y %_I.%M %p' -a"
alias ll="eza -l --color-scale=all --icons=always --group-directories-first --git --git-repos --time-style '+%_d %b %y %_I.%M %p' --total-size -a"

# nvim
alias v="nvim"

# lazygit
alias lg="lazygit"

# # Created by `pipx` on 2026-01-31 14:57:36
# export PATH="$PATH:/home/idk/.local/bin"
# . "$HOME/.cargo/env"
