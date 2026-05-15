---@diagnostic disable: undefined-global
return {
	{
		"samharju/synthweave.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("synthweave")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				presets = {
					bottom_search = true,
					long_message_to_split = true,
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slant",
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "palenight",
				},
				sections = {
					lualine_x = { "filetype" },
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						treesitter = true,
						filetype_hook = function(filepath, bufnr, opts)
							if filepath:match("%.s$") then
								vim.bo[bufnr].filetype = "asm"
								return true
							end
							return true
						end,
					},
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
		init = function()
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			npairs.add_rule(Rule("\\(", "\\)", "tex"))
			npairs.add_rule(Rule("\\[", "\\]", "tex"))
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = "./aux",
				out_dir = "./out",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				hooks = {},
				options = {
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}
		end,
	},
	{
		"abecodes/tabout.nvim",
		lazy = false,
		config = function()
			require("tabout").setup({
				tabout = {
					{ open = "\\(", close = "\\)" },
					{ open = "\\[", close = "\\]" },
				},
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({})
		end,
	},
	-- {
	--   'dense-analysis/ale',
	--   config = function()
	--   end,
	-- }
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	-- {
	--   'hrsh7th/nvim-cmp',
	--   config = function()
	--     local cmp = require("cmp")
	--     cmp.setup({
	--       snippet = {
	--         expand = function(args)
	--           require('luasnip').lsp_expand(args.body)
	--         end,
	--       },
	--       window = {
	--         completion = cmp.config.window.bordered()
	--       },
	--       sources = cmp.config.sources({
	--         { name = 'luasnip'}},{
	--         { name = 'buffer' }}
	--       )
	--     })
	--   end,
	-- },
	-- {
	--   'rafamadriz/friendly-snippets',
	--   lazy = false;
	-- },
	-- {
	--   'nvim-mini/mini.nvim',
	--   version = '*',
	--   config = function()
	--     require('mini.completion').setup({
	--       mappings = {scroll_down = "<TAB>",
	--       scroll_up = "<S-TAB>"}
	--     })
	--   end,
	-- },
	-- {
	--   'neovim/nvim-lspconfig'
	-- }
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
		},
	},
	{
		"gelguy/wilder.nvim",
	},
	{

		"OXY2DEV/markview.nvim",
		lazy = false,
	},

	{
		"frabjous/knap",
	},
	{
		"mason-org/mason-lspconfig.nvim",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	{
		"folke/snacks.nvim",
		opts = {
			image = {
				math = {
					enabled = true,
					latex = {
						font_size = "Large",
						packages = { "amsmath", "amssymb", "amsfonts", "mathtools" },
						tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{xcolor,amsmath,amssymb,amsfonts,mathtools,ecstyle}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
					},
				},
			},
		},
	},
	{
		"chrisbra/unicode.vim",
	},
	{
		"gruvw/strudel.nvim",
		build = "npm ci",
		config = function()
			require("strudel").setup()
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "black" },
					lua = { "stylua" },
					javascript = { "prettierd", "prettier" },
				},
				-- format_on_save = {
				--   timeout_ms = 500,
				--   lsp_fallback = false,
				-- }
			})
		end,
	},
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		opts = {
			-- or "fzf-lua" or "snacks" or "default"
			picker = "telescope",
			-- bare Octo command opens picker of commands
			enable_builtin = true,
		},
		keys = {
			{
				"<leader>oi",
				"<CMD>Octo issue list<CR>",
				desc = "List GitHub Issues",
			},
			{
				"<leader>op",
				"<CMD>Octo pr list<CR>",
				desc = "List GitHub PullRequests",
			},
			{
				"<leader>od",
				"<CMD>Octo discussion list<CR>",
				desc = "List GitHub Discussions",
			},
			{
				"<leader>on",
				"<CMD>Octo notification list<CR>",
				desc = "List GitHub Notifications",
			},
			{
				"<leader>os",
				function()
					require("octo.utils").create_base_search_command({ include_current_repo = true })
				end,
				desc = "Search GitHub",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- OR "ibhagwan/fzf-lua",
			-- OR "folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"mcnangus/pr-comments.nvim",
		config = function()
			-- Call the function to load the quickfix list as diagnostics
			vim.keymap.set("", "<Leader>k", require("pr-comments").fetch, { desc = "Toggle gh pr comments" })
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>fe",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"tamton-aquib/duck.nvim",
		config = function()
			vim.keymap.set("n", "<leader>dd", function()
				require("duck").hatch()
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
			vim.keymap.set("n", "<leader>da", function()
				require("duck").cook_all()
			end, {})
		end,
	},
	{
		"eandrju/cellular-automaton.nvim",
	},

	{ "seandewar/killersheep.nvim" },
}
