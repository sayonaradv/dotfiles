vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    { src = "https://github.com/saghen/blink.cmp",                            version = vim.version.range("^1") },
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
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
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
