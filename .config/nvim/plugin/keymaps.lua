vim.g.mapleader = " "

local keymap = vim.keymap.set
local s = { silent = true }

-- Escape
keymap("i", "jk", "<Esc>")
keymap("i", "kj", "<Esc>")

-- Splits
keymap("n", "sv", "<cmd>vsplit<CR>", s)
keymap("n", "ss", "<cmd>split<CR>", s)
keymap("n", "sd", "<cmd>close<CR>", s)

-- Navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Scroll
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Select
keymap("n", "sa", "gg<S-v>G")

-- Helpful
keymap("n", "<leader>ff", ":lua vim.lsp.buf.format()<CR>", s)
keymap("x", "y", [["+y]], s)
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')
keymap("n", "<leader>U", "<cmd>lua vim.pack.update()<CR>", s)

-- Find files
keymap("n", "<leader><leader>", function() require("fff").find_files() end)
keymap("n", "-", "<CMD>Oil<CR>")

-- Treesitter
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

-- Pickers
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
