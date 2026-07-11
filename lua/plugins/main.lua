---@diagnostic disable: undefined-global
return {
	{
		"samharju/synthweave.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("synthweave")
			vim.api.nvim_set_hl(0, "@custom.red", { bg = "#a04040" })
			vim.api.nvim_set_hl(0, "@custom.comment", { bg = "#4040a0" })
			vim.api.nvim_set_hl(0, "@custom.suggest", { bg = "#3f6f4a" })
			vim.api.nvim_set_hl(0, "@custom.previous", { bg = "#a85a30" })
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
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
		config = function()
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			npairs.setup({})
			npairs.add_rule(Rule("\\(", "\\)", "tex"))
			npairs.add_rule(Rule("\\[", "\\]", "tex"))
			npairs.add_rule(Rule("\\{", "\\}", "tex"))
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
			vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_imaps_enabled = 0
      vim.g.vimtex_indent_enabled = 0
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
					"-pdf",
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
					{ open = "\\{", close = "\\}" },
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
	-- },

	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
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
	--
	-- {
	--   'rafamadriz/friendly-snippets',
	--   lazy = false;
	-- },
	--
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
	--
	-- {
	--   'neovim/nvim-lspconfig'
	-- },
	--
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"L3MON4D3/LuaSnip",
		},

		opts = {
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
			},
			snippets = {
				preset = "luasnip",
			},
			keymap = {
				preset = "default",
				["<S-CR>"] = { "accept", "fallback" },
				["<A-Tab>"] = { "select_next", "fallback" },
				["<A-S-Tab>"] = { "select_prev", "fallback" },
			},
			completion = {
				list = {
					selection = {
						preselect = true,
					},
				},
			},
		},
	},

	-- {
	-- "gelguy/wilder.nvim",
	-- },

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
					enabled = false,
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
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>he", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			for i = 1, 9 do
				vim.keymap.set("n", "<leader>" .. i, function()
					harpoon:list():select(i)
				end)
			end
		end,
	},
	-- {
	-- 	"SirVer/ultisnips",
	-- 	init = function()
	-- 		vim.g.UltiSnipsExpandTrigger = "<C-l>"
	-- 		vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
	-- 		vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
	-- 		vim.g.UltiSnipsRemoveSelectModeMappings = 0
	-- 	end,
	-- 	dependencies = { "honza/vim-snippets" },
	-- },
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 3,
				trim_scope = "outer",
			})
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},

	-- {
	-- 	"iurimateus/luasnip-latex-snippets.nvim",
	-- 	dependencies = {
	-- 		"L3MON4D3/LuaSnip",
	-- 		"lervag/vimtex",
	-- 	},
	-- 	ft = "tex",
	-- 	config = function()
	-- 		require("luasnip-latex-snippets").setup()
	-- 	end,
	-- },
}
