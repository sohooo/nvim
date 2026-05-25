# Settings

This table records the option decisions from `prev_cfg/init.lua`.

| Old setting | Decision | Current value/location | Rationale |
| --- | --- | --- | --- |
| `Hifi()` | Kept conceptually | Plugin-local helpers check `NVIM_STYLE ~= "plain"`. | Avoid a global helper while keeping lo-fi behavior. |
| `MyColors()` | Not migrated | LazyVim default `tokyonight`; extra themes in `lua/plugins/colorschemes.lua`. | Theme selection can be revisited separately. |
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
| `breakindent = true` | Migrated | `lua/config/options.lua`. | Keep readable wrapped indentation. |
| `undofile = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `ignorecase = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `smartcase = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `expandtab = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `updatetime = 250` | LazyVim default preferred | `200` from LazyVim. | LazyVim is slightly more responsive. |
| `timeout = true` | Migrated | `lua/config/options.lua`. | Preserve mapped sequence behavior. |
| `timeoutlen = 400` | Migrated | `lua/config/options.lua`. | Keep old which-key timing preference. |
| `signcolumn = "yes:1"` | Migrated | `lua/config/options.lua`. | Preserve a stable single sign column. |
| `laststatus = 2` | LazyVim default preferred | `3` from LazyVim. | Global statusline fits the LazyVim baseline. |
| `splitbelow = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `splitright = true` | LazyVim default | LazyVim options. | Default already matches old config. |
| `termguicolors` and colorscheme branch | LazyVim default preferred | LazyVim plus `lua/plugins/colorschemes.lua`. | Keep truecolor baseline; lo-fi behavior is handled plugin-by-plugin. |
| `completeopt` | LazyVim default | LazyVim options. | Default already matches old config. |
| `iskeyword += "-"` | Migrated | `lua/config/options.lua`. | Preserve dashed-word movement/search behavior. |

