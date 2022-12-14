require("project_nvim").setup({
    patterns = {
        ".git",
        "package.json",
        "requirements.yml",
        "pyrightconfig.json",
        "pyproject.toml",
    },
    -- detection_methods = { "lsp", "pattern" },
    detection_methods = { "pattern" },
})
