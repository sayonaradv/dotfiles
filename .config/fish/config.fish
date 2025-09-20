if status is-interactive
end

set -gx EDITOR nvim
set -Ux XDG_CONFIG_HOME $HOME/.config
set -U fish_greeting

alias v="nvim"
alias lg="lazygit"

zoxide init fish | source
