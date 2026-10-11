# Windows Terminal (WSL hosts)

Windows Terminal's config lives on the Windows side, so stow cannot place it:

    %LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

`nord.json` is the fragment to merge into it by hand -- the `Nord` entry for
`schemes`, plus the `profiles.defaults.colorScheme` that selects it. This is the
Windows equivalent of the ghostty and alacritty Nord configs in this repo.

It matters for more than the terminal itself: `.p10k.zsh` picks its colors by
256-palette index, never by hex, so the whole zsh prompt renders in whatever
palette the terminal provides. Without this, Windows Terminal draws its default
Campbell scheme and nothing looks Nord.

The fragment also sets the font, since `.p10k.zsh` is generated for
`nerdfont-v3` and `Cascadia Mono PL` has powerline separators but none of the
Nerd Font icons.

Note the family name: current nerd-fonts releases register
**`CaskaydiaCove NF`** (and `CaskaydiaCove NFM`, the single-width variant), not
`CaskaydiaCove Nerd Font` -- that longer name matches nothing and Windows
Terminal silently falls back.

To install on a WSL host, from the nerd-fonts release `CascadiaCode.zip`, copy
the `.ttf` files to `%LOCALAPPDATA%\Microsoft\Windows\Fonts` and register each
one under `HKCU\Software\Microsoft\Windows NT\CurrentVersion\Fonts`. Copying
alone does not install a font. No admin rights needed for a per-user install.
