require('neo-tree').setup({
    sources = {
        'filesystem',
        'buffers',
        'git_status',
    },

    close_if_last_window = true,

    filesystem = {
        use_libuv_file_watcher = true,
        group_empty_dirs = false,
        search_limit = 50, -- max number of search results when using filters
        follow_current_file = false,
    },

    buffers = {
        bind_to_cwd = true,
        follow_current_file = true, -- Focus active buffer file on change
        group_empty_dirs = true,
        window = {
            mappings = {
                ['<bs>'] = 'navigate_up',
                ['bd'] = 'buffer_delete',
            },
        },
    },

    git_status = {
        window = {
            mappings = {
                ["A"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            },
        },
        symbols = {
            -- Change type
            added = '✚', -- NOTE: you can set any of these to an empty string to not show them
            deleted = '✖',
            modified = '',
            renamed = '',
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
        },
        align = 'right',
    },

    source_selector = {
        winbar = true, -- toggle to show selector on winbar
    },

    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
        position = 'left',
        width = 40,
        -- See `:h neo-tree-mappings` for a list of built-in commands.
        -- Can provicde lua function instead of a string.
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            -- set `nowait = false` to use key original binding
            ['o'] = { 'open', nowait = true },
            ['d'] = 'none',
            ['dd'] = 'delete',
            ['<2-LeftMouse>'] = 'open_with_window_picker',
            -- ['<2-LeftMouse>'] = 'open',
        },
    },
})
