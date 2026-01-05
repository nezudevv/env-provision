# Claude Code Context: env-provision

## What This Is
Personal dotfiles and provisioning system for macOS development environment. Everything is symlinked from this repo to the user's home directory, making this the single source of truth for all configurations.

**⚠️ IMPORTANT: Always update this claude.md file after making significant changes to the repo structure, scripts, or workflows.**

## Critical Architecture Decisions

### 1. Symlinks, Not Copies
**All** configuration files are **symlinked** to `~/` - never copied. This means:
- Edits in this repo apply immediately (no need to re-run provisioning)
- Home directory stays clean
- Easy version control
- Single source of truth

### 2. Homebrew for Everything
When possible, dependencies are installed via Homebrew (not manual git clones or curl installs):
- Powerlevel10k: `brew install romkatv/powerlevel10k/powerlevel10k`
- zsh-syntax-highlighting: `brew install zsh-syntax-highlighting`
- Node.js (includes npm): `brew install node`
- NVM: `brew install nvm`
- Tools sourced from Homebrew paths in .zshrc (see lines 155, 199-201, 206)

### 3. Numbered Execution Order
Scripts in `runs/` are executed in alphabetical order:
- `00-install-dependencies` - Install all tools/dependencies (run once on fresh Mac)
- `01-symlink-configs` - Symlink all config files
- `02-refresh-tmux-plugins` - Clean and reinstall tmux plugins (fixes plugin detection issues)

## Directory Structure

```
env-provision/
├── claude.md                   # This file - context for Claude Code
├── README.md                   # User-facing setup guide
├── run                         # Main script - executes all numbered scripts
├── .zshrc                      # Complete shell config (252 lines)
├── .gitignore                  # Ignores shared-envs/
│
├── .config/                    # App configurations (all symlinked)
│   ├── git/
│   │   ├── config             # Git config with aliases (co, s, fp)
│   │   └── ignore             # Global gitignore (Claude settings, etc)
│   ├── tmux/tmux.conf         # Tmux with Kanagawa theme, Ctrl-Space prefix
│   ├── zed/                   # Zed editor (vim mode, Kanagawa theme)
│   │   ├── settings.json      # Editor settings, LSP config, Bedrock integration
│   │   ├── keymap.json        # Vim-style keybindings
│   │   └── tasks.json         # Custom tasks (fzf, nvim)
│   ├── ghostty/config         # Terminal config (Kanagawa Dragon, JetBrains Mono)
│   └── nvim/                  # Neovim config with 28 plugins (tracked in this repo)
│
├── .local/                     # User scripts and data
│   ├── scripts/
│   │   ├── tmux-sessionizer   # Fuzzy find projects, create tmux sessions
│   │   └── ready-tmux         # Project-specific tmux initialization
│   └── vaults/                # Obsidian notes (personal knowledge base)
│
├── shared-envs/                # Work-specific env files (gitignored)
│   └── *.env                  # Service environment configs
│
└── runs/                       # Provisioning scripts (executable)
    ├── 00-install-dependencies # Install all tools via Homebrew
    ├── 01-symlink-configs      # Symlink all configs to ~/
    └── 02-refresh-tmux-plugins # Clean and reinstall tmux plugins
```

## Key Files & Their Purpose

### `.zshrc` (Source of Truth)
- **Lines 1-6:** Powerlevel10k instant prompt
- **Lines 12-15:** PATH additions (bin, cargo, local scripts)
- **Lines 17-48:** Git aliases (custom shortcuts)
- **Lines 54-76:** `killport()` function - kills process on port
- **Line 150:** Oh My Zsh plugins (only `git` - syntax highlighting loaded separately)
- **Line 155:** Sources zsh-syntax-highlighting from Homebrew
- **Lines 199-201:** NVM from Homebrew (NOT curl install)
- **Line 206:** Powerlevel10k from Homebrew
- **Line 209:** Sources .p10k.zsh configuration if it exists
- **Line 213:** Zoxide initialization
- **Lines 215-237:** `fw()` function - work-specific CLI wrapper

### `runs/00-install-dependencies`
Installs everything needed for fresh Mac:
1. Checks Homebrew exists (exits if not)
2. Installs brew packages: tmux, fzf, zoxide, gnu-sed, neovim, git, zed, zsh-syntax-highlighting, node (includes npm), nvm, rust
3. Upgrades already-installed packages (ensures rust and other tools are up-to-date)
4. Installs Powerlevel10k via brew tap
5. Installs Oh My Zsh via official script
6. Configures fzf shell integration
7. Installs TPM (tmux plugin manager) + auto-installs plugins
8. Installs Nerd Fonts (with error handling for existing fonts)
9. Checks if Powerlevel10k configuration exists (~/.p10k.zsh) and logs warning if missing

**Important:** Uses `set -e` so it exits on any error. Font installation errors are suppressed with `2>/dev/null || log`. Brew upgrade errors are also suppressed (packages may already be latest version).

### `runs/01-symlink-configs`
- Backs up existing files (moves to `.backup`)
- Removes old symlinks
- Creates new symlinks from this repo to `~/`
- Symlinks: `.zshrc`, `.config/*` (git, tmux, nvim, ghostty, zed), `.local/*`
- Includes `--dry` flag support for testing

**Note:** Neovim config (`.config/nvim/`) is tracked directly in this repo, not as a separate git submodule.

### `runs/02-refresh-tmux-plugins`
Fixes tmux plugin detection issues (TPM doesn't always detect new plugins properly):
- Deletes all plugins except TPM itself
- Reinstalls all plugins from `tmux.conf`
- Reloads tmux config if tmux is running
- User was manually deleting `~/.tmux/plugins/` to fix this - now automated

**Why this exists:** TPM's `prefix + I` doesn't always work reliably. Clean reinstall is more reliable.

**Usage:**
```bash
./run tmux                        # Run via main script with filter
./runs/02-refresh-tmux-plugins    # Run directly
```

### `.local/scripts/tmux-sessionizer`
Fuzzy finder for projects, creates/switches tmux sessions:
- **Lines 4-7:** Configurable search paths (currently `~/Developer`, `~/env-provision`)
- **Line 10:** MAX_DEPTH=4 (searches 4 levels deep)
- **Lines 27-41:** Excludes auto-generated dirs: `.git`, `node_modules`, `dist`, `build`, `extensions`, etc.
- Uses fzf for selection
- Creates tmux session with sanitized name
- Switches to session or creates new one

### `.config/tmux/tmux.conf`
- **Line 9:** Prefix rebound to `Ctrl-Space`
- **Lines 16-19:** Vim-style pane navigation (h/j/k/l)
- **Line 23:** `Ctrl-Space + f` opens tmux-sessionizer
- **Lines 45-51:** TPM plugins: tmux-sensible, tmux-kanagawa
- **Line 69:** TPM initialization (must be last line)

### `.config/zed/`
- **settings.json:** Vim mode enabled, JetBrainsMono Nerd Font, Kanagawa Dragon theme, LSP configs, Bedrock (Claude Sonnet 4.5) integration
- **keymap.json:** Vim-style keybindings, `space` as leader key, VSCode base keymap
- **tasks.json:** Custom tasks for fzf and nvim integration

### `.config/git/`
- **config:** Git configuration with custom aliases and settings
- **ignore:** Global gitignore file that excludes Claude Code settings (`**/.claude/settings.local.json`) from all repositories

## Important Gotchas

### 1. .zshrc Must Source Homebrew Paths
The .zshrc sources tools from Homebrew locations:
```bash
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
```
**Never** change these to hardcoded paths or git clone installs.

### 2. tmux Plugin Installation
TPM plugins are auto-installed by `00-install-dependencies`. When adding new plugins to `tmux.conf`, run `./runs/02-refresh-tmux-plugins` to cleanly reinstall all plugins. The manual `prefix + I` approach is unreliable.

### 3. Symlinks Break If Repo Moves
If this repo is moved from `~/env-provision`, all symlinks break. User would need to re-run `./run` from the new location.

### 4. shared-envs/ is Gitignored
Contains work-specific environment files. Not tracked in git. User must manually create this directory on fresh machines if needed.

### 5. Oh My Zsh Git Plugin
The `plugins=(git)` line loads dozens of built-in git aliases (like `glol`, `gco`, etc.). Custom aliases in .zshrc override these. User prefers custom `glog` over Oh My Zsh's `glol`.

### 6. tmux-sessionizer Search Paths
Hardcoded to `~/Developer` and `~/env-provision`. If user has projects elsewhere, they need to edit `SEARCH_PATHS` array in the script.

### 7. Rust Installed via Homebrew
Rust and Cargo are installed via `brew install rust`, not rustup. This aligns with the "Homebrew for Everything" architecture decision. The `.zshrc` already includes `~/.cargo/bin` in the PATH. Rust is auto-upgraded during provisioning via `brew upgrade`.

### 8. Powerlevel10k Configuration
The `.p10k.zsh` file is NOT tracked in this repo (it's generated by running `p10k configure`). The installation script checks if this file exists and logs a warning if it's missing. The `.zshrc` will source it automatically if present (line 209).

### 9. Node.js and npm via Homebrew
Node.js and npm are installed globally via `brew install node`, not via nvm. This provides a stable system-wide installation. nvm is also installed for managing multiple Node versions when needed, but the default Node installation comes from Homebrew.

## Making Changes

**⚠️ After making any significant changes, always update this claude.md file so future Claude Code instances have current context.**

### Adding New Config Files
1. Add config to `.config/` or `.local/` in this repo
2. Update `runs/01-symlink-configs` to include the new directory in the appropriate array
3. Test with `./runs/01-symlink-configs --dry`
4. Run `./run` to apply
5. **Update claude.md** with new file locations and purpose

### Adding New Dependencies
1. Add to `brew_packages` array in `runs/00-install-dependencies`
2. If it's a font, add to `fonts` array
3. If it requires special setup, add after the brew upgrade section
4. **Update claude.md** with new dependencies

### Adding New Run Scripts
1. Create new script in `runs/` with number prefix (e.g., `04-new-script`)
2. Make it executable: `chmod +x runs/04-new-script`
3. Follow the dry-run pattern (see existing scripts)
4. **Update claude.md** with script purpose and usage

### Updating Existing Configs
Just edit the file in this repo - changes apply immediately via symlinks.

## Testing Changes

Always test with dry run first:
```bash
./run --dry                        # Test full provisioning
./runs/01-symlink-configs --dry    # Test just symlinking
```

## Common User Patterns

### Git Workflow
User has custom git aliases that override Oh My Zsh defaults:
- `gs` = git status (prefers over Oh My Zsh's `gst`)
- `glog` = git log with graph (prefers over Oh My Zsh's `glol`)
- Uses `glog` binding frequently

### Tmux Workflow
- `Ctrl-Space + f` to fuzzy find and switch projects
- Vim-style pane navigation
- Kanagawa theme throughout (tmux, zed, ghostty)

### Editor Preferences
- Vim mode in Zed (with VSCode base keymap)
- JetBrainsMono Nerd Font everywhere
- Kanagawa Dragon theme across all editors and terminal
- LSP enabled for TypeScript and Python
- Bedrock integration for Claude Sonnet 4.5 in Zed

## Fresh Mac Setup (Quick Reference)
1. Install Homebrew
2. Clone this repo to `~/env-provision`
3. `cd ~/env-provision`
4. `./runs/00-install-dependencies`
5. `./run`
6. Restart terminal
7. `p10k configure` (optional)

## Files to Never Auto-Generate
- Documentation files (*.md) unless explicitly requested
- New provisioning scripts without user approval
- Git hooks or Git config changes without asking

## User Preferences
- Prefers Homebrew for all installations
- Wants short, concise README (current one is good)
- Uses "ultrathink" flag when asking for thorough analysis
- Prefers symlinks over copies
- Likes numbered scripts for execution order
- Wants clean fzf results (no auto-generated dirs)
