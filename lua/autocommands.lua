local api = vim.api

-- Highlight the region on yank
-- Highlight on yank
api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- Open diagnostics when hovering LSP info
api.nvim_create_augroup("Diagnostic", { clear = true })
api.nvim_create_autocmd("CursorHold", {
  group = "Diagnostic",
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Return to last edit position when opening files
api.nvim_create_augroup("ReturnCursor", { clear = true })
api.nvim_create_autocmd({ "BufReadPost" }, {
  group = "ReturnCursor",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

-- Windows to close with 'q'
api.nvim_create_augroup("CloseWithQ", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = "CloseWithQ",
  pattern = { "help", "startuptime", "qf", "fugitive", "null-ls-info", "dap-float" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})
api.nvim_create_autocmd("FileType", {
  group = "CloseWithQ",
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :quit<CR>]],
})

-- Reload Neovim whenever you save plugins.lua
api.nvim_create_augroup("PackerUserConfig", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.stdpath("config") .. "/lua/plugins.lua",
  callback = function()
    vim.cmd("source" .. vim.fn.stdpath("config") .. "/lua/plugins.lua | PackerSync")
  end,
})

-- when there is no buffer left show Alpha dashboard
-- requires "famiu/bufdelete.nvim" and "goolord/alpha-nvim"
local alpha_on_empty = api.nvim_create_augroup("alpha_on_empty", { clear = true })
api.nvim_create_autocmd("User", {
  pattern = "BDeletePost*",
  group = alpha_on_empty,
  callback = function(event)
    local fallback_name = api.nvim_buf_get_name(event.buf)
    local fallback_ft = api.nvim_buf_get_option(event.buf, "filetype")
    local fallback_on_empty = fallback_name == "" and fallback_ft == ""

    if fallback_on_empty then
      -- require("neo-tree").close_all()
      vim.cmd("Alpha")
      vim.cmd(event.buf .. "bwipeout")
    end
  end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  -- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
  {
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
      vim.opt.spell = true
      vim.opt.spelllang = "en_us,pt"
    end,
  }
)
