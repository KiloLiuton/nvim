local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Shell
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.shellcheck,
    -- Markdown
    null_ls.builtins.formatting.prettier,
    -- Python
    null_ls.builtins.formatting.black,
    -- Dictionary
    null_ls.builtins.hover.dictionary,
  },
})
