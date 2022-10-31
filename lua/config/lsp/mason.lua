require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        keymaps = {
            install_package = "i",
            update_package = "u",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
        },
    },
})

require("mason-lspconfig").setup()

require("mason-tool-installer").setup({
    ensure_installed = {
        'shfmt',
        'shellcheck',
        'prettier',
        -- LSP
        "lua-language-server",
        "pyright",
        "rust-analyzer",
        "clangd",
        -- Formatter
        "black",
        -- DAP
        "codelldb",
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 0,
})
