
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

setopt correct               # autocorrect minor dir typos
setopt histignorealldups     # no duplicate history
setopt share_history         # share history between shells
setopt extended_glob         # advanced globbing
setopt interactivecomments   # allow comments in interactive shell

# History size
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# Add brew to PATH on macOS
# This needs to be done now since Starship on Mac is installed via Homebrew
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=/opt/homebrew/bin:$PATH
fi

# Starship prompt
eval "$(starship init zsh)"

########################################
# Plugins
########################################

# Fast syntax highlighting (better than zsh-users)
zinit light zdharma-continuum/fast-syntax-highlighting

# Autosuggestions (fish-like)
zinit light zsh-users/zsh-autosuggestions

# Autocomplete 
zinit light marlonrichert/zsh-autocomplete

# Completions (massive completion set)
zinit light zsh-users/zsh-completions

# NVM (lazy-loaded, fast)
zinit ice depth=1
zinit light lukechilds/zsh-nvm
export NVM_AUTO_USE=true