# dotfiles

My personal Linux dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## System

| Component       | Software                                                    |
| --------------- | ----------------------------------------------------------- |
| Window Manager  | [Hyprland](https://hyprland.org/)                           |
| Shell           | [Zsh](https://www.zsh.org/) + [Zinit](https://github.com/zdharma-continuum/zinit) |
| Terminal        | [Kitty](https://sw.kovidgoyal.net/kitty/) / [Ghostty](https://ghostty.org/) |
| Bar / Shell UI  | [Noctalia](https://github.com/noctalia-dev/noctalia)        |
| Prompt          | [Starship](https://starship.rs/)                            |
| Browser         | [Brave](https://brave.com/)                                 |
| Editor          | [VS Code](https://code.visualstudio.com/)                   |
| File Manager    | [Dolphin](https://apps.kde.org/dolphin/)                    |
| GTK Theme       | Adwaita Dark                                                |
| Icon Theme      | [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) |
| Qt Theming      | qt5ct / qt6ct (Catppuccin Mocha)                            |
| Font            | JetBrainsMono Nerd Font                                     |
| Clipboard       | [cliphist](https://github.com/sentriz/cliphist) + wl-clipboard |
| Lock Screen     | [hyprlock](https://github.com/hyprwm/hyprlock)              |

## Directory Structure

Each top-level directory is a Stow package. The internal paths mirror `$HOME`, so Stow creates symlinks in the right places automatically.

```
dotfiles/
├── chrome-electron-flags/   # Wayland/VA-API flags for Brave, Chrome, Electron, VS Code
├── ghostty/                 # Ghostty terminal config
├── gtk-3.0/                 # GTK3 dark theme settings
├── hypr/                    # Hyprland config (hyprland.lua)
├── kitty/                   # Kitty terminal config
├── noctalia/                # Noctalia shell UI (bar, launcher, settings, colors)
├── qt5ct/                   # qt5ct theming (Catppuccin Mocha)
├── qt6ct/                   # qt6ct theming
├── starship/                # Starship prompt config
├── wallpapers/              # Wallpapers
└── zsh/                     # .zshrc
```

> **Note:** Hyprland 0.55 uses `hypr/.config/hypr/hyprland.lua`. Machine-specific monitor rules live in ignored `hypr/.config/hypr/monitors.lua`.

## Installation

### Dependencies (Arch)

```bash
# Core
sudo pacman -S stow hyprland hyprlock zsh kitty starship cliphist wl-clipboard papirus-icon-theme qt5ct qt6ct dolphin

# AUR
yay -S ghostty noctalia-shell ttf-jetbrains-mono-nerd brave-bin nwg-displays
```

### Prerequisites

Install [GNU Stow](https://www.gnu.org/software/stow/):

```bash
sudo pacman -S stow
```

### Clone & Stow

```bash
git clone https://github.com/kamtechie/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Stow everything at once
stow chrome-electron-flags ghostty gtk-3.0 hypr kitty noctalia qt5ct qt6ct starship zsh

# Or stow individual packages, e.g.:
stow hypr
stow zsh
```

Stow will create symlinks from `~/.config/...` (and `~/.zshrc`) pointing into this repo.

### Monitor Configuration

Hyprland 0.55 configures displays with `hl.monitor({ ... })`. This repo safely loads `~/.config/hypr/monitors.lua` from `hyprland.lua` and falls back to automatic placement if the file is missing.

`monitors.lua` is gitignored because it is machine-specific. Example:

```lua
hl.monitor({ output = "DP-1", mode = "2560x1440@59.95", position = "0x0", scale = 1.0 })
```

See the [Hyprland monitor docs](https://wiki.hypr.land/Configuring/Basics/Monitors/) for the Lua syntax.

## Zsh Plugins

Managed with Zinit, auto-installed on first shell launch:

- `zdharma-continuum/fast-syntax-highlighting`
- `zsh-users/zsh-autosuggestions`
- `marlonrichert/zsh-autocomplete`
- `zsh-users/zsh-completions`
- `lukechilds/zsh-nvm` (lazy-loaded, `NVM_AUTO_USE=true`)
