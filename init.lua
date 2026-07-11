---@diagnostic disable: undefined-global

vim.api.nvim_set_hl(0, "@custom.red", { fg = "#ff5555", bold = true })
require("set")
require("lazy-init")
require("keymaps")
require("lsp")
require("autocmds")

-- require("luasnip.loaders.from_vscode").lazy_load()
-- require('vim._core.ui2').enable({})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- or "…"
		spacing = 2,
	},
	update_in_insert = true, -- <--- key option
})

vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3e4451" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3e4451" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3e4451" })

vim.filetype.add({
	extension = {
		sage = "python",
		s = "asm",
	},
})

-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	pattern = "*.tex",
-- 	callback = function()
-- 		vim.opt_local.spell = true
-- 	end,
-- })

vim.g.UltiSnipsEnableAutoTrigger = 1
vim.opt.clipboard:append('unnamedplus')

