local lsp = require("lsp-zero")
local wk = require("which-key")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local set = vim.keymap.set

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	client.server_capabilities.semanticTokensProvider = nil
	if client.server_capabilities.completion then
		require("completion").on_attach(client, bufnr)
	end
end)

wk.register({ c = { name = "Code" } }, { prefix = "<leader>" })
set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		set("n", "gD", vim.lsp.buf.declaration, opts)
		set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		set("n", "H", vim.lsp.buf.hover, opts)
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

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
})
require("lspconfig").html.setup({
	capabilities = capabilities,
})
require("lspconfig").emmet_ls.setup({})
require("lspconfig").tsserver.setup({})
require("lspconfig").rnix.setup({})

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
