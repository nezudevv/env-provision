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
- NVM: `brew install nvm`
- Tools sourced from Homebrew paths in .zshrc (see line 155, 200, 206)

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
├── .zshrc                      # Complete shell config (244 lines)
├── .gitignore                  # Ignores shared-envs/
│
├── .config/                    # App configurations (all symlinked)
│   ├── git/config             # Git config with aliases (co, s, fp)
│   ├── tmux/tmux.conf         # Tmux with Gruvbox, Ctrl-Space prefix
│   ├── zed/                   # Zed editor (vim mode, Catppuccin theme)
│   │   ├── settings.json      # Editor settings, LSP config
│   │   ├── keymap.json        # Vim-style keybindings
│   │   └── tasks.json         # Custom tasks (fzf, nvim)
│   ├── ghostty/config         # Terminal config (Gruvbox, CommitMono font)
│   └── nvim/                  # Neovim config (tracked in this repo)
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
- **Lines 200-201:** NVM from Homebrew (NOT curl install)
- **Line 206:** Powerlevel10k from Homebrew
- **Lines 210-223:** `fw()` function - work-specific CLI wrapper
- **Line 208:** Zoxide initialization

### `runs/00-install-dependencies`
Installs everything needed for fresh Mac:
1. Checks Homebrew exists (exits if not)
2. Installs brew packages: tmux, fzf, zoxide, gnu-sed, neovim, git, zed, zsh-syntax-highlighting, nvm
3. Installs Powerlevel10k via brew tap
4. Installs Oh My Zsh via official script
5. Configures fzf shell integration
6. Installs TPM (tmux plugin manager) + auto-installs plugins
7. Installs Nerd Fonts (with error handling for existing fonts)

**Important:** Uses `set -e` so it exits on any error. Font installation errors are suppressed with `2>/dev/null || log`.

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
- **Line 10:** MAX_DEPTH=3 (searches 3 levels deep)
- **Lines 27-41:** Excludes auto-generated dirs: `.git`, `node_modules`, `dist`, `build`, `extensions`, etc.
- Uses fzf for selection
- Creates tmux session with sanitized name
- Switches to session or creates new one

### `.config/tmux/tmux.conf`
- **Line 9:** Prefix rebound to `Ctrl-Space`
- **Lines 16-19:** Vim-style pane navigation (h/j/k/l)
- **Line 23:** `Ctrl-Space + f` opens tmux-sessionizer
- **Lines 45-50:** TPM plugins: tmux-sensible, tmux-gruvbox
- **Line 67:** TPM initialization (must be last line)

### `.config/zed/`
- **settings.json:** Vim mode enabled, JetBrainsMono Nerd Font, Catppuccin theme, LSP configs
- **keymap.json:** Vim-style keybindings, `space` as leader key
- **tasks.json:** Custom tasks for fzf and nvim integration

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
3. If it requires special setup, add after the brew install loop
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
- Gruvbox theme throughout (tmux, zed, ghostty)

### Editor Preferences
- Vim mode in Zed
- JetBrainsMono Nerd Font everywhere
- Catppuccin/Gruvbox themes
- LSP enabled for TypeScript and Python

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
