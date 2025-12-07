local lsp = require("lsp-zero")
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
  if client.name == "ruff" then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end)

wk.add({
  { "<leader>c", group = "Code" },
  { "<leader>w", group = "Workspace" }
})

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
      vim.lsp.buf.format({
        async = true,
        filter = function(client) return client.name ~= "ts_ls" end,
      })
    end, { desc = "Format" })
  end,
})

local configs = {
  agda_ls = {},
  angularls = {},
  bashls = {},
  cssls = {
    capabilities = capabilities,
    init_options = {
      provideFormatter = false,
    },
  },
  docker_compose_language_service = {},
  dockerls = {},
  emmet_ls = {},
  eslint = {
    settings = {
      codeActionOnSave = {
        enable = true,
        mode = "all"
      },
      format = false,
    },
  },
  gitlab_ci_ls = {},
  html = {
    capabilities = capabilities,
    init_options = {
      provideFormatter = false,
    },
  },
  lua_ls = {
    capabilities = capabilities,
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then return end
      client.config.settings.Lua = vim.tbl_deep_extend(
        'force',
        client.config.settings.Lua,
        {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME }
          }
        }
      )
    end,
    settings = { Lua = {} }
  },
  nginx_language_server = {},
  nil_ls = {
    settings = {
      ['nil'] = {
        formatting = { command = { "alejandra" } },
        nix = {
          maxMemoryMB = 8192,
          flake = {
            autoArchive = true,
            autoEvalInputs = true,
          }
        }
      },
    },
  },
  nushell = {},
  postgres_lsp = {},
  pyright = {
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
    },
  },
  r_language_server = {},
  ruff = {},
  tailwindcss = {
    settings = {
      tailwindCSS = {
        classFunctions = { "cva", "cx" },
      },
    },
  },
  tombi = {},
  ts_ls = {
    commands = {
      OrganizeImports = {
        function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          }
          vim.lsp.buf.execute_command(params)
        end,
        description = "Organize Imports",
      },
    },
  },
  yamlls = {},
}

for language, config in pairs(configs) do
  vim.lsp.config(language, config)
  vim.lsp.enable(language)
end

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
