local navic = require("nvim-navic")

local function attach_navic(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    attach_navic(args)
  end,
})
