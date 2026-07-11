---@diagnostic disable: undefined-global

-- TELESCOPE
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fe", ":Neotree toggle<CR>")

-- Open kitty term from neovim
vim.keymap.set("n", "<leader><CR>", function()
	vim.cmd("RunInKitty")
end, { noremap = true, silent = true })

-- local ls = require("luasnip")

-- vim.keymap.set({"i"}, "<Tab>", function() ls.expand_or_jumpable() end, { silent = true})
-- vim.keymap.set({"i"}, "<Tab>", function() ls.jump(1) end, { silent = true})
-- vim.keymap.set({"i"}, "<S-Tab>", function() ls.jump(-1) end, { silent = true})
--
--
-- KNAP KEYBINDS

vim.keymap.set({ "n", "v", "i" }, "<F5>", function()
	require("knap").process_once()
end)
vim.keymap.set({ "n", "v", "i" }, "<F6>", function()
	require("knap").close_viewer()
end)
vim.keymap.set({ "n", "v", "i" }, "<F7>", function()
	require("knap").toggle_autopreviewing()
end)
vim.keymap.set({ "n", "v", "i" }, "<F8>", function()
	require("knap").forward_jump()
end)

-- AUTOSAVE
local function toggle_auto_save()
	local buf = vim.api.nvim_get_current_buf()
	local auto_save_key = "auto_save_" .. buf
	local is_enabled = vim.g[auto_save_key] or false

	if is_enabled then
		vim.cmd("augroup AutoSave_" .. buf .. " | autocmd! | augroup END")
		vim.notify("Auto-save OFF", vim.log.levels.WARN, { timeout = 1500 })
		vim.g[auto_save_key] = false
	else
		vim.opt.updatetime = 500
		vim.cmd([[
    augroup AutoSave_]] .. buf .. [[
    autocmd! 
    autocmd CursorHold,CursorHoldI <buffer> if &modified | silent! write | endif
    augroup END
    ]])
		vim.notify("Auto-save ON", vim.log.levels.INFO, { timeout = 1500 })
		vim.g[auto_save_key] = true
	end
end
vim.keymap.set("n", "<leader>as", toggle_auto_save, { desc = "Toggle auto-save (current buffer)" })

-- RUN FILE IN KITTY WINDOW
vim.api.nvim_create_user_command("RunInKitty", function()
	local file = vim.fn.expand("%:p")
	local ext = vim.fn.expand("%:e")
	local cmd
	local init = "&"

	if ext == "jl" then
		init = "julia &"
		cmd = 'include("' .. file .. '")\\n main()'
	elseif ext == "py" then
		cmd = "python " .. file
	elseif ext == "js" then
		cmd = "node " .. file
	end
	vim.notify(ext)

	local socket = "/tmp/mykitty"
	local handle = io.popen("kitty @ --to unix:" .. socket .. " ls 2>/dev/null")
	local result = handle:read("*a")

	local function send()
		os.execute("kitty @ --to unix:" .. socket .. " send-text '" .. cmd .. "\\n'")
	end

	if result == "" then
		os.execute("kitty --detach --listen-on unix:" .. socket .. init)
		vim.defer_fn(send, 500)
	else
		vim.notify("sending!")
		send()
	end
end, {})

-- CONFORM (AUTOFORMATTER)

vim.keymap.set("n", "<leader>fo", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })

-- QUARTO

vim.keymap.set("n", "<leader>qp", function()
	require("quarto").quartoPreview()
end)
