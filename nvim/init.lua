require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'utils.case_convert'


-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = 'onedark'
local env_var_nvim_theme = os.getenv 'NVIM_THEME' or default_color_scheme

-- Define a table of theme modules
local themes = {
  nord = 'plugins.themes.nord',
  onedark = 'plugins.themes.onedark',
  dracula = 'plugins.themes.dracula',
  catppuccin = 'plugins.themes.catppuccin',
}
require('lazy').setup({
  require(themes[env_var_nvim_theme]),
  require 'plugins.aerial',
  require 'plugins.claudecode',
  require 'plugins.codecompanion',
  require 'plugins.gitsigns',
  require 'plugins.lsp.cmp',
  require 'plugins.lsp.mason',
  require 'plugins.lsp.nvim-lsp',
  require 'plugins.lualine',
  require 'plugins.markdown',
  require 'plugins.neogit',
  require 'plugins.noice',
  require 'plugins.nvim-tree',
  require 'plugins.telescope',
  require 'plugins.todo-comments',
  require 'plugins.treesitter',
  require 'plugins.treesitter-context',
  require 'plugins.wakatime',
  require 'plugins.which-key',
}, {})

-- Load LSP server configuration (after plugins are loaded)
require 'lsp'
