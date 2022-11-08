local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4

require("config.dap").setup()
require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
