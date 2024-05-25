-- https://github.com/folke/noice.nvim
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- true: use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  views = {
    -- notify = {
    --   backend = "notify",
    --   fallback = "mini",
    --   format = "notify",
    --   replace = false,
    --   merge = false,
    -- },
    popupmenu = {
      relative = "editor",
      zindex = 65,
      position = "50%", -- when auto, then it will be positioned to the cmdline or cursor
      -- position = "auto", -- when auto, then it will be positioned to the cmdline or cursor
      size = {
        width = 80,
        height = 40,
        -- width = "auto",
        -- width = "40%",
        -- height = "auto",
        -- max_height = 20,
        -- min_width = 10,
      },
      win_options = {
        cursorline = true,
        cursorlineopt = "line",
        winhighlight = {
          Normal = "NoicePopupmenu", -- change to NormalFloat to make it look like other floats
          FloatBorder = "NoicePopupmenuBorder", -- border highlight
          CursorLine = "NoicePopupmenuSelected", -- used for highlighting the selected item
          PmenuMatch = "NoicePopupmenuMatch", -- used to highlight the part of the item that matches the input
        },
      },
      border = {
        padding = { 0, 1 },
      },
    },
  },
})
