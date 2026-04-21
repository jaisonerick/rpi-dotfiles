# rpi-dotfiles

Dotfiles for the `rpi-home` Raspberry Pi. Applied by the `dotfiles` role in
[`jaisonerick/rpi-setup`](https://github.com/jaisonerick/nexaedge) via `rcm`.

Targets the `pi` (management/admin) and `claude` (interactive Claude Code)
user accounts on `rpi-home`. Both users get the same shell + tmux + git setup.

## Contents

| Dotfile | Target path |
|---------|-------------|
| `zshrc` | `~/.zshrc` |
| `zprofile` | `~/.zprofile` |
| `bashrc` | `~/.bashrc` |
| `profile` | `~/.profile` |
| `tmux.conf` | `~/.tmux.conf` |
| `tmux-help.conf` | `~/.tmux-help.conf` |
| `gitconfig` | `~/.gitconfig` |
| `rcrc` | `~/.rcrc` |
| `extras/CLAUDE.md` | `~/CLAUDE.md` (copied, not symlinked — see below) |

## Runtime dependencies

The zshrc references tools installed by the `common_tools` ansible role in
`rpi-setup`:

- `fzf` — shell widgets + CTRL-R / CTRL-T / ALT-C.
- `zoxide` — `z` directory jumper.
- `bat` / `batcat` — syntax-highlighted pager.
- `fd` — faster find (apt package is `fd-find`; the role symlinks to `/usr/local/bin/fd`).

Optional per-user toolchains (not installed by rpi-setup; handled per-user):

- `fnm` → Node version manager. zshrc guards with `[ -d "$FNM_PATH" ]`.
- `bun` → JS runtime. Completions and PATH additions guarded.
- `~/.local/bin/claude` → Claude Code CLI. `claude-session` tmux helper fails
  silently if absent.

## Why not reuse `jaisonerick/laptop/dotfiles/`

- Laptop's `zshrc` sources `~/.zsh/rc/*` (modular config). The Pi uses a
  single self-contained file. Keeping the Pi's flatter structure because:
  it was already debugged against the Claude-Code-on-tmux workflow, and the Pi
  has far fewer integrations to split across files.
- Laptop's gitconfig references `/opt/homebrew/bin/gh` (macOS path). The Pi
  needs `/usr/bin/gh`.
- Laptop has macOS-only bits (iTerm, Library, Homebrew paths) that rcm would
  skip anyway but bulk the repo.

## `CLAUDE.md` placement

`rcm` only manages files matching the dotted convention, so `CLAUDE.md` lives
under `extras/` and is copied (not symlinked) into `~/CLAUDE.md` by the
ansible role. That file is Claude Code project-level memory sourced when the
CLI launches with `cwd=$HOME`.

## Applying manually

```sh
# First time
cd ~/code/jaisonerick
git clone git@github.com:jaisonerick/rpi-dotfiles.git
cd rpi-dotfiles
rcup -v

# Pull updates
cd ~/code/jaisonerick/rpi-dotfiles && git pull && rcup -v
```
