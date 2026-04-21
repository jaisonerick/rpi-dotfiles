# rpi-dotfiles

Dotfiles for the `rpi-home` Raspberry Pi. Applied by the `dotfiles` role in
[`jaisonerick/rpi-setup`](https://github.com/jaisonerick/rpi-setup) via
[`rcm`](https://github.com/thoughtbot/rcm).

Two users, different depth:

- **`claude`** — operation user. Runs Claude Code in tmux, does day-to-day
  work. Gets the full set (`rcup -t claude`).
- **`pi`** — setup/bootstrap user. Minimal shared dotfiles only (`rcup` with
  no tag). Git, tmux, locale — enough to clone repos and SSH comfortably
  during host setup.

## Layout

```
rpi-dotfiles/
  rcrc               → ~/.rcrc (both)
  gitconfig          → ~/.gitconfig (both)
  gitignore          → ~/.gitignore (both; global excludes)
  gitmessage         → ~/.gitmessage (both; commit template)
  profile            → ~/.profile (both; UTF-8 locale + PATH)
  tmux.conf          → ~/.tmux.conf (both)
  tmux-help.conf     → ~/.tmux-help.conf (both)
  tag-claude/
    zshrc            → ~/.zshrc
    zprofile         → ~/.zprofile
    bashrc           → ~/.bashrc
    extras/CLAUDE.md → ~/CLAUDE.md  (copied, not symlinked — see below)
```

## Usage

```sh
cd ~/code/jaisonerick
git clone git@github.com:jaisonerick/rpi-dotfiles.git
cd rpi-dotfiles

# For the claude user — full set
rcup -v -t claude

# For the pi user — shared files only
rcup -v
```

The `rpi-setup` ansible `dotfiles` role runs these commands non-interactively
during host bootstrap.

## Claude-tag runtime dependencies

The `tag-claude/zshrc` references tools installed by the `common_tools`
ansible role in `rpi-setup`:

- `fzf`, `zoxide`, `bat`/`batcat`, `fd` (apt package `fd-find` + symlink).

Optional per-user toolchains (Claude user only, installed outside this repo):

- `fnm` → Node version manager.
- `bun` → JS runtime.
- `~/.local/bin/claude` → Claude Code CLI. `claude-session` tmux helper no-ops
  if absent.

All integrations are guarded against missing binaries, so a missing tool
degrades gracefully.

## `CLAUDE.md` placement

`rcm` only manages dotfiles, so `CLAUDE.md` lives under `tag-claude/extras/`
and the ansible `dotfiles` role copies (not symlinks) it into `~/CLAUDE.md`
for the claude user. That file is Claude Code project-level memory sourced
when the CLI launches with `cwd=$HOME`.

## Why not reuse `jaisonerick/laptop/dotfiles/`

- Laptop's `zshrc` sources `~/.zsh/rc/*` (modular). The Pi uses a single
  self-contained file — keeps the Pi's flatter structure because it was
  already debugged against the Claude-Code-on-tmux workflow.
- Laptop's gitconfig references `/opt/homebrew/bin/gh`. The Pi needs
  `/usr/bin/gh`. Otherwise this repo's gitconfig matches laptop's sensible
  defaults (pull.rebase, init.defaultBranch, etc.).
- Laptop has macOS-only bits (iTerm, Library, Homebrew paths) that would be
  dead weight on the Pi.
