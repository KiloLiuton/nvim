
-- " Exit Vim if NERDTree is the only window remaining in the only tab.
-- autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

vim.api.nvim_create_augroup('NERDTree', { clear = true })
vim.api.nvim_create_autocmd(
    { 'BufEnter' },
    {
        group = 'NERDTree',
        command = [[if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
    }
)
