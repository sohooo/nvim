# Neovim Healthcheck

Generated with `scripts/healthcheck.sh`.

- Exit status: `0`

- Errors: `12`
- Warnings: `17`

## Report

```text

==============================================================================
lazy:                                                                     2 ⚠️

lazy.nvim ~
- {lazy.nvim} version `11.17.5`
- ✅ OK {git} `version 2.52.0`
- ✅ OK no existing packages found by other package managers
- ✅ OK packer_compiled.lua not found

luarocks ~
- checking `luarocks` installation
- ✅ OK no plugins require `luarocks`, so you can ignore any warnings below
- ✅ OK {luarocks} `/opt/homebrew/bin/luarocks 3.12.2`
- ⚠️ WARNING `lua` version `5.1` needed, but found `Lua 5.4.8  Copyright (C) 1994-2025 Lua.org, PUC-Rio`
- ⚠️ WARNING {lua5.1} or {lua} or {lua-5.1} version `5.1` not installed

==============================================================================
lazyvim:                                                            1 ⚠️  1 ❌

LazyVim ~
- ✅ OK Using Neovim >= 0.11.2
- ✅ OK `git` is installed
- ✅ OK `rg` is installed
- ✅ OK `fd` is installed
- ✅ OK `lazygit` is installed
- ⚠️ WARNING `fzf` is not installed
- ✅ OK `curl` is installed

LazyVim nvim-treesitter ~
- ✅ OK `C compiler` is installed
- ✅ OK `curl` is installed
- ✅ OK `tar` is installed
- ❌ ERROR `tree-sitter (CLI)` is not installed
- See the requirements at [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)
- Run `:checkhealth nvim-treesitter` for more information.

==============================================================================
snacks:                                                             8 ⚠️ 11 ❌

Snacks ~
- ✅ OK setup called

Snacks.bigfile ~
- ✅ OK setup {enabled}

Snacks.dashboard ~
- ✅ OK setup {enabled}
- ❌ ERROR setup did not run

Snacks.explorer ~
- ✅ OK setup {enabled}
- ✅ OK 'trash' `# Un-recognized argument --version at index 1`
- ✅ OK 'gio' `2.86.3`
- ✅ OK System trash command found

Snacks.image ~
- ⚠️ WARNING setup {disabled}
- ❌ ERROR None of the tools found: 'kitty', 'wezterm', 'ghostty'
- ❌ ERROR None of the tools found: 'magick', 'convert'
- ❌ ERROR `magick` is required to convert images. Only PNG files will be displayed.
- ✅ OK Terminal Dimensions:
  - {size}: `720` x `432` pixels
  - {scale}: `1.12`
  - {cell}: `9` x `18` pixels
- ✅ OK Available Treesitter languages:
    `markdown_inline`, `markdown`
- ⚠️ WARNING Missing Treesitter languages:
    `css`, `html`, `javascript`, `latex`, `norg`, `scss`, `svelte`, `tsx`, `typst`, `vue`
- ⚠️ WARNING Image rendering in docs with missing treesitter parsers won't work
- ❌ ERROR Tool not found: 'gs'
- ⚠️ WARNING `gs` is required to render PDF files
- ❌ ERROR None of the tools found: 'tectonic', 'pdflatex'
- ⚠️ WARNING `tectonic` or `pdflatex` is required to render LaTeX math expressions
- ❌ ERROR Tool not found: 'mmdc'
- ⚠️ WARNING `mmdc` is required to render Mermaid diagrams
- ❌ ERROR your terminal does not support the kitty graphics protocol
- supported terminals: `kitty`, `wezterm`, `ghostty`

Snacks.input ~
- ✅ OK setup {enabled}
- ❌ ERROR `vim.ui.input` is not set to `Snacks.input`

Snacks.lazygit ~
- ✅ OK {lazygit} installed

Snacks.notifier ~
- ✅ OK setup {enabled}
- ❌ ERROR is not ready

Snacks.picker ~
- ✅ OK setup {enabled}
- ❌ ERROR `vim.ui.select` is not set to `Snacks.picker.select`
- ⚠️ WARNING Missing Treesitter languages:
    `regex`
- ✅ OK 'git' `git version 2.52.0`
- ✅ OK 'rg' `ripgrep 15.1.0`
- ✅ OK `Snacks.picker.grep()` is available
- ✅ OK 'fd' `fd 10.3.0`
- ✅ OK `Snacks.picker.files()` is available
- ✅ OK `Snacks.picker.explorer()` is available
- ✅ OK `SQLite3` is available

Snacks.quickfile ~
- ✅ OK setup {enabled}

Snacks.scope ~
- ✅ OK setup {enabled}

Snacks.scroll ~
- ✅ OK setup {enabled}

Snacks.statuscolumn ~
- ⚠️ WARNING setup {disabled}

Snacks.terminal ~
- ✅ OK shell configured
  - `vim.o.shell`: /bin/zsh
  - `parsed`: { "/bin/zsh" }

Snacks.toggle ~
- ✅ OK {which-key} is installed

Snacks.words ~
- ✅ OK setup {enabled}

==============================================================================
vim.deprecated:                                                             ✅

- ✅ OK No deprecated functions detected

==============================================================================
vim.health:                                                                 ✅

System Info ~
- Nvim version: `v0.12.2` 
- Operating system: Darwin 25.5.0
- Terminal: unknown
- $TERM: dumb

Configuration ~
- ✅ OK no issues found

Runtime ~
- ✅ OK $VIMRUNTIME: /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime

Performance ~
- ✅ OK Build type: Release

Remote Plugins ~
- ✅ OK Up to date

Terminal ~
- key_backspace (kbs) terminfo entry: `? (not found)`
- key_dc (kdch1) terminfo entry: `? (not found)`

External Tools ~
- ✅ OK ripgrep 15.1.0 (/opt/homebrew/bin/rg)
- ✅ OK vim.ui.open: handler found (open)
- ✅ OK git version 2.52.0 (/opt/homebrew/bin/git)
- ✅ OK curl 8.7.1 (/usr/bin/curl)
  curl 8.7.1 (x86_64-apple-darwin25.0) libcurl/8.7.1 (SecureTransport) LibreSSL/3.3.6 zlib/1.2.12 nghttp2/1.68.1
  Release-Date: 2024-03-27
  Protocols: dict file ftp ftps gopher gophers http https imap imaps ipfs ipns ldap ldaps mqtt pop3 pop3s rtsp smb smbs smtp smtps telnet tftp
  Features: alt-svc AsynchDNS GSS-API HSTS HTTP2 HTTPS-proxy IPv6 Kerberos Largefile libz MultiSSL NTLM SPNEGO SSL threadsafe UnixSockets

==============================================================================
vim.lsp:                                                                    ✅

- LSP log level : WARN
- Log path: /Users/sven/Code/lab/nvim/.xdg/state/nvim/lsp.log
- Log size: 7 KB

vim.lsp: Active Features ~

vim.lsp: Active Clients ~
- No active clients

vim.lsp: Enabled Configurations ~

vim.lsp: File Watcher ~
- file watching "(workspace/didChangeWatchedFiles)" disabled on all clients

vim.lsp: Position Encodings ~
- No active clients

==============================================================================
vim.pack:                                                                   ✅

vim.pack: basics ~
- ✅ OK `vim.pack` is not used

==============================================================================
vim.provider:                                                             6 ⚠️

Clipboard (optional) ~
- ✅ OK Clipboard tool found: pbcopy

Node.js provider (optional) ~
- ⚠️ WARNING `node` and `npm` (or `yarn`, `pnpm`) must be in $PATH.
  - ADVICE:
    - Install Node.js and verify that `node` and `npm` (or `yarn`, `pnpm`) commands work.

Perl provider (optional) ~
- ⚠️ WARNING "Neovim::Ext" cpan module is not installed
  - ADVICE:
    - See :help |provider-perl| for more information.
    - You can disable this provider (and warning) by adding `let g:loaded_perl_provider = 0` to your init.vim
- ⚠️ WARNING No usable perl executable found

Python 3 provider (optional) ~
- ⚠️ WARNING No Python executable found that can `import neovim`. Using the first available executable for diagnostics.
- ⚠️ WARNING Could not load Python :
  Checking /Users/sven/.asdf/shims/python3 caused an unknown error. (126, output: ) Report this at https://github.com/neovim/neovim
  /opt/homebrew/bin/python3.14 does not have the "neovim" module.
  /opt/homebrew/bin/python3.13 does not have the "neovim" module.
  /opt/homebrew/bin/python3.12 does not have the "neovim" module.
  Checking /Users/sven/.asdf/shims/python3.11 caused an unknown error. (126, output: ) Report this at https://github.com/neovim/neovim
  Checking /Users/sven/.asdf/shims/python3.10 caused an unknown error. (126, output: ) Report this at https://github.com/neovim/neovim
  /opt/homebrew/bin/python3.9 does not have the "neovim" module.
  Checking /Users/sven/.asdf/shims/python caused an unknown error. (126, output: ) Report this at https://github.com/neovim/neovim
  - ADVICE:
    - See :help |provider-python| for more information.
    - You can disable this provider (and warning) by adding `let g:loaded_python3_provider = 0` to your init.vim
- Executable: Not found

Python virtualenv ~
- ✅ OK no $VIRTUAL_ENV

Ruby provider (optional) ~
- Ruby: nil
- ⚠️ WARNING `neovim-ruby-host` not found.
  - ADVICE:
    - Run `gem install neovim` to ensure the neovim RubyGem is installed.
    - Run `gem environment` to ensure the gem bin directory is in $PATH.
    - If you are using rvm/rbenv/chruby, try "rehashing".
    - See :help |g:ruby_host_prog| for non-standard gem installations.
    - You can disable this provider (and warning) by adding `let g:loaded_ruby_provider = 0` to your init.vim

==============================================================================
vim.treesitter:                                                             ✅

Treesitter features ~
- Treesitter ABI support: min 13, max 15
- WASM parser support: false

Treesitter parsers ~
- ✅ OK Parser: c                         ABI: 15, path: /opt/homebrew/Cellar/neovim/0.12.2/lib/nvim/parser/c.so
- ✅ OK Parser: lua                       ABI: 15, path: /opt/homebrew/Cellar/neovim/0.12.2/lib/nvim/parser/lua.so
- ✅ OK Parser: markdown                  ABI: 15, path: /opt/homebrew/Cellar/neovim/0.12.2/lib/nvim/parser/markdown.so
- ✅ OK Parser: markdown_inline           ABI: 15, path: /opt/homebrew/Cellar/neovim/0.12.2/lib/nvim/parser/markdown_inline.so
- ✅ OK Parser: query                     ABI: 15, path: /opt/homebrew/Cellar/neovim/0.12.2/lib/nvim/parser/query.so
- ✅ OK Parser: vim                       ABI: 15, path: /opt/homebrew/Cellar/neovim/0.12.2/lib/nvim/parser/vim.so
- ✅ OK Parser: vimdoc                    ABI: 15, path: /opt/homebrew/Cellar/neovim/0.12.2/lib/nvim/parser/vimdoc.so

Treesitter queries ~
- ✅ OK c               folds           /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/c
- ✅ OK c               highlights      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/c
- ✅ OK c               injections      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/c
- ✅ OK css             images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/css
- ✅ OK html            images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/html
- ✅ OK javascript      images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/javascript
- ✅ OK latex           images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/latex
- ✅ OK lua             folds           /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/lua
- ✅ OK lua             highlights      /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/lua
- ✅ OK lua             highlights      /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/LazyVim/queries/lua
- ✅ OK lua             highlights      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/lua
- ✅ OK lua             injections      /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/lua
- ✅ OK lua             injections      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/lua
- ✅ OK markdown        folds           /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/markdown
- ✅ OK markdown        highlights      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/markdown
- ✅ OK markdown        images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/markdown
- ✅ OK markdown        injections      /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/markdown
- ✅ OK markdown        injections      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/markdown
- ✅ OK markdown_inline highlights      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/markdown_inline
- ✅ OK markdown_inline images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/markdown_inline
- ✅ OK markdown_inline injections      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/markdown_inline
- ✅ OK norg            images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/norg
- ✅ OK query           folds           /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/query
- ✅ OK query           highlights      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/query
- ✅ OK scss            images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/scss
- ✅ OK svelte          images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/svelte
- ✅ OK tsx             images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/tsx
- ✅ OK typst           images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/typst
- ✅ OK vim             folds           /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/vim
- ✅ OK vim             highlights      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/vim
- ✅ OK vim             injections      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/vim
- ✅ OK vimdoc          highlights      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/vimdoc
- ✅ OK vimdoc          injections      /opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/queries/vimdoc
- ✅ OK vue             images          /Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim/queries/vue
```

## Command Output

```text
checkhealth:  11% checking lazycheckhealth:  22% checking lazyvimcheckhealth:  33% checking snackscheckhealth:  44% checking vim.deprecatedcheckhealth:  55% checking vim.healthcheckhealth:  66% checking vim.lspcheckhealth:  77% checking vim.packcheckhealth:  88% checking vim.providercheckhealth: 100% checking vim.treesittercheckhealth: checks done
```
