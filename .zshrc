# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"

alias vi=nvim
alias vim=nvim
alias n=nvim
# git
alias g='git'
alias gs='git status'
alias gss='git status -s'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git pull'
alias gp='git push'
alias gup='git fetch && git rebase'
# git log
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg='git log --graph'
alias gll='git log --oneline'
# Staging & Committing
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
# Branching & Checkout
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
# Stash
alias gst='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'


# export TMUX="true"
bindkey '^[k' clear-screen

killport() {
  echo "Looking for processes on port $1..."
  match=$(lsof -nP -iTCP:$1 -sTCP:LISTEN)

  if [ -z "$match" ]; then
    echo "❌ No process found listening on port $1"
    return 1
  fi

  echo "✅ Found process:"
  echo "$match"

  pid=$(echo "$match" | awk 'NR==2 { print $2 }')
  echo -n "Do you want to kill PID $pid? [y/N]: "
  read answer

  if [[ "$answer" == [Yy] ]]; then
    kill -9 "$pid"
    echo "☠️  Killed process $pid"
  else
    echo "👍 Skipping kill"
  fi
}

# export ANDROID_HOME=/Users/$USER/Library/Android/sdk
# export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
# export JAVA_HOME=$(/usr/libexec/java_home -v 11)
# export PATH="$JAVA_HOME/bin:$PATH"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
#
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Source zsh-syntax-highlighting from Homebrew
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NEOVIDE_CONFIG_PATH="$HOME/.config/neovide/neovide.toml"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
test -e "${HOME}/Developer/FreightWise/FreightWise/dev/tools/fw-cli/.zshrc" && source "${HOME}/Developer/FreightWise/FreightWise/dev/tools/fw-cli/.zshrc"
eval "$(/opt/homebrew/bin/brew shellenv)"
alias sed='gsed'
export PATH="$PATH:/opt/homebrew/opt/postgresql@12/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
test -e "${HOME}/Developer/FreightWise/FreightWise/dev/tools/fw-cli/.zshrc" && source "${HOME}/Developer/FreightWise/FreightWise/dev/tools/fw-cli/.zshrc"
test -e "${HOME}/Developer/FreightWise/FreightWise/dev/tools/fw-cli/.zshrc" && source "${HOME}/Developer/FreightWise/FreightWise/dev/tools/fw-cli/.zshrc"
test -e "${HOME}/Developer/FreightWise/infrastructure/.zshrc" && source "${HOME}/Developer/FreightWise/infrastructure/.zshrc"
. /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
. /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Load NVM from Homebrew
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Load Powerlevel10k from Homebrew
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export JAVA_HOME=$(/usr/libexec/java_home -v11 2>/dev/null) || export JAVA_HOME=$(brew --prefix openjdk@11)
export PATH="$JAVA_HOME/bin:$PATH"

eval "$(zoxide init zsh)"

function fw() {
    local root=$(git rev-parse --show-toplevel 2>/dev/null)
    local cli="$root/dev/tools/fw-cli/fw"

    # Debugging: Log the root path
    echo "DEBUG: Current worktree root: $root" >&2

    if [[ -x "$cli" ]]; then
        "$cli" "$@"
    else
        echo "fw-cli not found in current worktree: $root" >&2
        return 1
    fi
}
_fw_complete() {
    local root=$(git rev-parse --show-toplevel 2>/dev/null)
    local cli="$root/dev/tools/fw-cli/fw"

    if [[ -x "$cli" ]]; then
        COMPREPLY=($(compgen -W "$($cli --list-commands)" -- "${COMP_WORDS[1]}"))
    fi
}
complete -F _fw_complete fw

# Created by `pipx` on 2024-08-19 00:05:44
export PATH="$PATH:/Users/mbreaux/.local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

  export AWS_PROFILE=bedrock-developer-access
  export AWS_REGION=us-east-1
export AWS_PROFILE=dev
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
