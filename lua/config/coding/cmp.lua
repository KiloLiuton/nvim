local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "path" },
    { name = "nvim_lua", keyword_length = 2 },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip", keyword_length = 2 },
    { name = "buffer", keyword_length = 2 },
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      max_widt = 50,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[lua]",
        path = "[path]",
        luasnip = "[snip]",
      },
    }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})
