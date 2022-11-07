local M = {}

function M.setup(_)
  require("dap-python").setup("python3", {})
  print("dap-python REQUIRED!")
end

return M
