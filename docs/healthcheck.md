# Neovim Healthcheck

Generated with `scripts/healthcheck.sh` through `make healthcheck`. Do not edit
the report body by hand; summarize actionable items in
`docs/healthcheck-findings.md`.

- Exit status: `0`

- Errors: `10`
- Warnings: `13`

## Report

```text

==============================================================================
blink.cmp:                                                                1 ⚠️

System ~
- ✅ OK curl is installed
- ✅ OK git is installed
- ✅ OK Your system is supported by pre-built binaries (aarch64-apple-darwin)
- ✅ OK blink_cmp_fuzzy lib is downloaded/built

Sources ~
- ⚠️ WARNING Some providers may show up as "disabled" but are enabled dynamically (e.g. cmdline)

Default sources ~
- lsp (blink.cmp.sources.lsp)
- path (blink.cmp.sources.path)
- snippets (blink.cmp.sources.snippets)
- buffer (blink.cmp.sources.buffer)

Cmdline sources ~
- buffer (blink.cmp.sources.buffer)
- cmdline (blink.cmp.sources.cmdline)

Disabled sources ~
- lazydev (lazydev.integrations.blink)
- omni (blink.cmp.sources.complete_func)

==============================================================================
config:                                                                     ✅

Local health policy ~
- ✅ OK vim.ui.input uses Snacks.input
- ✅ OK vim.ui.select uses Snacks.picker.select

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
snacks:                                                             8 ⚠️  9 ❌

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
- ✅ OK `vim.ui.input` is set to `Snacks.input`

Snacks.lazygit ~
- ✅ OK {lazygit} installed

Snacks.notifier ~
- ✅ OK setup {enabled}
- ❌ ERROR is not ready

Snacks.picker ~
- ✅ OK setup {enabled}
- ✅ OK `vim.ui.select` is set to `Snacks.picker.select`
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
vim.lsp:                                                                  1 ⚠️

- LSP log level : WARN
- Log path: /Users/sven/Code/lab/nvim/.xdg/state/nvim/lsp.log
- Log size: 15 KB

vim.lsp: Active Features ~

vim.lsp: Active Clients ~
- No active clients

vim.lsp: Enabled Configurations ~
- gopls:
  - capabilities: {
      general = {
        positionEncodings = { "utf-8", "utf-16", "utf-32" }
      },
      textDocument = {
        callHierarchy = {
          dynamicRegistration = false
        },
        codeAction = {
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
            }
          },
          dataSupport = true,
          disabledSupport = true,
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          isPreferredSupport = true,
          resolveSupport = {
            properties = { "edit", "command" }
          }
        },
        codeLens = {
          dynamicRegistration = false,
          resolveSupport = {
            properties = { "command" }
          }
        },
        colorProvider = {
          dynamicRegistration = true
        },
        completion = {
          completionItem = {
            commitCharactersSupport = false,
            deprecatedSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            insertReplaceSupport = true,
            insertTextModeSupport = {
              valueSet = { 1 }
            },
            labelDetailsSupport = true,
            preselectSupport = false,
            resolveSupport = {
              properties = { "additionalTextEdits", "command", "documentation" }
            },
            snippetSupport = true,
            tagSupport = {
              valueSet = { 1 }
            }
          },
          completionItemKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
          },
          completionList = {
            itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" }
          },
          contextSupport = true,
          dynamicRegistration = false,
          insertTextMode = 1
        },
        declaration = {
          linkSupport = true
        },
        definition = {
          dynamicRegistration = true,
          linkSupport = true
        },
        diagnostic = {
          dataSupport = true,
          dynamicRegistration = true,
          relatedDocumentSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        documentHighlight = {
          dynamicRegistration = false
        },
        documentLink = {
          dynamicRegistration = false,
          tooltipSupport = false
        },
        documentSymbol = {
          dynamicRegistration = false,
          hierarchicalDocumentSymbolSupport = true,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          },
          tagSupport = {
            valueSet = { 1 }
          }
        },
        foldingRange = {
          dynamicRegistration = false,
          foldingRange = {
            collapsedText = true
          },
          foldingRangeKind = {
            valueSet = { "comment", "imports", "region" }
          },
          lineFoldingOnly = true
        },
        formatting = {
          dynamicRegistration = true
        },
        hover = {
          contentFormat = { "markdown", "plaintext" },
          dynamicRegistration = true
        },
        implementation = {
          linkSupport = true
        },
        inlayHint = {
          dynamicRegistration = true,
          resolveSupport = {
            properties = { "textEdits", "tooltip", "location", "command" }
          }
        },
        inlineCompletion = {
          dynamicRegistration = false
        },
        linkedEditingRange = {
          dynamicRegistration = false
        },
        onTypeFormatting = {
          dynamicRegistration = false
        },
        publishDiagnostics = {
          dataSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        rangeFormatting = {
          dynamicRegistration = true,
          rangesSupport = true
        },
        references = {
          dynamicRegistration = false
        },
        rename = {
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          prepareSupport = true
        },
        selectionRange = {
          dynamicRegistration = false
        },
        semanticTokens = {
          augmentsSyntaxTokens = true,
          dynamicRegistration = false,
          formats = { "relative" },
          multilineTokenSupport = true,
          overlappingTokenSupport = true,
          requests = {
            full = {
              delta = true
            },
            range = true
          },
          serverCancelSupport = false,
          tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
          tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
        },
        signatureHelp = {
          dynamicRegistration = false,
          signatureInformation = {
            activeParameterSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            noActiveParameterSupport = true,
            parameterInformation = {
              labelOffsetSupport = true
            }
          }
        },
        synchronization = {
          didSave = true,
          dynamicRegistration = false,
          willSave = true,
          willSaveWaitUntil = true
        },
        typeDefinition = {
          linkSupport = true
        }
      },
      window = {
        showDocument = {
          support = true
        },
        showMessage = {
          messageActionItem = {
            additionalPropertiesSupport = true
          }
        },
        workDoneProgress = true
      },
      workspace = {
        applyEdit = true,
        codeLens = {
          refreshSupport = true
        },
        configuration = true,
        diagnostics = {
          refreshSupport = true
        },
        didChangeConfiguration = {
          dynamicRegistration = false
        },
        didChangeWatchedFiles = {
          dynamicRegistration = true,
          relativePatternSupport = true
        },
        fileOperations = {
          didCreate = false,
          didDelete = false,
          didRename = false,
          dynamicRegistration = false,
          willCreate = false,
          willDelete = false,
          willRename = false
        },
        inlayHint = {
          refreshSupport = true
        },
        semanticTokens = {
          refreshSupport = true
        },
        symbol = {
          dynamicRegistration = false,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          }
        },
        workspaceEdit = {
          changeAnnotationSupport = {
            groupsOnLabel = true
          },
          normalizesLineEndings = true,
          resourceOperations = { "rename", "create", "delete" }
        },
        workspaceFolders = true
      }
    }
  - cmd: { "gopls" }
  - filetypes: go, gomod, gosum, gotmpl
  - root_markers: { "go.work", "go.mod", ".git" }

- lua_ls:
  - capabilities: {
      general = {
        positionEncodings = { "utf-8", "utf-16", "utf-32" }
      },
      textDocument = {
        callHierarchy = {
          dynamicRegistration = false
        },
        codeAction = {
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
            }
          },
          dataSupport = true,
          disabledSupport = true,
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          isPreferredSupport = true,
          resolveSupport = {
            properties = { "edit", "command" }
          }
        },
        codeLens = {
          dynamicRegistration = false,
          resolveSupport = {
            properties = { "command" }
          }
        },
        colorProvider = {
          dynamicRegistration = true
        },
        completion = {
          completionItem = {
            commitCharactersSupport = false,
            deprecatedSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            insertReplaceSupport = true,
            insertTextModeSupport = {
              valueSet = { 1 }
            },
            labelDetailsSupport = true,
            preselectSupport = false,
            resolveSupport = {
              properties = { "additionalTextEdits", "command", "documentation" }
            },
            snippetSupport = true,
            tagSupport = {
              valueSet = { 1 }
            }
          },
          completionItemKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
          },
          completionList = {
            itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" }
          },
          contextSupport = true,
          dynamicRegistration = false,
          insertTextMode = 1
        },
        declaration = {
          linkSupport = true
        },
        definition = {
          dynamicRegistration = true,
          linkSupport = true
        },
        diagnostic = {
          dataSupport = true,
          dynamicRegistration = true,
          relatedDocumentSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        documentHighlight = {
          dynamicRegistration = false
        },
        documentLink = {
          dynamicRegistration = false,
          tooltipSupport = false
        },
        documentSymbol = {
          dynamicRegistration = false,
          hierarchicalDocumentSymbolSupport = true,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          },
          tagSupport = {
            valueSet = { 1 }
          }
        },
        foldingRange = {
          dynamicRegistration = false,
          foldingRange = {
            collapsedText = true
          },
          foldingRangeKind = {
            valueSet = { "comment", "imports", "region" }
          },
          lineFoldingOnly = true
        },
        formatting = {
          dynamicRegistration = true
        },
        hover = {
          contentFormat = { "markdown", "plaintext" },
          dynamicRegistration = true
        },
        implementation = {
          linkSupport = true
        },
        inlayHint = {
          dynamicRegistration = true,
          resolveSupport = {
            properties = { "textEdits", "tooltip", "location", "command" }
          }
        },
        inlineCompletion = {
          dynamicRegistration = false
        },
        linkedEditingRange = {
          dynamicRegistration = false
        },
        onTypeFormatting = {
          dynamicRegistration = false
        },
        publishDiagnostics = {
          dataSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        rangeFormatting = {
          dynamicRegistration = true,
          rangesSupport = true
        },
        references = {
          dynamicRegistration = false
        },
        rename = {
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          prepareSupport = true
        },
        selectionRange = {
          dynamicRegistration = false
        },
        semanticTokens = {
          augmentsSyntaxTokens = true,
          dynamicRegistration = false,
          formats = { "relative" },
          multilineTokenSupport = true,
          overlappingTokenSupport = true,
          requests = {
            full = {
              delta = true
            },
            range = true
          },
          serverCancelSupport = false,
          tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
          tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
        },
        signatureHelp = {
          dynamicRegistration = false,
          signatureInformation = {
            activeParameterSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            noActiveParameterSupport = true,
            parameterInformation = {
              labelOffsetSupport = true
            }
          }
        },
        synchronization = {
          didSave = true,
          dynamicRegistration = false,
          willSave = true,
          willSaveWaitUntil = true
        },
        typeDefinition = {
          linkSupport = true
        }
      },
      window = {
        showDocument = {
          support = true
        },
        showMessage = {
          messageActionItem = {
            additionalPropertiesSupport = true
          }
        },
        workDoneProgress = true
      },
      workspace = {
        applyEdit = true,
        codeLens = {
          refreshSupport = true
        },
        configuration = true,
        diagnostics = {
          refreshSupport = true
        },
        didChangeConfiguration = {
          dynamicRegistration = false
        },
        didChangeWatchedFiles = {
          dynamicRegistration = true,
          relativePatternSupport = true
        },
        fileOperations = {
          didCreate = false,
          didDelete = false,
          didRename = false,
          dynamicRegistration = false,
          willCreate = false,
          willDelete = false,
          willRename = false
        },
        inlayHint = {
          refreshSupport = true
        },
        semanticTokens = {
          refreshSupport = true
        },
        symbol = {
          dynamicRegistration = false,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          }
        },
        workspaceEdit = {
          changeAnnotationSupport = {
            groupsOnLabel = true
          },
          normalizesLineEndings = true,
          resourceOperations = { "rename", "create", "delete" }
        },
        workspaceFolders = true
      }
    }
  - cmd: { "lua-language-server" }
  - filetypes: lua
  - root_markers: { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }
  - settings: {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        },
        runtime = {
          version = "LuaJIT"
        },
        telemetry = {
          enable = false
        },
        workspace = {
          checkThirdParty = false,
          library = { "/Users/sven/Code/lab/nvim", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/site", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/lazy.nvim", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/friendly-snippets", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/blink.cmp", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/kanagawa.nvim", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/nord-vim", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/quickfix-reflector.vim", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/nvim-unception", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/snacks.nvim", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/tokyonight.nvim", "/Users/sven/Code/lab/nvim/.xdg/data/nvim/lazy/LazyVim", "/opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime", "/opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/pack/dist/opt/netrw", "/opt/homebrew/Cellar/neovim/0.12.2/share/nvim/runtime/pack/dist/opt/matchit", "/opt/homebrew/Cellar/neovim/0.12.2/lib/nvim", "/Users/sven/Code/lab/nvim/.xdg/state/nvim/lazy/readme" }
        }
      }
    }

- ⚠️ WARNING 'puppet-languageserver' is not executable. Configuration will not be used.
- puppet:
  - capabilities: {
      general = {
        positionEncodings = { "utf-8", "utf-16", "utf-32" }
      },
      textDocument = {
        callHierarchy = {
          dynamicRegistration = false
        },
        codeAction = {
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
            }
          },
          dataSupport = true,
          disabledSupport = true,
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          isPreferredSupport = true,
          resolveSupport = {
            properties = { "edit", "command" }
          }
        },
        codeLens = {
          dynamicRegistration = false,
          resolveSupport = {
            properties = { "command" }
          }
        },
        colorProvider = {
          dynamicRegistration = true
        },
        completion = {
          completionItem = {
            commitCharactersSupport = false,
            deprecatedSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            insertReplaceSupport = true,
            insertTextModeSupport = {
              valueSet = { 1 }
            },
            labelDetailsSupport = true,
            preselectSupport = false,
            resolveSupport = {
              properties = { "additionalTextEdits", "command", "documentation" }
            },
            snippetSupport = true,
            tagSupport = {
              valueSet = { 1 }
            }
          },
          completionItemKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
          },
          completionList = {
            itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" }
          },
          contextSupport = true,
          dynamicRegistration = false,
          insertTextMode = 1
        },
        declaration = {
          linkSupport = true
        },
        definition = {
          dynamicRegistration = true,
          linkSupport = true
        },
        diagnostic = {
          dataSupport = true,
          dynamicRegistration = true,
          relatedDocumentSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        documentHighlight = {
          dynamicRegistration = false
        },
        documentLink = {
          dynamicRegistration = false,
          tooltipSupport = false
        },
        documentSymbol = {
          dynamicRegistration = false,
          hierarchicalDocumentSymbolSupport = true,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          },
          tagSupport = {
            valueSet = { 1 }
          }
        },
        foldingRange = {
          dynamicRegistration = false,
          foldingRange = {
            collapsedText = true
          },
          foldingRangeKind = {
            valueSet = { "comment", "imports", "region" }
          },
          lineFoldingOnly = true
        },
        formatting = {
          dynamicRegistration = true
        },
        hover = {
          contentFormat = { "markdown", "plaintext" },
          dynamicRegistration = true
        },
        implementation = {
          linkSupport = true
        },
        inlayHint = {
          dynamicRegistration = true,
          resolveSupport = {
            properties = { "textEdits", "tooltip", "location", "command" }
          }
        },
        inlineCompletion = {
          dynamicRegistration = false
        },
        linkedEditingRange = {
          dynamicRegistration = false
        },
        onTypeFormatting = {
          dynamicRegistration = false
        },
        publishDiagnostics = {
          dataSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        rangeFormatting = {
          dynamicRegistration = true,
          rangesSupport = true
        },
        references = {
          dynamicRegistration = false
        },
        rename = {
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          prepareSupport = true
        },
        selectionRange = {
          dynamicRegistration = false
        },
        semanticTokens = {
          augmentsSyntaxTokens = true,
          dynamicRegistration = false,
          formats = { "relative" },
          multilineTokenSupport = true,
          overlappingTokenSupport = true,
          requests = {
            full = {
              delta = true
            },
            range = true
          },
          serverCancelSupport = false,
          tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
          tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
        },
        signatureHelp = {
          dynamicRegistration = false,
          signatureInformation = {
            activeParameterSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            noActiveParameterSupport = true,
            parameterInformation = {
              labelOffsetSupport = true
            }
          }
        },
        synchronization = {
          didSave = true,
          dynamicRegistration = false,
          willSave = true,
          willSaveWaitUntil = true
        },
        typeDefinition = {
          linkSupport = true
        }
      },
      window = {
        showDocument = {
          support = true
        },
        showMessage = {
          messageActionItem = {
            additionalPropertiesSupport = true
          }
        },
        workDoneProgress = true
      },
      workspace = {
        applyEdit = true,
        codeLens = {
          refreshSupport = true
        },
        configuration = true,
        diagnostics = {
          refreshSupport = true
        },
        didChangeConfiguration = {
          dynamicRegistration = false
        },
        didChangeWatchedFiles = {
          dynamicRegistration = true,
          relativePatternSupport = true
        },
        fileOperations = {
          didCreate = false,
          didDelete = false,
          didRename = false,
          dynamicRegistration = false,
          willCreate = false,
          willDelete = false,
          willRename = false
        },
        inlayHint = {
          refreshSupport = true
        },
        semanticTokens = {
          refreshSupport = true
        },
        symbol = {
          dynamicRegistration = false,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          }
        },
        workspaceEdit = {
          changeAnnotationSupport = {
            groupsOnLabel = true
          },
          normalizesLineEndings = true,
          resourceOperations = { "rename", "create", "delete" }
        },
        workspaceFolders = true
      }
    }
  - cmd: { "puppet-languageserver", "--stdio", "--timeout=10", "--puppet-settings=--modulepath,/modules", "--local-workspace=/Users/sven/puppetenvs/kpm" }
  - filetypes: puppet
  - root_markers: { "metadata.json", "Puppetfile", ".git" }

- ruby-lsp:
  - capabilities: {
      general = {
        positionEncodings = { "utf-8", "utf-16", "utf-32" }
      },
      textDocument = {
        callHierarchy = {
          dynamicRegistration = false
        },
        codeAction = {
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
            }
          },
          dataSupport = true,
          disabledSupport = true,
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          isPreferredSupport = true,
          resolveSupport = {
            properties = { "edit", "command" }
          }
        },
        codeLens = {
          dynamicRegistration = false,
          resolveSupport = {
            properties = { "command" }
          }
        },
        colorProvider = {
          dynamicRegistration = true
        },
        completion = {
          completionItem = {
            commitCharactersSupport = false,
            deprecatedSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            insertReplaceSupport = true,
            insertTextModeSupport = {
              valueSet = { 1 }
            },
            labelDetailsSupport = true,
            preselectSupport = false,
            resolveSupport = {
              properties = { "additionalTextEdits", "command", "documentation" }
            },
            snippetSupport = true,
            tagSupport = {
              valueSet = { 1 }
            }
          },
          completionItemKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
          },
          completionList = {
            itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" }
          },
          contextSupport = true,
          dynamicRegistration = false,
          insertTextMode = 1
        },
        declaration = {
          linkSupport = true
        },
        definition = {
          dynamicRegistration = true,
          linkSupport = true
        },
        diagnostic = {
          dataSupport = true,
          dynamicRegistration = true,
          relatedDocumentSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        documentHighlight = {
          dynamicRegistration = false
        },
        documentLink = {
          dynamicRegistration = false,
          tooltipSupport = false
        },
        documentSymbol = {
          dynamicRegistration = false,
          hierarchicalDocumentSymbolSupport = true,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          },
          tagSupport = {
            valueSet = { 1 }
          }
        },
        foldingRange = {
          dynamicRegistration = false,
          foldingRange = {
            collapsedText = true
          },
          foldingRangeKind = {
            valueSet = { "comment", "imports", "region" }
          },
          lineFoldingOnly = true
        },
        formatting = {
          dynamicRegistration = true
        },
        hover = {
          contentFormat = { "markdown", "plaintext" },
          dynamicRegistration = true
        },
        implementation = {
          linkSupport = true
        },
        inlayHint = {
          dynamicRegistration = true,
          resolveSupport = {
            properties = { "textEdits", "tooltip", "location", "command" }
          }
        },
        inlineCompletion = {
          dynamicRegistration = false
        },
        linkedEditingRange = {
          dynamicRegistration = false
        },
        onTypeFormatting = {
          dynamicRegistration = false
        },
        publishDiagnostics = {
          dataSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        rangeFormatting = {
          dynamicRegistration = true,
          rangesSupport = true
        },
        references = {
          dynamicRegistration = false
        },
        rename = {
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          prepareSupport = true
        },
        selectionRange = {
          dynamicRegistration = false
        },
        semanticTokens = {
          augmentsSyntaxTokens = true,
          dynamicRegistration = false,
          formats = { "relative" },
          multilineTokenSupport = true,
          overlappingTokenSupport = true,
          requests = {
            full = {
              delta = true
            },
            range = true
          },
          serverCancelSupport = false,
          tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
          tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
        },
        signatureHelp = {
          dynamicRegistration = false,
          signatureInformation = {
            activeParameterSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            noActiveParameterSupport = true,
            parameterInformation = {
              labelOffsetSupport = true
            }
          }
        },
        synchronization = {
          didSave = true,
          dynamicRegistration = false,
          willSave = true,
          willSaveWaitUntil = true
        },
        typeDefinition = {
          linkSupport = true
        }
      },
      window = {
        showDocument = {
          support = true
        },
        showMessage = {
          messageActionItem = {
            additionalPropertiesSupport = true
          }
        },
        workDoneProgress = true
      },
      workspace = {
        applyEdit = true,
        codeLens = {
          refreshSupport = true
        },
        configuration = true,
        diagnostics = {
          refreshSupport = true
        },
        didChangeConfiguration = {
          dynamicRegistration = false
        },
        didChangeWatchedFiles = {
          dynamicRegistration = true,
          relativePatternSupport = true
        },
        fileOperations = {
          didCreate = false,
          didDelete = false,
          didRename = false,
          dynamicRegistration = false,
          willCreate = false,
          willDelete = false,
          willRename = false
        },
        inlayHint = {
          refreshSupport = true
        },
        semanticTokens = {
          refreshSupport = true
        },
        symbol = {
          dynamicRegistration = false,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          }
        },
        workspaceEdit = {
          changeAnnotationSupport = {
            groupsOnLabel = true
          },
          normalizesLineEndings = true,
          resourceOperations = { "rename", "create", "delete" }
        },
        workspaceFolders = true
      }
    }
  - cmd: { "ruby-lsp" }
  - filetypes: ruby, eruby
  - init_options: {
      addonSettings = {
        ["Ruby LSP Rails"] = {
          enablePendingMigrationsPrompt = false
        }
      },
      formatter = "standard",
      linters = { "standard" }
    }
  - root_markers: { "Gemfile", ".git" }

- ruff:
  - capabilities: {
      general = {
        positionEncodings = { "utf-8", "utf-16", "utf-32" }
      },
      textDocument = {
        callHierarchy = {
          dynamicRegistration = false
        },
        codeAction = {
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
            }
          },
          dataSupport = true,
          disabledSupport = true,
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          isPreferredSupport = true,
          resolveSupport = {
            properties = { "edit", "command" }
          }
        },
        codeLens = {
          dynamicRegistration = false,
          resolveSupport = {
            properties = { "command" }
          }
        },
        colorProvider = {
          dynamicRegistration = true
        },
        completion = {
          completionItem = {
            commitCharactersSupport = false,
            deprecatedSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            insertReplaceSupport = true,
            insertTextModeSupport = {
              valueSet = { 1 }
            },
            labelDetailsSupport = true,
            preselectSupport = false,
            resolveSupport = {
              properties = { "additionalTextEdits", "command", "documentation" }
            },
            snippetSupport = true,
            tagSupport = {
              valueSet = { 1 }
            }
          },
          completionItemKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
          },
          completionList = {
            itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" }
          },
          contextSupport = true,
          dynamicRegistration = false,
          insertTextMode = 1
        },
        declaration = {
          linkSupport = true
        },
        definition = {
          dynamicRegistration = true,
          linkSupport = true
        },
        diagnostic = {
          dataSupport = true,
          dynamicRegistration = true,
          relatedDocumentSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        documentHighlight = {
          dynamicRegistration = false
        },
        documentLink = {
          dynamicRegistration = false,
          tooltipSupport = false
        },
        documentSymbol = {
          dynamicRegistration = false,
          hierarchicalDocumentSymbolSupport = true,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          },
          tagSupport = {
            valueSet = { 1 }
          }
        },
        foldingRange = {
          dynamicRegistration = false,
          foldingRange = {
            collapsedText = true
          },
          foldingRangeKind = {
            valueSet = { "comment", "imports", "region" }
          },
          lineFoldingOnly = true
        },
        formatting = {
          dynamicRegistration = true
        },
        hover = {
          contentFormat = { "markdown", "plaintext" },
          dynamicRegistration = true
        },
        implementation = {
          linkSupport = true
        },
        inlayHint = {
          dynamicRegistration = true,
          resolveSupport = {
            properties = { "textEdits", "tooltip", "location", "command" }
          }
        },
        inlineCompletion = {
          dynamicRegistration = false
        },
        linkedEditingRange = {
          dynamicRegistration = false
        },
        onTypeFormatting = {
          dynamicRegistration = false
        },
        publishDiagnostics = {
          dataSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        rangeFormatting = {
          dynamicRegistration = true,
          rangesSupport = true
        },
        references = {
          dynamicRegistration = false
        },
        rename = {
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          prepareSupport = true
        },
        selectionRange = {
          dynamicRegistration = false
        },
        semanticTokens = {
          augmentsSyntaxTokens = true,
          dynamicRegistration = false,
          formats = { "relative" },
          multilineTokenSupport = true,
          overlappingTokenSupport = true,
          requests = {
            full = {
              delta = true
            },
            range = true
          },
          serverCancelSupport = false,
          tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
          tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
        },
        signatureHelp = {
          dynamicRegistration = false,
          signatureInformation = {
            activeParameterSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            noActiveParameterSupport = true,
            parameterInformation = {
              labelOffsetSupport = true
            }
          }
        },
        synchronization = {
          didSave = true,
          dynamicRegistration = false,
          willSave = true,
          willSaveWaitUntil = true
        },
        typeDefinition = {
          linkSupport = true
        }
      },
      window = {
        showDocument = {
          support = true
        },
        showMessage = {
          messageActionItem = {
            additionalPropertiesSupport = true
          }
        },
        workDoneProgress = true
      },
      workspace = {
        applyEdit = true,
        codeLens = {
          refreshSupport = true
        },
        configuration = true,
        diagnostics = {
          refreshSupport = true
        },
        didChangeConfiguration = {
          dynamicRegistration = false
        },
        didChangeWatchedFiles = {
          dynamicRegistration = true,
          relativePatternSupport = true
        },
        fileOperations = {
          didCreate = false,
          didDelete = false,
          didRename = false,
          dynamicRegistration = false,
          willCreate = false,
          willDelete = false,
          willRename = false
        },
        inlayHint = {
          refreshSupport = true
        },
        semanticTokens = {
          refreshSupport = true
        },
        symbol = {
          dynamicRegistration = false,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          }
        },
        workspaceEdit = {
          changeAnnotationSupport = {
            groupsOnLabel = true
          },
          normalizesLineEndings = true,
          resourceOperations = { "rename", "create", "delete" }
        },
        workspaceFolders = true
      }
    }
  - cmd: { "ruff", "server" }
  - filetypes: python
  - root_markers: { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }

- rust_analyzer:
  - capabilities: {
      general = {
        positionEncodings = { "utf-8", "utf-16", "utf-32" }
      },
      textDocument = {
        callHierarchy = {
          dynamicRegistration = false
        },
        codeAction = {
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
            }
          },
          dataSupport = true,
          disabledSupport = true,
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          isPreferredSupport = true,
          resolveSupport = {
            properties = { "edit", "command" }
          }
        },
        codeLens = {
          dynamicRegistration = false,
          resolveSupport = {
            properties = { "command" }
          }
        },
        colorProvider = {
          dynamicRegistration = true
        },
        completion = {
          completionItem = {
            commitCharactersSupport = false,
            deprecatedSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            insertReplaceSupport = true,
            insertTextModeSupport = {
              valueSet = { 1 }
            },
            labelDetailsSupport = true,
            preselectSupport = false,
            resolveSupport = {
              properties = { "additionalTextEdits", "command", "documentation" }
            },
            snippetSupport = true,
            tagSupport = {
              valueSet = { 1 }
            }
          },
          completionItemKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
          },
          completionList = {
            itemDefaults = { "editRange", "insertTextFormat", "insertTextMode", "data" }
          },
          contextSupport = true,
          dynamicRegistration = false,
          insertTextMode = 1
        },
        declaration = {
          linkSupport = true
        },
        definition = {
          dynamicRegistration = true,
          linkSupport = true
        },
        diagnostic = {
          dataSupport = true,
          dynamicRegistration = true,
          relatedDocumentSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        documentHighlight = {
          dynamicRegistration = false
        },
        documentLink = {
          dynamicRegistration = false,
          tooltipSupport = false
        },
        documentSymbol = {
          dynamicRegistration = false,
          hierarchicalDocumentSymbolSupport = true,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          },
          tagSupport = {
            valueSet = { 1 }
          }
        },
        foldingRange = {
          dynamicRegistration = false,
          foldingRange = {
            collapsedText = true
          },
          foldingRangeKind = {
            valueSet = { "comment", "imports", "region" }
          },
          lineFoldingOnly = true
        },
        formatting = {
          dynamicRegistration = true
        },
        hover = {
          contentFormat = { "markdown", "plaintext" },
          dynamicRegistration = true
        },
        implementation = {
          linkSupport = true
        },
        inlayHint = {
          dynamicRegistration = true,
          resolveSupport = {
            properties = { "textEdits", "tooltip", "location", "command" }
          }
        },
        inlineCompletion = {
          dynamicRegistration = false
        },
        linkedEditingRange = {
          dynamicRegistration = false
        },
        onTypeFormatting = {
          dynamicRegistration = false
        },
        publishDiagnostics = {
          dataSupport = true,
          relatedInformation = true,
          tagSupport = {
            valueSet = { 1, 2 }
          }
        },
        rangeFormatting = {
          dynamicRegistration = true,
          rangesSupport = true
        },
        references = {
          dynamicRegistration = false
        },
        rename = {
          dynamicRegistration = true,
          honorsChangeAnnotations = true,
          prepareSupport = true
        },
        selectionRange = {
          dynamicRegistration = false
        },
        semanticTokens = {
          augmentsSyntaxTokens = true,
          dynamicRegistration = false,
          formats = { "relative" },
          multilineTokenSupport = true,
          overlappingTokenSupport = true,
          requests = {
            full = {
              delta = true
            },
            range = true
          },
          serverCancelSupport = false,
          tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
          tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
        },
        signatureHelp = {
          dynamicRegistration = false,
          signatureInformation = {
            activeParameterSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            noActiveParameterSupport = true,
            parameterInformation = {
              labelOffsetSupport = true
            }
          }
        },
        synchronization = {
          didSave = true,
          dynamicRegistration = false,
          willSave = true,
          willSaveWaitUntil = true
        },
        typeDefinition = {
          linkSupport = true
        }
      },
      window = {
        showDocument = {
          support = true
        },
        showMessage = {
          messageActionItem = {
            additionalPropertiesSupport = true
          }
        },
        workDoneProgress = true
      },
      workspace = {
        applyEdit = true,
        codeLens = {
          refreshSupport = true
        },
        configuration = true,
        diagnostics = {
          refreshSupport = true
        },
        didChangeConfiguration = {
          dynamicRegistration = false
        },
        didChangeWatchedFiles = {
          dynamicRegistration = true,
          relativePatternSupport = true
        },
        fileOperations = {
          didCreate = false,
          didDelete = false,
          didRename = false,
          dynamicRegistration = false,
          willCreate = false,
          willDelete = false,
          willRename = false
        },
        inlayHint = {
          refreshSupport = true
        },
        semanticTokens = {
          refreshSupport = true
        },
        symbol = {
          dynamicRegistration = false,
          symbolKind = {
            valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
          }
        },
        workspaceEdit = {
          changeAnnotationSupport = {
            groupsOnLabel = true
          },
          normalizesLineEndings = true,
          resourceOperations = { "rename", "create", "delete" }
        },
        workspaceFolders = true
      }
    }
  - cmd: { "rust-analyzer" }
  - filetypes: rust
  - root_markers: { "Cargo.toml", "rust-project.json", ".git" }


vim.lsp: File Watcher ~
- file watching "(workspace/didChangeWatchedFiles)" disabled on all clients

vim.lsp: Position Encodings ~
- No active clients

==============================================================================
vim.pack:                                                                   ✅

vim.pack: basics ~
- ✅ OK `vim.pack` is not used

==============================================================================
vim.provider:                                                               ✅

Clipboard (optional) ~
- ✅ OK Clipboard tool found: pbcopy

Node.js provider (optional) ~
- Disabled (loaded_node_provider=0).

Perl provider (optional) ~
- Disabled (loaded_perl_provider=0).

Python 3 provider (optional) ~
- Disabled (loaded_python3_provider=0).

Ruby provider (optional) ~
- Disabled (loaded_ruby_provider=0).

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
checkhealth:   9% checking blink.cmpcheckhealth:  18% checking configcheckhealth:  27% checking lazycheckhealth:  36% checking lazyvimcheckhealth:  45% checking snackscheckhealth:  54% checking vim.deprecatedcheckhealth:  63% checking vim.healthcheckhealth:  72% checking vim.lspcheckhealth:  81% checking vim.packcheckhealth:  90% checking vim.providercheckhealth: 100% checking vim.treesittercheckhealth: checks done
```
