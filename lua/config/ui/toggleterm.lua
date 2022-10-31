require('toggleterm').setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
        end
    end,
    direction = 'vertical',
    open_mapping = nil,
    insert_mappings = false,
    float_opts = {
        border = 'single',
    }
})
