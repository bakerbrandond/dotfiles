# zsh

Portable across the three machines (WSL2, macOS, native Linux). Install with
`stow --target=$HOME --restow --ignore=README.md zsh` from the repo root.

## Layout

Everything lives under `$ZDOTDIR` (`~/.config/zsh`). The only file in `$HOME`
is `.zshenv`, which sets `ZDOTDIR` and hands off.

```
.zshenv              -> ~/.zshenv        sets ZDOTDIR, nothing else
.config/zsh/
  .zshenv            XDG defaults + the zsh_conf_load helper. Runs for every
                     zsh, including scripts — keep it tool-independent.
  .zprofile          login only: editor/pager/lang, gpg, ssh-agent, secrets
  .zshrc             instant prompt, antidote, then conf.d in order
  .zlogin            fortune, if installed
  conf.d/
    00-options.zsh   setopt, history, keybindings
    10-path.zsh      path/fpath, every entry conditional
    20-brew.zsh      brew shellenv: /opt/homebrew, /usr/local, linuxbrew
    30-aliases.zsh   aliases, each gated on its tool existing
    40-tools.zsh     asdf, nvm, cargo, fzf, zoxide, navi, sgpt
    50-os-darwin.zsh macOS only
    50-os-linux.zsh  Linux only
    55-os-wsl.zsh    WSL only, after 50-os-linux
    90-completion.zsh compinit, once, cached
  completions/       fpath dir (cobra-generated completions live here)
  plugins/antidote/  submodule — run `git submodule update --init` on a new box
```

`.zprofile` and `.zshrc` both call `zsh_conf_load`, which loads each file at
most once per shell and skips the OS files that don't apply. That's what gives
a non-login interactive shell (a tmux pane) the same environment as a login
shell without doing the work twice.

## Per-machine settings

`~/.zshrc.local` is sourced last and is not tracked here. Copy
`.config/zsh/zshrc.local.example` to `~/.zshrc.local` and put machine-specific
PATH entries, tokens and one-off aliases in it.

## Conventions

- Guard every optional tool: `(( $+commands[foo] )) && ...`, or `[[ -r file ]]`.
  A missing tool disables its feature silently — no output at startup, which
  also keeps powerlevel10k's instant prompt quiet.
- Prefer `path=(... $path)` with the glob qualifier `(N)` so a missing
  directory drops out instead of landing a dead entry on PATH.
- Nothing may write to stdout/stderr before the instant-prompt block in
  `.zshrc`.

Formulae the config makes use of are listed in `../homebrew/.homebrew/Brewfile`
(macOS) and `LinuxBrewfile` (Linux).
