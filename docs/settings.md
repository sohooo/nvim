# Settings

This table records the option decisions from `prev_cfg/init.lua`.

| Old setting | Decision | Current value/location | Rationale |
| --- | --- | --- | --- |
| `Hifi()` | Kept conceptually | `lua/config/style.lua` exposes the `NVIM_STYLE ~= "plain"` decision. | Share the lo-fi icon decision without restoring a global helper. |
| `MyColors()` | Migrated | `lua/config/theme.lua` selects a profile from `GIT_USERNAME`. | Keeps the previous user-specific theme workflow while exposing colorscheme, lualine, and bufferline choices from one module. |
| `vim.version.ge` shim | Not migrated | None. | Current Neovim is new enough. |
| `package.path` mutation | Not migrated | None. | LazyVim module loading handles local `lua/`. |
| `runtimepath` append | Not migrated | None. | Project-local startup already points XDG config at this repo. |
| lazy.nvim bootstrap block | Replaced | `lua/config/lazy.lua`. | LazyVim starter bootstrap owns this. |
| `mapleader`, `maplocalleader` | Migrated | `,` in `init.lua` and `lua/config/options.lua`. | Comma leader matches the previous workflow. |
| `inccommand = "split"` | Migrated | `lua/config/options.lua`. | Keeps live substitution previews in a split. |
| `hlsearch = true` | Migrated | `lua/config/options.lua`. | Preserve highlighted search results. |
| `incsearch = true` | Migrated | `lua/config/options.lua`. | Preserve incremental search feedback. |
| `showmatch = true` | Migrated | `lua/config/options.lua`. | Preserve matching bracket feedback. |
| `matchtime = 2` | Migrated | `lua/config/options.lua`. | Preserve short match blink timing. |
| `number = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `relativenumber = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `scrolloff = 8` | Migrated | `lua/config/options.lua`. | Old config wanted more context than LazyVim default. |
| `hidden = true` | Not migrated | None. | Obsolete in modern Neovim behavior. |
| `mouse = ""` | Migrated | `lua/config/options.lua`. | Restore keyboard-first workflow. |
| `wrap = true` | Added locally | `lua/config/options.lua`. | Wrap long lines by default while keeping movement keyboard-first. |
| `breakindent = true` | Migrated | `lua/config/options.lua`. | Keep readable wrapped indentation. |
| `undofile = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `ignorecase = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `smartcase = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `expandtab = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `updatetime = 250` | LazyVim default preferred | `200` from LazyVim. | LazyVim is slightly more responsive. |
| `timeout = true` | Migrated | `lua/config/options.lua`. | Preserve mapped sequence behavior. |
| `timeoutlen = 400` | Migrated | `lua/config/options.lua`. | Keep old which-key timing preference. |
| `signcolumn = "yes:1"` | Migrated and widened | `yes:2` in `lua/config/options.lua`. | Keep the editor column stable when diagnostics, TODO markers, or git signs appear. |
| line-number/status column behavior | Added locally | `numberwidth = 4`, `statuscolumn = "%s%=%l "` in `lua/config/options.lua`. | Avoid horizontal jumps when switching focus between explorer and editor windows. |
| `laststatus = 2` | LazyVim default preferred | `3` from LazyVim. | Global statusline fits the LazyVim baseline. |
| `splitbelow = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `splitright = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `termguicolors` and colorscheme branch | LazyVim default preferred | LazyVim plus `lua/plugins/colorschemes.lua`. | Keep truecolor baseline; lo-fi behavior is handled plugin-by-plugin. |
| PuTTY OSC52 terminal probing | Added locally | `lua/config/options.lua` disables `g:termfeatures.osc52` when `TERM`/`TERM_PROGRAM` contains `putty`, or when `NVIM_DISABLE_OSC52=1`. | Prevent PuTTY sessions from leaking OSC52 capability probes into the dashboard. |
| `completeopt` | LazyVim default | LazyVim options. | Default already matches old config. |
| `iskeyword += "-"` | Migrated | `lua/config/options.lua`. | Preserve dashed-word movement/search behavior. |
| Neovim providers | Added locally | Node, Perl, Python 3, and Ruby providers disabled in `lua/config/options.lua`. | This config does not use remote plugins requiring those providers, so disabling them keeps healthcheck output explicit and quiet. |
| Extra filetype detection | Added locally | `lua/config/filetypes.lua` registers `.gotmpl` and `.pp`. | Native LSP configs should reference filetypes Neovim can detect locally. |
