# Bootstrap Zinit. A failed installation must not prevent the rest of the config loading.
if [[ ! -r "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
    if (( $+commands[git] )) &&
        command mkdir -p "$HOME/.local/share/zinit" &&
        command chmod g-rwX "$HOME/.local/share/zinit" &&
        command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"; then
        print -P '%F{green}Zinit installed.%f'
    else
        print -u2 'Zinit installation failed; skipping plugins.'
    fi
fi

setopt correct               # autocorrect minor dir typos
setopt histignorealldups     # no duplicate history
setopt hist_ignore_space     # omit commands prefixed with a space from history
setopt share_history         # share history between shells
setopt extended_glob         # advanced globbing
setopt interactivecomments   # allow comments in interactive shell

# History size
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# Keep PATH entries unique, including when this file is sourced again.
typeset -U path PATH
export PIPX_BIN_DIR="$HOME/.local/bin"
path=("$HOME/.cache/.bun/bin" "$HOME/.opencode/bin" "$HOME/.local/bin" $path)

# Homebrew on Apple Silicon and Intel Macs.
if [[ "$OSTYPE" == darwin* ]]; then
    [[ -d /opt/homebrew/bin ]] && path=(/opt/homebrew/bin $path)
    [[ -d /usr/local/bin ]] && path+=('/usr/local/bin')
fi
export PATH

[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# Starship is optional on machines where it is not installed yet.
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

########################################
# Plugins
########################################

# These options must be set before zsh-nvm loads.
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

if [[ -r "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]] &&
    source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"; then
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    zinit light zdharma-continuum/fast-syntax-highlighting
    zinit light zsh-users/zsh-autosuggestions
    zinit light marlonrichert/zsh-autocomplete
    zinit light zsh-users/zsh-completions

    zinit ice depth=1
    zinit light lukechilds/zsh-nvm
fi

if (( $+commands[lazygit] )); then
    alias lg='lazygit'
fi

# Optional shell integrations, loaded after plugins so their widgets are available.
if (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi

if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# Generate Angular completion once, then source the cache without launching Node.
# Run update-angular-completion after upgrading Angular CLI to refresh it.
update-angular-completion() {
    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
    local temporary_file
    (( $+commands[ng] || $+functions[ng] )) || return 0
    command mkdir -p "$cache_dir" || return 1
    temporary_file=$(command mktemp "$cache_dir/angular-completion.zsh.XXXXXX") || return 1
    if ng completion script > "$temporary_file" && [[ -s "$temporary_file" ]] &&
        command zsh -n "$temporary_file"; then
        command mv -f "$temporary_file" "$cache_dir/angular-completion.zsh"
    else
        command rm -f "$temporary_file"
        return 1
    fi
}

if [[ ! -r "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/angular-completion.zsh" ]]; then
    update-angular-completion
fi
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/angular-completion.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/angular-completion.zsh"
fi
