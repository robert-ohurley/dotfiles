# Dotfiles

This repository contains my personal configuration files for various applications. Feel free to use them as you will.

## Included Configurations

- **Alacritty**
- **Git**
- **npm**
- **nvim**
- **Starship**
- **tmux**
- **zsh**

## Installation

To use these dotfiles on your system, follow these steps:

1. **Clone the repository**:
   ```
   git clone https://github.com/robert-ohurley/dotfiles $HOME
2. **Stow files:**
   Use GNU stow to symlink all files into the appropriate directories (if your configured locations match this file structure)

   ```bash
   cd $HOME/dotfiles/
   stow -v -t $HOME/.config config
   ```
