---@diagnostic disable: undefined-global
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	pattern = { "tex", "*.tex" },
	callback = function()
		vim.opt_local_spell = true
		vim.opt_local.spelllang = "en_gb"
	end,
})
