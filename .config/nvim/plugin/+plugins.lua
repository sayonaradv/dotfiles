vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
  { src = "https://github.com/onsails/lspkind.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/dmtrKovalenko/fff.nvim" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/vieitesss/miniharp.nvim" },
  { src = "https://github.com/mcauley-penney/techbase.nvim" },
  -- { src = "https://github.com/mitch1000/backpack.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
}, { load = true })

local parsers = {
  "lua",
  "python",
  "rust",
  "sql",
  "toml",
  "yaml",
  "json",
}
require("nvim-treesitter").install(parsers)

require("oil").setup({
  keymaps = {
    ["l"] = { "actions.select", mode = "n" },
    ["h"] = { "actions.parent", mode = "n" },
  },
  view_options = {
    show_hidden = true,
  },
})

require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  completion = {
    documentation = { auto_show = false },

    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then icon = dev_icon end
              else
                icon = require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end

              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then hl = dev_hl end
              end
              return hl
            end,
          },
        },
      },
    },
  },
})

require("fff").setup({
  prompt = "👻 ",
  debug = {
    show_scores = true,
  },
})

require("mini.move").setup()
require("mini.pairs").setup()

require("snacks").setup({
  pciker = { enabled = true },
  lazygit = { enabled = true },
  gitbrowse = { enabled = true },
  indent = { enabled = true },
})

require("miniharp").setup()

require("techbase").setup({
  italic_comments = true,
  transparent = true,
  plugin_support = {
    blink = true,
    gitsigns = true,
    hl_match_area = true,
    lualine = true,
  },
})
