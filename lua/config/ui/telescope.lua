local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    extensions = {
        fzf = {},
    },
    pickers = {
        find_files = {
            hidden = false,
        },
        buffers = {
            ignore_current_buffer = false,
            sort_lastused = true,
        },
        -- find_command = { "fd", "--hidden", "--type", "file", "--follow", "--strip-cwd-prefix" },
        -- find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil
        scroll_strategy = 'limit',
    },
})
