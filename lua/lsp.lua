---@diagnostic disable: undefined-global
--
vim.lsp.log.set_level("off")
-- vim.lsp.config('lua_ls', {
--   cmd = { "lua-language-server" },
--   filetypes = { "lua" },
-- })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
vim.lsp.enable("lua_ls")
-- vim.opt.completeopt = { "menu", "menuone", "noinsert" }
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
--   end,
-- })
--
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})
--
--
-- vim.lsp.config('ts_ls', {
--   cmd = { 'typescript-language-server', '--stdio'},
--   filetypes = { "javascript", "typescript" }
-- })
vim.lsp.enable("julials")
vim.lsp.config("julials", {})
vim.lsp.enable("ts_ls")
vim.lsp.config("texlab", {
	settings = {

		texlab = {
			diagnostics = {
				ignoredPatterns = { "Unused" }, -- memory leak temp fix https://github.com/latex-lsp/texlab/issues/1551
			},
			chktex = {
				onOpenAndSave = true,
			},
		},
	},
})

vim.lsp.enable("texlab")
vim.lsp.config.bashls = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
}
vim.lsp.enable("bashls")
-- vim.lsp.enable("eslint")
--
--
-- vim.lsp.config.pyright = {
--   cmd = {'pyright'},
--   filetypes = { 'python', 'sage'}
-- }

require("mason").setup()
-- require("mason-lspconfig").setup({
-- 	ensure_installed = { "pyright" },
-- })
