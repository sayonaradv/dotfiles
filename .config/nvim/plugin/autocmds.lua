local autocmd = vim.api.nvim_create_autocmd

local nts = require("nvim-treesitter")
autocmd("PackChanged", { -- update treesitter parsers/queries with plugin updates
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.schedule(function() nts.update() end)
    end
  end,
})

autocmd("FileType", { -- enable treesitter highlighting and indents
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)

    if not lang then return end

    if vim.treesitter.language.add(lang) then
      if vim.treesitter.query.get(filetype, "indents") then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
      vim.treesitter.start()
    end
  end,
})

-- LSP Keymaps
autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
  callback = function(args)
    local map = vim.keymap.set
    local opts = { buffer = args.buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gs", vim.lsp.buf.signature_help, opts)
  end,
  desc = "LSP: Keymaps",
})

autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})
