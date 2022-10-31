local nvim_lsp = require('lspconfig')
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
-- )

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Shell script
nvim_lsp['bashls'].setup({ capabilities = capabilities })

-- c & cpp
nvim_lsp['clangd'].setup({ capabilities = capabilities })

-- python
nvim_lsp['pyright'].setup({ capabilities = capabilities })

-- rust
-- Managed by rust-tools plugin!

-- lua
nvim_lsp['sumneko_lua'].setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },
            completion = { keywordSnippet = 'Disable', },
            diagnostics = {
                enable = true,
                globals = { 'vim', 'describe', 'it', 'before_each', 'after_each' },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                }
            }
        }
    }
}
