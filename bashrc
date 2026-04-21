# PATH for all shell types
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/games"

# BASH_ENV makes non-interactive shells (Claude Code's Bash tool) source this too
export BASH_ENV="$HOME/.claude-env"

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
  eval "$(fnm env --shell bash)"
fi
