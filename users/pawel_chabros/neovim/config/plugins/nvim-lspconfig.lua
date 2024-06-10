local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")
local wk = require("which-key")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local set = vim.keymap.set

lsp.format_on_save({
  servers = {
    ["rust-analyzer"] = { "rust" },
  },
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  client.server_capabilities.semanticTokensProvider = nil
  if client.server_capabilities.completion then
    require("completion").on_attach(client, bufnr)
  end
  if client.name == "ruff_lsp" then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end)

wk.register({ c = { name = "Code" } }, { prefix = "<leader>" })
wk.register({ c = { name = "Workspace" } }, { prefix = "<leader>" })

set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    set("n", "gD", vim.lsp.buf.declaration, opts)
    set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
    set("n", "H", vim.lsp.buf.hover, { buffer = ev.buf, silent = true })
    set("n", "<leader>co", ":OrganizeImports<CR>", { desc = "Organize imports" })
    set("n", "gi", vim.lsp.buf.implementation, opts)
    set("n", "<space>cs", vim.lsp.buf.signature_help, opts)
    set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    set("n", "<space>cr", vim.lsp.buf.rename, { desc = "Rename" })
    set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
    set("n", "gr", vim.lsp.buf.references, opts)
    set("n", "<space>cf", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format" })
  end,
})

lspconfig.bashls.setup({})
lspconfig.lua_ls.setup({
  capabilities = capabilities,
})
lspconfig.html.setup({
  capabilities = capabilities,
  init_options = {
    provideFormatter = false,
  },
})
lspconfig.cssls.setup({})
lspconfig.emmet_ls.setup({})
lspconfig.yamlls.setup({})
lspconfig.angularls.setup({})
lspconfig.nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})
lspconfig.pyright.setup({
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
  },
})
lspconfig.ruff_lsp.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.hls.setup({})
lspconfig.r_language_server.setup({})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
  }
})

vim.diagnostic.config({
  update_in_insert = true,
})

-- diagnostic icons
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
