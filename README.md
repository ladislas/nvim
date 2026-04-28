# nvim

> Lean 'n Clean Neovim Config

## Requirements

- [Neovim](https://neovim.io) ≥ 0.9
- [fzf](https://github.com/junegunn/fzf) (for fzf-lua)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- Optional: language servers (installed via `:Mason`)

## Install

```sh
brew install neovim fzf
git clone https://github.com/ladislas/nvim ~/.config/nvim
```

Open Neovim — plugins are installed automatically via [lazy.nvim](https://lazy.folke.io).

## Plugins

All plugins are managed by **lazy.nvim** and defined in `lua/plugins/`:

| File | Plugins | Description |
|------|---------|-------------|
| `buffers.lua` | vim-bufonly, vim-bufkill | Buffer management |
| `colorschemes.lua` | gruvbox.nvim, nordic.nvim | Color schemes |
| `completion.lua` | LuaSnip, friendly-snippets, nvim-cmp | Completion & snippets |
| `editing.lua` | editorconfig-vim, auto-pairs, vim-easy-align, vim-surround, vim-commentary, vim-repeat, undotree | Editing enhancements |
| `fzf.lua` | fzf-lua | Fuzzy finder |
| `git.lua` | gitsigns.nvim, fugitive | Git integration |
| `languages.lua` | vim-endwise, vim-pandoc | Language support |
| `lsp.lua` | mason.nvim, mason-lspconfig, nvim-lspconfig | LSP (auto-configured servers) |
| `navigation.lua` | neo-tree | File explorer |
| `startup.lua` | alpha-nvim | Dashboard |
| `treesitter.lua` | nvim-treesitter | Syntax highlighting & textobjects |
| `ui.lua` | lualine.nvim | Status line |

## Keymaps

Leader key: `,`

### General

| Key | Mode | Action |
|-----|------|--------|
| `,w` | Normal | Save |
| `<CR>` | Normal | New line below |
| `jj` | Insert | Exit to Normal |
| `Q` | Normal | Close window or kill buffer |
| `,f$` | Normal | Strip trailing whitespace |
| `,fef` | Normal | Format / reindent file |
| `/` / `?` | Normal/Visual | Smart-case search (`\v`) |
| `<BS>` | Normal | Toggle search highlight |
| `,sp` | Normal | Toggle spellcheck |

### Windows & Buffers

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl-h/j/k/l` | Normal | Move between windows |
| `,s` | Normal | Horizontal split |
| `,v` | Normal | Vertical split |
| `←` / `→` | Normal | Buffer prev/next |
| `↑` / `↓` | Normal | Tab next/prev |
| `,tn` / `,tc` | Normal | Tab new/close |
| `gb` | Normal | Buffer list & open |

### Fuzzy Finder (fzf-lua)

| Key | Action |
|-----|--------|
| `,ff` | Find files |
| `,fg` | Live grep |
| `,fb` | Find buffers |
| `,fr` | Registers / yank history |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `,rn` | Rename |
| `,ca` | Code action |
| `,d` | Line diagnostics float |
| `[d` / `]d` | Previous/next diagnostic |

### Completion & Snippets

| Key | Mode | Action |
|-----|------|--------|
| `Tab` / `Shift-Tab` | Insert | Next/previous completion item |
| `Ctrl-Space` | Insert | Trigger completion |
| `CR` | Insert | Confirm completion |
| `Ctrl-e` | Insert/Snippet | Expand snippet |
| `Ctrl-j` / `Ctrl-k` | Insert/Snippet | Jump forward/backward in snippet |

### Function Keys

| Key | Action |
|-----|--------|
| `F1` | Dashboard (Alpha) |
| `F2` | Toggle file tree (neo-tree) |
| `F3` | Reveal current file in tree |
| `F5` | Undo tree |