local Hydra = require('hydra')

local hint = [[
 _f_: files          _p_: projects
 _t_: live grep      _s_: grep string
 _H_: header         _S_: symbols
 _R_: register       _P_: plugins
 _h_: vim help       _c_: execute command
 _k_: keymaps        _;_: commands history
 _O_: options        _?_: search history
 _/_: search in file _m_: make
 _r_: recently opened files

 ^
 _<Enter>_: Telescope   _q_ ^^ _<Esc>_: Exit
]]

Hydra({
  name = 'Telescope',
  hint = hint,
  config = {
    invoke_on_body = true,
    hint = {
      position = 'middle',
      border = 'rounded',
    },
  },
  mode = 'n',
  body = '<Leader>s',
  heads = {
    { 'c', '<CMD>Telescope commands<CR>', { desc = 'execute command' } },
    { 'f', '<CMD>Telescope find_files<CR>' },
    { 't', '<CMD>Telescope live_grep<CR>' },
    { 'h', '<CMD>Telescope help_tags<CR>', { desc = 'vim help' } },
    { 'H', '<CMD>Telescope heading<CR>' },
    { 'k', '<CMD>Telescope keymaps<CR>' },
    { 'O', '<CMD>Telescope vim_options<CR>' },
    { 'm', '<CMD>Telescope make<CR>' },
    { 'p', '<CMD>Telescope projects<CR>', { desc = 'projects' } },
    { 'P', '<CMD>Telescope packer<CR>' },
    { 'r', '<CMD>Telescope oldfiles<CR>', { desc = 'recently opened files' } },
    { 'R', '<CMD>Telescope registers<CR>' },
    { 's', '<CMD>Telescope grep_string<CR>', { desc = 'Text under cursor' } },
    { 'S', '<CMD>Telescope symbols<CR>' },
    { '/', '<CMD>Telescope current_buffer_fuzzy_find<CR>', { desc = 'search in file' } },
    { '?', '<CMD>Telescope search_history', { desc = 'search history' } },
    { ';', '<CMD>Telescope command_history', { desc = 'command-line history' } },
    { '<Enter>', '<CMD>Telescope<CR>', { exit = true, desc = 'list all pickers' } },
    { 'q', nil, { exit = true, nowait = true } },
    { '<Esc>', nil, { exit = true, nowait = true } },
  },
})
