-- Highlight the region on yank
-- Highlight on yank
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank({ timeout = 300 }) end,
    group = 'YankHighlight',
})

-- Open diagnostics when hovering LSP info
vim.api.nvim_create_augroup('Diagnostic', { clear = true })
vim.api.nvim_create_autocmd(
    { 'CursorHold' },
    {
        group = 'Diagnostic',
        callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end
    }
)

-- Return to last edit position when opening files
vim.api.nvim_create_augroup('ReturnCursor', { clear = true })
vim.api.nvim_create_autocmd(
    { 'BufReadPost' },
    {
        group = 'ReturnCursor',
        command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
    }
)

-- windows to close with 'q'
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'startuptime', 'qf', 'fugitive', 'null-ls-info', 'dap-float' },
    command = [[nnoremap <buffer><silent> q :close<CR>]],
})
vim.api.nvim_create_autocmd('FileType', { pattern = 'man', command = [[nnoremap <buffer><silent> q :quit<CR>]] })
