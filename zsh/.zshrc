# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

source ~/.config/zsh/key-bindings.zsh
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

# Load zsh-autocomplete on macOS
# TODO: add path for Linux systems
if [[ "$OSTYPE" == "darwin"* ]]; then
  source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
elif [[ "$OSTYPE" == "linux"* ]]; then
  source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh # path from Arch AUR package
fi

# Add brew to PATH on macOS
# This needs to be done now since Starship on Mac is installed via Homebrew
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=/opt/homebrew/bin:$PATH
fi

# End of lines added by compinstall
eval "$(starship init zsh)"

# Conditionally add pipx to PATH if it is installed
if command -v pipx &> /dev/null; then
  export PATH="$PATH:~/.local/bin"
fi

# Conditionally load nvm if it is installed
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
