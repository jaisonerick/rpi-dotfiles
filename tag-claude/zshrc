# PATH for all shell types
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/games"

# BASH_ENV makes non-interactive bash shells (Claude Code's Bash tool) source this
export BASH_ENV="$HOME/.claude-env"

# Use alternate screen buffer in Claude Code (fixes rendering issues in tmux)
export CLAUDE_CODE_NO_FLICKER=1

# Launch or attach to the "claude" tmux session
claude-session() {
  if [[ -n "$TMUX" ]]; then
    printf '\033[>4;1m'
  fi
  if ! tmux has-session -t claude 2>/dev/null; then
    tmux new-session -d -s claude -c "$HOME/remote"
    tmux send-keys -t claude "$HOME/.local/bin/claude --dangerously-skip-permissions; tmux kill-session -t claude" Enter
  fi
  tmux attach-session -t claude
  if [[ -n "$TMUX" ]]; then
    printf '\033[>4;0m'
  fi
}

# fnm
FNM_PATH="/home/claude/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# --- Environment ---
export EDITOR=nano
export VISUAL=nano
export BAT_THEME="gruvbox-dark"
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

# --- History ---
HISTFILE=~/.zhistory
HISTSIZE=32768
SAVEHIST=32768
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

# --- Directory options ---
setopt autocd
setopt autopushd
setopt pushdminus
setopt pushdsilent
setopt pushdtohome
setopt cdablevars
DIRSTACKSIZE=5
setopt extended_glob
unsetopt nomatch

# --- Color ---
autoload -U colors && colors
export CLICOLOR=1

# --- Completion ---
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# --- Prompt (mobile-optimized) ---
_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  echo " ${branch}"
}
setopt prompt_subst
PROMPT='%F{blue}%2~%f%F{green}$(_git_branch)%f %# '

# --- fzf ---
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --reverse'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# --- zoxide ---
eval "$(zoxide init zsh)"

# --- Aliases ---
# bat (Debian names it batcat)
alias bat='batcat'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias l='ls -la'
alias ll='ls -al'
alias mkdir='mkdir -p'

# Git
alias s='git status'
alias d='git diff'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gc='git commit'
alias gcm='git commit --amend'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --graph --decorate --oneline'
alias gps='git push'
alias gpl='git pull'
alias gpf='git push --force-with-lease'

# Tmux
alias tma='tmux new-session -s'
alias tms='tmux attach-session -t'
alias tml='tmux list-sessions'

# Utility
alias path='echo $PATH | tr ":" "\n"'

# --- Functions ---
# g: git shortcut (no args = status)
g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

# envup: load .env file
envup() {
  local file="${1:-.env}"
  if [[ -f "$file" ]]; then
    set -a
    source "$file"
    set +a
    echo "Loaded $file"
  else
    echo "No $file found" >&2
    return 1
  fi
}

# Directory shortcuts (for cdablevars)
export code=~/code

# bun completions
[ -s "/home/claude/.bun/_bun" ] && source "/home/claude/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
