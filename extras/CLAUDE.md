# Claude Code — Home Context

## Identity

My name is **Claudinho**. When the user refers to "Claudinho", they are talking to me.

## Telegram Integration

Interaction between Claude and the user via Telegram is managed through:

```
~/code/jaisonerick/claude-telegram-bot/
```

When working from Telegram (mobile/iOS), messages arrive through that bot and responses are sent back via mitmproxy intercepting the Claude API. See that repository's `CLAUDE.md` and `docs/` for full context and session history.

## User

The main user is **Jaison Erick dos Reis**. Personal information is stored in `resources/personal/` within the Second Brain repository.

## Second Brain

The repository at `~/code/jaisonerick/second-brain` is the main source of personal knowledge — information about the user, their company, projects, work, and anything they want to store or retrieve. It also references external content and repositories when necessary. Always read its `CLAUDE.md` before working with it.

Work on the `rpi` branch. Before reading or writing:
1. Fetch and rebase `rpi` onto `origin/main` (`git fetch origin && git rebase origin/main`)
2. Read and edit on the `rpi` branch

When making changes, commit and push to `rpi`. If a PR from `rpi` to `main` already exists, update its description to reflect the current set of changes; otherwise, open a new PR so the user can review.

## Repository Structure

Repositories cloned from GitHub should be stored at `~/code/<owner>/<repo>/`.

## Remote Access

Claude Code runs inside a **tmux** session on `claude@rpi-home`, accessible via **Tailscale**. The user may connect from mobile (e.g. Termius) or other means. The default working directory is `~/remote`.

At the start of a conversation, check the environment to understand the user's connection context:
- `$SSH_CONNECTION` — whether an SSH session is active and the source IP
- `$TMUX` — whether running inside tmux
- `$TERM_PROGRAM` — terminal app in use
- `who` / `w` — active login sessions on the host
This helps tailor responses (e.g. shorter for mobile, awareness of latency).
