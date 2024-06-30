# Dotfiles

This repository contains my personal configuration files for various applications. Feel free to use them as you will.

## Included Configurations

- **Alacritty**: we love configuration as code.
- **Git**: VCS config.
- **npm**: why is this here?
- **nvim**: <3.
- **Starship**: Aesthetic af.
- **tmux**: Yes please.
- **zsh**: Why not?.

## Installation

To use these dotfiles on your system, follow these steps:

1. **Clone the repository**:
   ```
   git clone https://github.com/robert-ohurley/dotfiles $HOME
2. **Stow files:**
   Use GNU stow to symlink all files into the appropriate directories (or don't if your configured locations don't match this file structure)

   ```bash
   cd $HOME/dotfiles/
   stow -v -t $HOME/.config config
   ```
