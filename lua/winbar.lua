local icons = require("config.ui.icons")
local navic = require("nvim-navic")

M = {}

local winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
}

local excludes = function()
  if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype)
  then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

local get_buf_option = function(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

local function get_modified()
  if get_buf_option("mod") then
    local mod = icons.git.Mod
    return "%#WinBarFilename#" .. mod .. " " .. "%t" .. "%*"
  end
  return "%#WinBarFilename#" .. "%t" .. "%*"
end

local function get_location()
  local location = navic.get_location()
  if navic.is_available() then
    return "%#WinBarContext#" .. " " .. location .. "%*"
  end
  return ""
end

function M.get_winbar()
  if excludes() then
    return ""
  end
  if navic.is_available() then
    return "%#WinBarSeparator#"
    -- return "%="
        .. icons.ui.Gears
        .. icons.arrows.ArrowLeft
        .. "%*"
        .. get_location()
        .. "%#WinBarSeparator# "
        .. icons.arrows.ArrowRight
        .. "%*"
  else
    return "%#WinBarSeparator#"
        .. "%="
        .. icons.arrows.ArrowLeft
        .. "%*"
        .. get_modified()
        .. "%#WinBarSeparator# "
        .. icons.arrows.ArrowRight
        .. "%*"
  end
end

return M
