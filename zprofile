# UTF-8 locale (needed for Claude Code Unicode rendering in tmux)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
