local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Reload nvim config
map('n', '<leader>r', '<CMD>so %<CR>')

-- Quicker save save&quit
map('n', '<leader>w', '<CMD>w<CR>')
map('n', '<leader>q', '<CMD>q<CR>')

-- Movement
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Resize buffers (only works if terminal sends the commands!)
map('n', '<C-S-H>', '<CMD>vertical resize -5<CR>')
map('n', '<C-S-J>', '<CMD>resize -5<CR>')
map('n', '<C-S-K>', '<CMD>resize +5<CR>')
map('n', '<C-S-L>', '<CMD>vertical resize +5<CR>')

-- Plugins --
-- Telescope
map('n', '<leader>fr', '<CMD>Telescope oldfiles<CR>')
map('n', '<leader><space>', '<CMD>Telescope find_files<CR>')
map('n', '<leader>b', '<CMD>Telescope buffers<CR>')
map('n', '<leader>fw', '<CMD>Telescope live_grep<CR>')
map('n', '<leader>ht', '<CMD>Telescope colorscheme<CR>')

-- NERDTree
map('n', '<C-f>', '<CMD>NERDTreeFind<CR>')
map('n', '<C-n>', '<CMD>NERDTreeToggle<CR>')

-- (Toggle)Term
map('t', '<ESC>', '<C-\\><C-n>')
map('n', '<C-t>', '<CMD>ToggleTerm<CR>')
map('t', '<C-t>', '<CMD>ToggleTerm<CR>')

map('t', '<C-h>', [[<C-\><C-n><C-w>h]])
map('t', '<C-j>', [[<C-\><C-n><C-w>j]])
map('t', '<C-k>', [[<C-\><C-n><C-w>k]])
map('t', '<C-l>', [[<C-\><C-n><C-w>l]])

-- Lsp
local function setup_buffer_keymaps(bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
        print('Buffer formated!')
    end, opts)
    vim.keymap.set('v', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
        print('Visual Buffer formated!')
    end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        setup_buffer_keymaps(bufnr)
    end,
})
