---@diagnostic disable: undefined-global
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	pattern = { "tex", "*.tex" },
	callback = function()
		vim.opt_local_spell = true
		vim.opt_local.spelllang = "en_gb"
		vim.opt_local.textwidth = 100
		vim.opt_local.formatoptions:append("t")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function(args)
		vim.treesitter.start(args.buf, "latex")
	end,
})
