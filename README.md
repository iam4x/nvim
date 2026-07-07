# Neovim config

Fast terminal-focused Neovim setup for Git commits, TypeScript, JSON, TOML, YAML, Markdown, shell, and common config files.

## First launch

Open Neovim and let `lazy.nvim` install plugins:

```sh
nvim
```

Then run:

```vim
:Mason
```

Install or verify the language tools you want. This config asks Mason for:

- `ts_ls`
- `jsonls`
- `yamlls`
- `taplo`
- `bashls`
- `lua_ls`

For formatting, install these external tools if you want format-on-save:

```sh
npm install -g prettier prettierd
brew install stylua taplo lazygit
```

## Keys

- `<leader>` is Space.
- `<leader>ff` find files.
- `<leader>fg` live grep.
- `<leader>fb` buffers.
- `<leader>e` file explorer.
- `<leader>gg` lazygit.
- `<leader>f` format buffer.
- `gd`, `gr`, `K`, `<leader>rn`, `<leader>ca` for LSP basics.
- `[d` and `]d` move through diagnostics.
- `[h` and `]h` move through Git hunks.
