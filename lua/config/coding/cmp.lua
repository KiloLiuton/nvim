local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.close(),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lua' , keyword_length = 2},
        { name = 'nvim_lsp' , keyword_length = 3},
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' , keyword_length = 2},
        { name = 'buffer', keyword_length = 2 },
    },
    formatting = {
        format = require('lspkind').cmp_format {
            with_text = false,
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[lsp]',
                nvim_lua = '[lua]',
                path = '[path]',
                luasnip = '[snip]',
            }
        },
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    }
})
