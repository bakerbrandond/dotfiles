# Avante.nvim Default Hotkeys

Reference for default keybindings from [yetone/avante.nvim](https://github.com/yetone/avante.nvim).
These match the plugin defaults in `lua/avante/config.lua`.

`<leader>` is your Neovim leader key (commonly `\`, `,`, or `<Space>`).

> **Note:** With lazy.nvim, Avante uses safe keymap setting — if a binding is already taken, it will not overwrite it.

---

## Global (`<leader>a…`)

| Key | Action |
|-----|--------|
| `<leader>aa` | Open sidebar / ask |
| `<leader>an` | New chat |
| `<leader>at` | Toggle sidebar |
| `<leader>ae` | Edit selected blocks (visual mode) |
| `<leader>ar` | Refresh sidebar |
| `<leader>af` | Switch focus (sidebar ↔ code) |
| `<leader>aS` | Stop current AI request |
| `<leader>az` | Zen mode (full-screen chat) |
| `<leader>a?` | Select model |
| `<leader>ah` | Select chat history |
| `<leader>aM` | Select ACP agent model |
| `<leader>am` | Select ACP agent mode |
| `<leader>ad` | Toggle debug mode |
| `<leader>as` | Toggle suggestions |
| `<leader>aC` | Toggle selection hints |
| `<leader>aR` | Toggle repomap |
| `<leader>ac` | Add current buffer to context |
| `<leader>aB` | Add all open buffers to context |

---

## Sidebar (when sidebar is focused)

| Key | Action |
|-----|--------|
| `A` | Apply all changes |
| `a` | Apply change at cursor |
| `r` | Retry last request |
| `e` | Edit last request |
| `]p` / `[p` | Next / previous prompt |
| `<Tab>` | Switch windows |
| `<S-Tab>` | Reverse switch windows / expand tool use |
| `x` | Toggle code window |
| `d` | Remove file from context |
| `@` | Add file |
| `q` | Close sidebar |

---

## Input (chat prompt)

| Key | Mode | Action |
|-----|------|--------|
| `<CR>` | Normal | Submit |
| `<C-s>` | Insert | Submit |
| `<C-c>`, `<Esc>`, `q` | Normal | Cancel |
| `<C-c>` | Insert | Cancel |
| `<C-n>` / `<C-p>` | Normal / Insert | Next / previous prompt log |

---

## Inline Suggestions

| Key | Action |
|-----|--------|
| `<M-l>` (Alt/Option + l) | Accept suggestion |
| `<M-]>` / `<M-[>` | Next / previous suggestion |
| `<C-]>` | Dismiss suggestion |

---

## Diff / Conflicts

| Key | Action |
|-----|--------|
| `co` / `ct` | Choose ours / theirs |
| `ca` | Choose all theirs |
| `cb` / `cc` | Choose both / cursor |
| `]x` / `[x` | Next / previous conflict |

---

## Other

| Key | Action |
|-----|--------|
| `]]` / `[[` | Jump next / previous suggestion block |
| `<C-w>f` | Focus confirm window |
| `c` / `r` / `i` | Confirm code / response / input |

---

## Customization

Override defaults in `~/.config/nvim/lua/plugins/avante.lua`:

```lua
opts = {
  mappings = {
    ask = "<leader>aa",
    suggestion = {
      accept = "<M-l>",
    },
    -- ...
  },
}
```

Docs: [Keybindings - Avante.nvim](https://yetone-avante-nvim.mintlify.app/configuration/keybindings)
