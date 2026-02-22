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
├── hypr/                    # Hyprland config (hyprland.conf, workspaces.conf)
├── kitty/                   # Kitty terminal config
├── noctalia/                # Noctalia shell UI (bar, launcher, settings, colors)
├── qt5ct/                   # qt5ct theming (Catppuccin Mocha)
├── qt6ct/                   # qt6ct theming
├── starship/                # Starship prompt config
├── wallpapers/              # Wallpapers
└── zsh/                     # .zshrc
```

> **Note:** `hypr/.config/hypr/monitors.conf` is gitignored — it is machine-specific. Create your own based on `hyprland.conf`'s `source` directive.

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

### monitors.conf

Hyprland sources `~/.config/hypr/monitors.conf` for display configuration. This file is gitignored since it is machine-specific.

The easiest way to generate it is with [nwg-displays](https://github.com/nwg-piotr/nwg-displays), a GUI tool that writes Hyprland monitor config for you:

```bash
nwg-displays
```

Alternatively, write it manually:

```bash
# Example
echo "monitor=DP-1,1920x1080@144,0x0,1" > ~/.config/hypr/monitors.conf
```

See the [Hyprland monitors docs](https://wiki.hyprland.org/Configuring/Monitors/) for syntax.

## Zsh Plugins

Managed with Zinit, auto-installed on first shell launch:

- `zdharma-continuum/fast-syntax-highlighting`
- `zsh-users/zsh-autosuggestions`
- `marlonrichert/zsh-autocomplete`
- `zsh-users/zsh-completions`
- `lukechilds/zsh-nvm` (lazy-loaded, `NVM_AUTO_USE=true`)
