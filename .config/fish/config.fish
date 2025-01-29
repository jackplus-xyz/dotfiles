if status is-interactive
    # Commands to run in interactive sessions can go here
    # enable vi cursor in Ghostty
    if string match -q -- '*ghostty*' $TERM
        set -g fish_vi_force_cursor 1
    end
end

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -x PATH $HOME/.cargo/bin $PATH
set -U fish_greeting ""
set -gx hydro_symbol_prompt ">"
set -gx hydro_multiline true
set -gx fish_prompt_pwd_dir_length 16

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual line

# eza aliases
alias ls='eza'
alias la='ls -a'
alias ll='ls -la'

# navigation aliases
alias ..='cd ..'
alias ...='cd ../..'

# utils aliases
alias cat='bat'
alias cl='clear'
alias n='nvim'
alias nv='neovide'
alias lg='lazygit'
alias yy='yazi'
alias love='/Applications/love.app/Contents/MacOS/love'
alias grep='grep --color=auto'
alias zj='zellij'
alias h='hx'

# Environment variables
set -gx EDITOR hx
# set -gx FZF_DEFAULT_OPTS "--preview 'bat --color=always {}' --bind 'enter:execute(nvim {})'"
# set -gx FZF_DEFAULT_COMMAND "fd --type f"

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path $PNPM_HOME

zoxide init fish | source

function fish_title
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l repo_name (basename "$PWD")
        set -l branch_name (git branch --show-current 2>/dev/null)
        if test -n "$branch_name"
            echo "$repo_name $branch_name"
        else
            echo "$repo_name"
        end
        return
    end

    echo $PWD
end

# function starship_transient_prompt_func
#     starship module character
# end
starship init fish | source
# enable_transience
