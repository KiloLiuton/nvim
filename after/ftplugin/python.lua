local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4

require("config.dap").setup()
-- local dap = require("dap")
-- dap.adapters.python = {
--   type = "executable",
--   command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
--   args = { "-m", "debugpy.adapter" },
-- }

-- dap.configurations.python = {
--   {
--     -- The first three options are required by nvim-dap
--     type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
--     request = "launch",
--     name = "Launch file",

--     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

--     program = "${file}", -- This configuration will launch the current file if used.
--     pythonPath = function()
--       return "/usr/bin/python"
--     end,
--   },
-- }

-- require("config.hydra.dap")
