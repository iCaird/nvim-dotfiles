---@diagnostic disable: undefined-global
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "*.tex" },
	callback = function(args)
		vim.opt_local.spell = true
		vim.opt_local.spelllang = {"en_gb"}
		vim.opt_local.textwidth = 100
		vim.opt_local.formatoptions:append("t")
		-- vim.treesitter.start(args.buf, "latex")
	end,
})



