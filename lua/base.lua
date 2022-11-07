local g = vim.g
local o = vim.o
local opt = vim.opt
local api = vim.api

o.termguicolors = true

-- Performance
o.timeoutlen = 500
o.updatetime = 200

-- Visual
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.cursorline = true
o.scrolloff = 1
o.splitright = true
o.splitbelow = true
o.list = true
o.inccommand = 'nosplit'
o.signcolumn = 'yes'
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
o.winbar = "%{%v:lua.require'winbar'.get_winbar()%}"

-- Text editing configs
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = false
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.clipboard = 'unnamedplus'
o.history = 50

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

opt.diffopt = opt.diffopt + 'algorithm:patience'
opt.mouse = 'a'
opt.completeopt = 'menu,menuone,noselect'
opt.shortmess = opt.shortmess + { c = true }

-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

-- sign({name = 'DiagnosticSignError', text = ''})
-- sign({name = 'DiagnosticSignWarn', text = '!' })
-- sign({name = 'DiagnosticSignHint', text = ''})
-- sign({name = 'DiagnosticSignInfo', text = ''})
sign({ name = 'DiagnosticSignError', text = '✗' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignInformation', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        focusable = false,
        source = 'always',
        header = '',
        prefix = '',
    },
})
