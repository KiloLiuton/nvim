-- move over next closing element in insert mode
local escapePair = function()
  local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

--Remap space as leader key
map({ "n", "v" }, "<Space>", "<Nop>")
vim.g.mapleader = " "

--Remap for dealing with visual line wraps
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Tab switch buffer
map("n", "<tab>", ":bnext<CR>")
map("n", "<S-tab>", ":bprev<CR>")

-- Cancel search highlighting with ESC
map("n", "<esc>", ":nohlsearch<Bar>:echo<CR>")

-- Move selected line / block of text in visual mode
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return escapePair()
end)

-- Resize buffers (only works if terminal passes the commands!)
map("n", "<C-S-H>", "<CMD>vertical resize -5<CR>")
map("n", "<C-S-J>", "<CMD>resize -5<CR>")
map("n", "<C-S-K>", "<CMD>resize +5<CR>")
map("n", "<C-S-L>", "<CMD>vertical resize +5<CR>")

-- Movement
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- ToggleTerm
map("n", "<C-t>", "<CMD>ToggleTerm<CR>")
map("t", "<C-t>", "<CMD>ToggleTerm<CR>")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

local wk = require("which-key")
local options = { noremap = true, silent = true }
wk.register({
  -- Quicker save & quit
  w = { "<CMD>w<CR>", "Save" },
  q = { "<CMD>q<CR>", "Quit" },
  b = {
    name = "Buffers",
    b = {
      "<cmd>Telescope buffers<cr>",
      "Find buffer",
    },
    D = {
      "<cmd>%bd|e#|bd#<cr>",
      "Close all but the current buffer",
    },
    d = { "<cmd>bdelete<cr>", "Close buffer" },
  },
  f = {
    name = "Files",
    f = { "<CMD>Telescope find_files<CR>", "Find files" },
    b = { "<CMD>Telescope buffers<CR>", "List buffers" },
    r = { "<CMD>Telescope oldfiles<CR>", "Old files" },
    n = { "<cmd>Neotree reveal toggle<cr>", "Toggle Filetree" },
    w = { "<CMD>Telescope live_grep<CR>", "Live grep" },
    t = { "<CMD>Telescope colorscheme<CR>", "Select colorscheme" },
  },
  m = {
    name = "Misc",
    d = { require("config.lsp.utils").toggle_diagnostics(), "Toggle Diagnostics" },
    o = { "Options" },
    p = { "<cmd>PackerSync --preview<cr>", "PackerSync" },
    s = { "<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline" },
  },
  -- Hydra heads
  r = { "Resize" },
  d = { "DAP" },
  s = { "Telescope" },
  g = { "Git" },
  z = { "Spelling" },
}, { prefix = "<leader>", options })

-- Lsp
local function setup_buffer_keymaps(bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { noremap = true, silent = true, buffer = bufnr }
  wk.register({
    l = {
      name = "Language Server",
      D = { vim.lsp.buf.declaration, "Go To Declaration" },
      i = { vim.lsp.buf.implementation, "Show implementations" },
      R = { vim.lsp.buf.rename, "Rename" },
      a = { vim.lsp.buf.code_action, "Code Action" },
      d = { vim.lsp.buf.definition, "Go To Definition" },
      e = { "<CMD>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
      f = {
        function()
          vim.lsp.buf.format({ async = true })
          print("Buffer formatted!")
        end,
        "Format",
      },
      k = { vim.lsp.buf.hover, "Hover Commands" },
      l = { vim.diagnostic.open_float, "Line Diagnostics" },
      n = { vim.diagnostic.goto_next, "Next Diagnostic" },
      p = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      q = { vim.diagnostic.setloclist, "Quickfix Diagnostics" },
      r = { vim.lsp.buf.references, "References" },
      s = { "<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols" },
      t = { vim.lsp.buf.type_definition, "Type Definition" },
      w = {
        name = "Workspaces",
        a = { vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
        d = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspace Folders" },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder" },
        s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
      },
    },
  }, { prefix = "<leader>", mode = "n", opts })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    setup_buffer_keymaps(args.buf)
  end,
})
