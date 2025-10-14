# Personal Development Environment

Complete dotfiles and provisioning scripts for macOS development environment.

## What's Included

**Tools & Applications:**
- tmux, fzf, zoxide, neovim, zed, git
- Oh My Zsh, Powerlevel10k, zsh-syntax-highlighting
- NVM (Node Version Manager)
- JetBrains Mono & Commit Mono Nerd Fonts

**Configuration Files:**
- Zsh (aliases, functions, PATH)
- Git (user info, aliases)
- Tmux (keybindings, plugins, Gruvbox theme)
- Neovim, Zed, Ghostty
- Custom scripts (tmux-sessionizer, ready-tmux)

## Fresh Mac Setup

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone this repository
```bash
git clone <your-repo-url> ~/env-provision
cd ~/env-provision
```

### 3. Install dependencies
```bash
./runs/00-install-dependencies
```
This installs all required tools, fonts, and frameworks.

### 4. Symlink configurations
```bash
./run
```
This symlinks all config files to their proper locations.

### 5. Restart terminal
Close and reopen your terminal to load the new configuration.

### 6. Configure Powerlevel10k (optional)
```bash
p10k configure
```

## How It Works

All config files in this repo are **symlinked** to your home directory. This means:
- Edit files in `~/env-provision` → changes apply immediately
- Your home directory stays clean (no duplicate configs)
- Easy to version control and sync across machines

**Structure:**
```
env-provision/
├── .zshrc              → ~/.zshrc
├── .config/
│   ├── git/            → ~/.config/git/
│   ├── tmux/           → ~/.config/tmux/
│   ├── nvim/           → ~/.config/nvim/
│   ├── zed/            → ~/.config/zed/
│   └── ghostty/        → ~/.config/ghostty/
└── .local/
    ├── scripts/        → ~/.local/scripts/
    └── vaults/         → ~/.local/vaults/
```

## Making Changes

1. Edit any config file in `~/env-provision`
2. Changes apply immediately (symlinks)
3. Commit and push to keep in sync

## Adding New Configs

To add new tools/configs:
1. Add config files to `.config/` or `.local/`
2. Update `runs/01-symlink-configs` to include the new directory
3. Add dependencies to `runs/00-install-dependencies` if needed

## Scripts

- **00-install-dependencies** - Install all tools/dependencies (run once)
- **01-symlink-configs** - Symlink all config files (run via `./run`)
- **02-refresh-tmux-plugins** - Clean and reinstall tmux plugins
- **run** - Main script that executes all numbered scripts in order

## Customization

**Work-specific paths:** Edit `.local/scripts/tmux-sessionizer` to add your project directories.

**Fonts:** Zed and Ghostty configs reference JetBrains Mono and Commit Mono Nerd Fonts (installed automatically).

## Troubleshooting

**Shell errors after install:** Make sure you restarted your terminal.

**Missing fonts in Zed/Ghostty:** Run `brew install --cask font-jetbrains-mono-nerd-font font-commit-mono-nerd-font`

**tmux plugins not loading:** Run `./runs/02-refresh-tmux-plugins` to cleanly reinstall all plugins.
