local Hydra = require("hydra")
local dap = require("dap")

local hint = [[
 _n_: step over   _s_: Continue/Start   _b_: Breakpoint
 _i_: step into   _x_: Disconnect       _K_: Hover Variables
 _o_: step out    _X_: Quit             _E_: Evaluate
 _c_: to cursor   _C_: Close UI         _r_: Toggle Repl
 ^
 ^ ^              _q_ | _<Esc>_: exit
]]

local dap_hydra = Hydra({
  hint = hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      border = "rounded",
    },
  },
  name = "dap",
  mode = { "n", "x" },
  body = "<leader>d",
  heads = {
    { "C", "<cmd>lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<cr>", { silent = true } },
    { "E", require("dapui").eval, { silent = true } },
    { "K", require("dap.ui.widgets").hover, { silent = true } },
    { "X", dap.close, { silent = true } },
    { "b", dap.toggle_breakpoint, { silent = true } },
    { "c", dap.run_to_cursor, { silent = true } },
    { "i", dap.step_into, { silent = true } },
    { "n", dap.step_over, { silent = true } },
    { "o", dap.step_out, { silent = true } },
    { "r", dap.repl.toggle, { silent = true } },
    { "s", dap.continue, { silent = true } },
    { "x", dap.disconnect({ terminateDebuggee = false }), { exit = true, silent = true } },
    { "q", nil, { exit = true, nowait = true } },
    { "<Esc>", nil, { exit = true, nowait = true } },
  },
})

Hydra.spawn = function(head)
  if head == "dap-hydra" then
    dap_hydra:activate()
  end
end
