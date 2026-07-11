
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


-- AUTOSAVE
local function toggle_auto_save()
	local buf = vim.api.nvim_get_current_buf()
	local enabled = vim.b.auto_save

	if enabled then
		vim.api.nvim_clear_autocmds({
			group = "AutoSave",
			buffer = buf,
		})

		vim.b.auto_save = false
	else
		local group = vim.api.nvim_create_augroup(
			"AutoSave",
			{ clear = false }
		)

		vim.api.nvim_create_autocmd(
			{ "CursorHold", "CursorHoldI" },
			{
				group = group,
				buffer = buf,
				callback = function()
					if vim.bo.modified then
						vim.cmd.write()
					end
				end,
			}
		)

		vim.b.auto_save = true
	end
  vim.notify("Auto-save: " .. tostring(vim.b.auto_save))
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


