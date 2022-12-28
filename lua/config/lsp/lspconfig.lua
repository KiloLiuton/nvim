local nvim_lsp = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Servers
local servers = {
  "bashls",
  "clangd",
  "pyright",
  "sumneko_lua",
  -- Managed by rust-tools plugin!
  -- "rust-analyzer",
}

local lua_settings = {
  runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
  completion = { keywordSnippet = "Disable" },
  diagnostics = {
    enable = true,
    globals = { "vim" },
  },
  workspace = {
    library = {
      vim.api.nvim_get_runtime_file("", true),
    },
  },
}

local path = require("lspconfig/util").path
local get_python_path = function(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end
  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = capabilities,
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = get_python_path(config.root_dir)
      end
    end,
    settings = {
      Lua = lua_settings,
    },
  })
end

-- -- Shell script
-- nvim_lsp["bashls"].setup({ capabilities = capabilities })

-- -- c & cpp
-- nvim_lsp["clangd"].setup({ capabilities = capabilities })

-- -- python
-- nvim_lsp["pyright"].setup({ capabilities = capabilities })

-- -- lua
-- nvim_lsp["sumneko_lua"].setup({
--   capabilities = capabilities,
--   settings = { Lua = lua_settings },
-- })
