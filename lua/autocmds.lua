---@diagnostic disable: undefined-global

-- @returns a "clear = true" augroup
local function augroup(name) return vim.api.nvim_create_augroup('sergio-lazyvim_' .. name, { clear = true }) end

local autocmd = vim.api.nvim_create_autocmd

-- tex file options
autocmd("FileType", {
	pattern = { "tex", "*.tex" },
	callback = function(args)
		vim.opt_local.spell = true
		vim.opt_local.spelllang = {"en_gb"}
		vim.opt_local.textwidth = 100
		vim.opt_local.formatoptions:append("t")
		-- vim.treesitter.start(args.buf, "latex")
	end,
})


-- restore cursor to last position on opening file
autocmd('BufReadPost', {
  group = augroup('restore_position'),
  callback = function()
    local exclude = { 'gitcommit' }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then return end

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.api.nvim_feedkeys('zvzz', 'n', true)
    end
  end,
  desc = 'Restore cursor position after reopening file'
})


