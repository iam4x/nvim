# Neovim config

Fast terminal-focused Neovim setup for Git commits, TypeScript, JSON, TOML, YAML, Markdown, shell, and common config files.

## Install on Arch / Omarchy

### 1. Install system packages

Use Omarchy's package wrapper so packages come from the configured Arch repositories:

```sh
omarchy pkg add neovim git ripgrep gcc curl unzip tree-sitter-cli stylua taplo-cli lazygit fnm
```

`taplo-cli` is the Arch package name; it provides the `taplo` executable. The compiler and Treesitter CLI are required because this config tracks the `main` branch of `nvim-treesitter` and compiles parsers locally.

### 2. Configure Node.js and JavaScript formatters

Add this to `~/.zshrc` if `fnm` is not already initialized:

```zsh
eval "$(fnm env --use-on-cd --shell zsh)"
```

Open a new shell, then install an LTS Node.js release and the formatters used for JavaScript, TypeScript, JSON, YAML, and Markdown:

```sh
fnm install --lts --use
fnm default "$(fnm current)"
npm install --global prettier prettierd
```

### 3. Install Neovim plugins and Treesitter parsers

This configuration must be located at `~/.config/nvim`. From any directory, run:

```sh
nvim --headless "+Lazy! sync" +qa
```

Then open Neovim normally:

```sh
nvim
```

Lazy installs the plugins, and the Treesitter build hook installs parsers for shell, Git, web languages, Lua, Markdown, TOML, Vim, and YAML.

### 4. Verify language servers

Open Mason inside Neovim:

```vim
:Mason
```

The configuration automatically requests:

- `bashls`
- `jsonls`
- `lua_ls`
- `taplo`
- `ts_ls`
- `yamlls`

Wait for their installations to finish. Use `:checkhealth vim.lsp` to inspect the active LSP setup and `:LspInfo` from a source buffer to see attached servers.

### 5. Use Neovim for Git commits

Set Neovim as Git's editor:

```sh
git config --global core.editor nvim
```

Commit buffers are detected as `gitcommit`, use a 72-column guide, enable spelling, and use the Treesitter Git commit parser.

### 6. Verify the installation

Run these commands inside Neovim:

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

The external tools should also be available from the shell:

```sh
nvim --version
tree-sitter --version
stylua --version
taplo --version
lazygit --version
node --version
prettier --version
prettierd --version
```

## Troubleshooting

If Git commit messages have no proper syntax highlighting, reinstall that parser:

```sh
nvim --headless "+lua require('nvim-treesitter').install({'gitcommit'}):wait(300000)" +qa
```

If Blink completion reports a missing fuzzy library, refresh only that plugin. The config pins Blink to stable `1.*` releases so it can download its prebuilt Linux library:

```sh
nvim --headless "+Lazy! update blink.cmp" +qa
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
