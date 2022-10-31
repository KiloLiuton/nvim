local dashboard_ok, dashboard = pcall(require, "dashboard")
if not dashboard_ok then
    error_msg = error_msg:gsub('"', '\\"')
    vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
    return
end

local home = os.getenv("HOME")

dashboard.default_banner = {
	"",
	"",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"",
	" [ TIP: To exit Neovim, just power off your computer. ] ",
	"",
}
-- linux
--db.preview_command = 'ueberzug'
--
--db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
dashboard.preview_file_height = 11
dashboard.preview_file_width = 70
dashboard.custom_center = {
	{
		icon = "  ",
		desc = "Recent sessions                         ",
		shortcut = "SPC s l",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Find recent files                       ",
		action = "Telescope oldfiles",
		shortcut = "SPC f r",
	},
	{
		icon = "  ",
		desc = "Find files                              ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "File browser                            ",
		action = "Telescope file_browser",
		shortcut = "SPC f b",
	},
	{
		icon = "  ",
		desc = "Find word                               ",
		action = "Telescope live_grep",
		shortcut = "SPC f w",
	},
	{
		icon = "  ",
		desc = "Load new theme                          ",
		action = "Telescope colorscheme",
		shortcut = "SPC h t",
	},
}
dashboard.custom_footer = { "", "🎉 If I'm using Neovim, then my Emacs config must be broken!" }
dashboard.session_directory = home .. ".config/nvim/session"
