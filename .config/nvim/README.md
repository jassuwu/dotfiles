# nvim

Daily `nvim` is this config. `~/.config/nvim` already points here.

First launch after the merge is a normal `nvim`. Plugins are already on disk from
the rewrite (`~/.local/share/nvim/site/pack/core/opt`). Parsers and language
servers were installed on this machine. A new machine needs the toolchain below.

## What changed from the old config

Gone: lazy, mason, nvim-cmp, LuaSnip, telescope, neogit, diffview, trouble,
fidget, three colorschemes, the `<leader>v*` LSP maps.

Still here, just thinner: format on save, git hunks, find/grep, file tree, rose-pine.

## Maps you already know

| Key | Does |
| --- | --- |
| `<C-p>` | find files (fzf-lua, was telescope) |
| `<leader>ff` | live grep |
| `<leader>pv` or `-` | parent directory (oil, was netrw) |
| `<leader>f` | format |
| `<leader>s` | replace word under cursor |
| `<C-f>` | tmux-sessionizer |
| `<leader>y` / `<leader>p` / `<leader>d` | clipboard / black-hole paste / delete |
| `J`/`K` in visual | move selection |

## Maps that moved

| Old | New |
| --- | --- |
| `<leader>vrr` references | `grr` |
| `<leader>vrn` rename | `grn` |
| `<leader>vca` code action | `gra` |
| `<leader>vd` diagnostic float | `<C-w>d` |
| `K` hover | still `K` |
| `[d` / `]d` | still work, and they are no longer backwards |
| `<leader>g` neogit | gone. use a real terminal |
| `<leader>tt` trouble | `<leader>fd` for the list, `<leader>l` to toggle virtual lines |
| `<leader>vh` help | `<leader>fh` |

Core also gives you `gri` implementation, `grt` type def, `gO` symbols, `<C-s>`
signature help in insert, `gc`/`gcc` comment, `[q`/`]q` quickfix, `[b`/`]b`
buffers, `an`/`in` in visual to grow/shrink a treesitter node.

## Completion

Accept with `<C-y>`. Enter is still Enter. `<Tab>` / `<S-Tab>` jump snippet
placeholders, they do not walk the menu.

If that gets old, the escape hatch is `blink.cmp` pinned to `1.*` (its `main` is
a breaking V2). Do not add it unpinned.

## Git

Hunks, blame, preview. That is it.

- `]c` / `[c` next/prev hunk
- `<leader>hp` preview
- `<leader>hb` line blame

Stage and commit in a terminal. neogit and diffview are gone on purpose.

## Oil

`-` opens the parent directory as a normal buffer. `dd` a file, `:w` to confirm.
This is not a sidebar.

## Updating plugins

No `:Lazy`.

```
:lua vim.pack.update()
```

A confirmation buffer opens. `:w` applies, `:q` aborts. That rewrites
`nvim-pack-lock.json` in this directory. **Commit the lockfile.** It is the only
reproducible pin, especially for `nvim-treesitter`, which tracks `main`.

```
:lua vim.pack.get()
:lua vim.pack.del({ 'name' })
:checkhealth vim.pack
```

`vim.pack` has no lazy-loading. Do not try to add `event` / `ft` / `cmd` keys.

## Language servers are brew/npm, not Mason

A missing server is a missing binary on `$PATH`. Never `:MasonInstall`.

```
brew:   lua-language-server gopls rust-analyzer tree-sitter-cli fd stylua gofumpt \
        goimports taplo marksman shfmt ruff clang-format
npm -g: @vtsls/language-server @tailwindcss/language-server \
        vscode-langservers-extracted @biomejs/biome prettier basedpyright
```

`clangd` is Apple's. `clang-format` is a separate formula. It is not in CLT.
The tree-sitter CLI must come from Homebrew. The npm CLI fails silently on the
`main` branch. The formula is `tree-sitter-cli`, **not** `tree-sitter` — the
latter is now the library alone, so installing it leaves no `tree-sitter` on
`$PATH` and every parser dies at `Error during "tree-sitter build": ENOENT`
while still reporting a successful download.

`rustfmt` lives in `~/.cargo/bin`. `lua/options.lua` prepends that to `$PATH`
so Ghostty does not have to source cargo first.

Old Mason/lazy data is leftover and unused:

```
rm -rf ~/.local/share/nvim/lazy ~/.local/share/nvim/mason
```

Do not delete all of `~/.local/share/nvim`. That also holds shada, undo, and
the new `site/pack` plugins.

## Adding a language

Three places, then a binary on `$PATH`:

1. `vim.lsp.enable({ ... })` in `lua/lsp.lua`
2. formatter in `lua/plugins.lua` if conform should own save
3. parser name in `lua/treesitter.lua` `ensure`

Server settings go in `after/lsp/<name>.lua`, never `lsp/<name>.lua`. Core
merges `after/` last. If you put the file in `lsp/`, nvim-lspconfig wins and
your override looks like it vanished.

Never `require('lspconfig')`. The plugin is a data directory. The old
`setup{}` framework errors in v3.

## What will bite

- **Accept is `<C-y>`.** This is the one that will get you in the first hour.
- **`PackChanged` before `vim.pack.add()`.** There is no `build` key. Register
  the hook first or treesitter parsers never compile.
- **Parser downloads hit `codeload.github.com`.** When GitHub rate-limits, you
  get one `lua.so` and silence. Retry later, do not reinstall the CLI via npm.
- **`vim.pack` semver needs `v1.2.3`-shaped tags.** `v1` and `1.2` do not parse.
  Track a branch and let the lockfile pin the commit.
- **Diagnostic signs via `sign_define` are gone.** Use
  `vim.diagnostic.config({ signs = { text = ... } })`.
- **`client:supports_method()` is a colon call.**
- **Do not delete `~/.local/share/nvim` wholesale.**

## Layout

```
init.lua              leader, requires
lua/options.lua       vim.o, native completion, cargo PATH
lua/plugins.lua       PackChanged, vim.pack.add, setup()
lua/keymaps.lua       only maps that are not core defaults
lua/autocmds.lua      yank, trailing space, restore cursor
lua/lsp.lua           vim.lsp.enable, diagnostics
lua/treesitter.lua    parser install + FileType hooks
after/lsp/*.lua       per-server overrides
nvim-pack-lock.json   generated. commit it. do not hand-edit
```
