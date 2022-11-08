-- Bootstrap packer in not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Helper to load plugin configuration
local function get_config(name)
  return string.format('require("config/%s")', name)
end

local packer = require("packer")

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of jobs. nil = no limit. Set to 20 to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Plugins
return require("packer").startup(function(use)
  -- Packer manages itself
  use("wbthomason/packer.nvim")

  -- Vim starting screen
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = get_config("ui.alpha"),
  })

  use('famiu/bufdelete.nvim')

  use({
    "anuvyklack/hydra.nvim",
    requires = {
      { "s1n7ax/nvim-window-picker", config = get_config("ui.window-picker") },
    },
    config = get_config("hydra"),
  })

  -- Visual
  use({ "lukas-reineke/indent-blankline.nvim", config = get_config("coding.indent_blankline") })
  use({
    "folke/which-key.nvim",
    config = get_config("ui.which_key"),
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = get_config("ui.lualine"),
  })
  use({ "nvim-treesitter/nvim-treesitter", config = get_config("coding.treesitter") }) -- Treesitter Syntax Highlighting
  use({ "sindrets/winshift.nvim", config = get_config("ui.winshift") })

  -- File manager
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    config = get_config("ui.telescope"),
  })

  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree*",
    config = get_config("ui.neotree"),
  })

  -- Tim Pope
  use("tpope/vim-surround")
  use("tpope/vim-commentary")
  use("tpope/vim-fugitive")

  -- General
  use("henrik/vim-indexed-search")

  -- Snippets
  use("rafamadriz/friendly-snippets")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  -- Terminal
  use({ "akinsho/toggleterm.nvim", tag = "2.3*", config = get_config("ui.toggleterm") })

  -- Nvim dap
  use({
    "mfussenegger/nvim-dap",
    requires = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
  })

  -- LSP
  use("onsails/lspkind-nvim")
  use({
    "williamboman/mason.nvim",
    -- module = "mason-tool-installer",
    requires = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
    -- cmd = "Mason*",
    config = get_config("lsp.mason"),
  })
  use({ "neovim/nvim-lspconfig", config = get_config("lsp.lspconfig") })
  use({ "simrat39/rust-tools.nvim", ft = "rs", config = get_config("lsp.rust_tools") })
  use({ "SmiteshP/nvim-navic", config = get_config("lsp/nvim_navic") })
  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  })

  -- Null-ls
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = get_config("lsp.null_ls"),
  })

  -- Cmp
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = get_config("coding.cmp"),
  })

  -- Colorschemes
  local theme = require("settings").colorscheme
  if theme == "tokyonight" then
    use({ "folke/tokyonight.nvim", config = get_config("colorschemes.tokyonight") })
  elseif theme == "nightfox" then
    use({ "EdenEast/nightfox.nvim", config = get_config("colorschemes.nightfox") })
  elseif theme == "onedark" then
    use({ "navarasu/onedark.nvim", config = get_config("colorschemes.onedark") })
  elseif theme == "gruvbox" then
    use({ "ellisonleao/gruvbox.nvim", config = get_config("colorschemes.gruvbox") })
  else
    vim.cmd("colorscheme " .. theme)
  end

  -- Boostrap packer
  if packer_bootstrap then
    require("packer").sync()
  end
end)
