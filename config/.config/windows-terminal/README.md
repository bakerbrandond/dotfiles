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

Also set a Nerd Font (for example `CaskaydiaCove Nerd Font`) as the profile font
-- `.p10k.zsh` is generated for `nerdfont-v3`, and `Cascadia Mono PL` has
powerline separators but none of the Nerd Font icons.
