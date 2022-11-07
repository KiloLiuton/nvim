local M = {}

function M.setup(_)
  require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
end

return M
