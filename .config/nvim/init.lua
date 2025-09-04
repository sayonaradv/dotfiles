local opt = vim.opt
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------
-- GENERAL OPTIONS
-----------------------------------------------------------
vim.g.mapleader = " "

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.swapfile = false
opt.cursorline = true
opt.scrolloff = 8
opt.hlsearch = false
opt.cursorcolumn = false
opt.guicursor = ""
opt.termguicolors = true
opt.ignorecase = true
opt.winborder = "rounded"
opt.signcolumn = "yes"
opt.undofile = true
opt.incsearch = true

-----------------------------------------------------------
-- LSP CONFIGURATION
-----------------------------------------------------------
vim.lsp.enable({ "ruff", "ty", "luals", "clangd", "rust-analyzer" })
vim.diagnostic.config({ virtual_text = true })

-- LSP keymaps
autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
  callback = function(args)
    local map = vim.keymap.set
    local opts = { buffer = args.buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gs", vim.lsp.buf.signature_help, opts)
    map("n", "gh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
  end,
})

-- Disable Ruff hover (use Pyright instead)
autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

-----------------------------------------------------------
-- PLUGIN INSTALLATIONS
-----------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
  { src = "https://github.com/onsails/lspkind.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/dmtrKovalenko/fff.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
  { src = "https://github.com/vieitesss/miniharp.nvim" },
  { src = "https://github.com/Koalhack/darcubox-nvim" },
  { src = "https://github.com/sainnhe/gruvbox-material" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
}, { load = true })

-----------------------------------------------------------
-- TREESITTER
-----------------------------------------------------------
local parsers = { "lua", "python", "rust" }
local nts = require("nvim-treesitter")
nts.setup()
nts.install(parsers)

-- Update parsers on plugin update
autocmd("PackChanged", {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.schedule(function() nts.update() end)
    end
  end,
})

-- Enable Treesitter highlighting & indents
autocmd("FileType", {
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if not lang then
      vim.notify("TS cannot determine language.")
      return
    end

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-----------------------------------------------------------
-- PLUGIN CONFIGURATIONS
-----------------------------------------------------------

-- Oil"
require("oil").setup({
  keymaps = {
    ["l"] = { "actions.select", mode = "n" },
    ["h"] = { "actions.parent", mode = "n" },
  },
  view_options = { show_hidden = true },
})

-- Blink CMP
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  completion = {
    documentation = { auto_show = false },
    menu = {
      border = "none",
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then icon = dev_icon end
              else
                icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
              end
              return icon .. ctx.icon_gap
            end,
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

-- FFF
require("fff").setup({
  prompt = "👻 ",
  debug = { show_scores = true },
})

-- Mini
require("mini.move").setup()

-- Snacks
require("snacks").setup({
  picker = { enabled = true },
  lazygit = { enabled = true },
  gitbrowse = { enabled = true },
  indent = { enabled = true },
})

-- Miniharp
require("miniharp").setup()

-- Darkubox colorscheme
require("darcubox").setup({
  options = {
    transparent = true,
    styles = {
      comments = { italic = true }, -- italic
      functions = { bold = true }, -- bold
      keywords = { italic = true },
      types = { italic = true, bold = true }, -- italics and bold
    },
  },
})

vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_float_style = "none"

vim.cmd.colorscheme("gruvbox-material")

-----------------------------------------------------------
-- KEYMAPS
-----------------------------------------------------------

-- Save & reload config
keymap("n", "<leader>r", ":update<CR> :so<CR>")

-- Escape
keymap("i", "jk", "<Esc>")
keymap("i", "kj", "<Esc>")

-- Splits
keymap("n", "sv", "<cmd>vsplit<CR>")
keymap("n", "ss", "<cmd>split<CR>")
keymap("n", "sd", "<cmd>close<CR>")

-- Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Scroll
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Select all
keymap("n", "sa", "gg<S-v>G")

-- Helpful
keymap("n", "<leader>ff", vim.lsp.buf.format)
keymap("x", "y", [["+y]])
keymap("n", "<leader>U", "<cmd>lua vim.pack.update()<CR>")
keymap({ "n", "v", "x" }, "<leader>y", '"+y')
keymap({ "n", "v", "x" }, "<leader>p", '"+p')

-- File explorers
keymap("n", "<leader><leader>", function() require("fff").find_files() end)
keymap("n", "-", "<CMD>Oil<CR>")

-- -- Treesitter textobjects
local nts_select = require("nvim-treesitter-textobjects.select").select_textobject
local nts_move = require("nvim-treesitter-textobjects.move")
keymap("x", "af", function() nts_select("@function.outer", "textobjects") end)
keymap("x", "if", function() nts_select("@function.inner", "textobjects") end)
keymap("x", "ac", function() nts_select("@class.outer", "textobjects") end)
keymap("x", "ic", function() nts_select("@class.inner", "textobjects") end)

keymap({ "n", "x" }, "]f", function() nts_move.goto_next_start("@function.outer", "textobjects") end)
keymap({ "n", "x" }, "]c", function() nts_move.goto_next_start("@class.outer", "textobjects") end)
keymap({ "n", "x" }, "]l", function() nts_move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects") end)
keymap({ "n", "x" }, "]s", function() nts_move.goto_next_start("@local.scope", "locals") end)
keymap({ "n", "x" }, "]F", function() nts_move.goto_next_end("@function.outer", "textobjects") end)
keymap({ "n", "x" }, "]C", function() nts_move.goto_next_end("@class.outer", "textobjects") end)
keymap({ "n", "x" }, "[f", function() nts_move.goto_previous_start("@function.outer", "textobjects") end)
keymap({ "n", "x" }, "[c", function() nts_move.goto_previous_start("@class.outer", "textobjects") end)
keymap({ "n", "x" }, "[F", function() nts_move.goto_previous_end("@function.outer", "textobjects") end)
keymap({ "n", "x" }, "[C", function() nts_move.goto_previous_end("@class.outer", "textobjects") end)

-- Snacks pickers
keymap("n", "<leader>/", function() Snacks.picker.grep() end)
keymap("n", "<leader>n", function() Snacks.picker.notifications() end)
keymap("n", "<leader>x", function() Snacks.picker.diagnostics_buffer() end)
keymap("n", "<leader>X", function() Snacks.picker.diagnostics() end)
keymap("n", "<leader>gg", function() Snacks.lazygit() end)
keymap("n", "<leader>gB", function() Snacks.gitbrowse() end)

-- Miniharpoon
keymap("n", "<leader>m", require("miniharp").toggle_file)
keymap("n", "<C-n>", require("miniharp").next)
keymap("n", "<C-p>", require("miniharp").prev)
keymap("n", "<leader>mx", require("miniharp").clear)
