return {
  "dracula/vim",
  as = "draucla",
  lazy = false,
  priority = 1000,

  config = function()
    vim.cmd.colorscheme "dracula"
  end
}
