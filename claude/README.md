# claude

Claude Code user settings — `~/.claude/settings.json`.

## What is and isn't tracked

Only `settings.json`. The rest of `~/.claude/` stays local and untracked:
`.credentials.json`, `history.jsonl`, `projects/`, `sessions/`,
`shell-snapshots/` and friends are machine-local, and several hold secrets or
transcripts. The repo-root `.gitignore` denies everything under
`claude/.claude/` except `settings.json`, so a future copy cannot drag them in
by accident. (The guard lives at the repo root deliberately: a `.gitignore` in
the package root would itself be stowed to `~/.gitignore`.)

Stow links the single file, not the directory: `~/.claude` already exists as a
real directory, so stow descends into it rather than folding it into one
symlink. That matters — folding would hide credentials, projects and sessions
behind a repo symlink.

## What's in it

- `hooks.Notification` → `~/.local/bin/claude-ping.sh` (the `local` package),
  which fires the tmux message, the sound, the terminal bell and the dunst
  notification. Needs the `local` and `config` packages stowed to do anything.
- `enabledPlugins`, `model`, `theme`, `voice`.

The hook command is an absolute `/home/bbd/...` path, matching how `bspwmrc`
and `sxhkdrc` already spell paths in this repo. On a machine with a different
`$HOME` it needs editing.

## Caveat: the symlink and in-app settings changes

Changing a setting from inside Claude Code (`/config`, enabling a plugin,
switching theme) rewrites `settings.json`. Writing in place follows the symlink
and lands the change in this repo, which is what you want. A writer that
instead writes a temp file and renames it over the target would replace the
symlink with a regular file, silently detaching the file from this repo.

Reading through the symlink is verified — `claude doctor` reports malformed
JSON written to the repo copy. The write path is not verified.

To check it is still linked, and repair it if not:

    ls -l ~/.claude/settings.json     # should be a symlink into ~/dotfiles
    make install                      # --restow relinks it

Worth a glance after changing settings in-app for the first time.
