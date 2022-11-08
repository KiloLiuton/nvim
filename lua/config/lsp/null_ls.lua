local nls = require("null-ls")

nls.setup({
  sources = {
    -- Shell
    nls.builtins.formatting.shfmt,
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.code_actions.shellcheck,
    -- Markdown
    nls.builtins.formatting.prettier,
    -- Python
    nls.builtins.formatting.black,
    -- Lua
    nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  },
})
