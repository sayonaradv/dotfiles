if status is-interactive
end

set -gx EDITOR nvim
set -Ux XDG_CONFIG_HOME $HOME/.config
set -U fish_greeting

alias v="nvim"
alias lg="lazygit"

starship init fish | source
zoxide init fish | source

# uv
fish_add_path "/Users/sulzy/.local/bin"
