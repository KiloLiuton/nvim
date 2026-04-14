return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "SmiteshP/nvim-navic" },
		config = function()
			-- ════════════════════════════════════════════════════════════════════
			-- LSP Keymaps
			-- ════════════════════════════════════════════════════════════════════
			local function setup_keymaps(bufnr)
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
				end
				-- Hover & Signature
				map("n", "K",
					function() vim.lsp.buf.hover({ border = "rounded", max_height = 25, max_width = 120 }) end,
					"Hover")
				map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
				-- Diagnostics navigation
				map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")
				map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
				-- <leader>c = Code
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
				map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostic")
				map("n", "<leader>cv", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",
					"Definition in Vsplit")
				-- <leader>l = LSP
				map("n", "<leader>li", "<cmd>LspInfo<cr>", "LSP Info")
				map("n", "<leader>lr", "<cmd>LspRestart<cr>", "LSP Restart")
				map("n", "<leader>lh", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
						{ bufnr = bufnr })
				end, "Toggle Inlay Hints")
			end

			-- ════════════════════════════════════════════════════════════════════
			-- Attach Auto Command
			-- ════════════════════════════════════════════════════════════════════
			local navic = require("nvim-navic")
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					setup_keymaps(args.buf)

					if client.server_capabilities.documentSymbolProvider then
						navic.attach(client, args.buf)
					end

					if client.server_capabilities.documentHighlightProvider then
						local group = vim.api.nvim_create_augroup(
							"LspDocumentHighlight_" .. args.buf, { clear = true })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = args.buf,
							group = group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = args.buf,
							group = group,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- ════════════════════════════════════════════════════════════════════
			-- Diagnostic Configuration
			-- ════════════════════════════════════════════════════════════════════
			vim.diagnostic.config({
				virtual_text = false,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = true, header = "", prefix = "" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason_lsp = require("mason-lspconfig")
			local lsp = require("lspconfig")

			local function default_setup(server_name)
				lsp[server_name].setup({})
			end

			local handlers = {
				default_setup,
				["lua_ls"] = function()
					lsp.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
									disable = { "inject-field", "undefined-field", "missing-fields" },
								},
								runtime = { version = " LuaJIT" },
								workspace = {
									library = { vim.env.VIMRUNTIME },
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
				end,
			}
			mason_lsp.setup({ handlers = handlers })
		end,
	},
	-- ════════════════════════════════════════════════════════════════════
	-- Completion
	-- ════════════════════════════════════════════════════════════════════
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		-- build = "cargo build --release",
		version = "1.*",
		dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
		opts = {
			snippets = { preset = 'luasnip' },
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			keymap = {
				preset = "default",
				["<tab>"] = { "select_next", "fallback" },
				["<s-tab>"] = { "select_prev", "fallback" },
				["<enter>"] = { "accept", "fallback" },
			},
		},
	},
	-- ════════════════════════════════════════════════════════════════════
	-- Lualine with navic in the winbar
	-- ════════════════════════════════════════════════════════════════════
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			local navic = require("nvim-navic")
			require("lualine").setup({
				sections = {
					lualine_c = {
						{ 'filename' },
						{
							function()
								local location = navic.get_location()
								if location == "" then return "" end

								local parts = vim.split(location, ">")
								local depth = 4
								if #parts > depth then
									parts = vim.list_slice(parts, #parts - depth + 1,
										#parts)
									return "... > " .. table.concat(parts, " > ")
								end
								return location
							end,
							cond = function() return navic.is_available() end,
						}
					}
				},
			})
		end,
	},
}
