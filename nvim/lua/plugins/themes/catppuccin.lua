return {
  'catppuccin/nvim',
  lazy = false,

  config = function()
    local config = {
      flavour = 'auto', -- latte, frappe, macchiato, mocha
      background = {    -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = true,      -- shows the '~' characters after the end of buffers
      term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,              -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15,            -- percentage of the shade to apply to the inactive window
      },
      no_italic = false,              -- Force no italic
      no_bold = false,                -- Force no bold
      no_underline = false,           -- Force no underline
      styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' },      -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    }
    local flavours = { 'latte', 'frappe', 'macchiato', 'mocha' }
    vim.g.cat_flavour = vim.g.cat_flavour or (vim.o.background == 'dark' and flavours[4] or flavours[1])

    local catppuccin = require 'catppuccin'
    catppuccin.setup(config)

    local toggle_transparency = function()
      config.transparent_background = not config.transparent_background
      catppuccin.setup(config)
      catppuccin.load()
    end

    local toggle_theme = function()
      local curr_index = nil
      for i, value in ipairs(flavours) do
        if value == vim.g.cat_flavour then
          curr_index = i
          break
        end
      end
      local next_index = (curr_index % #flavours) + 1
      vim.g.cat_flavour = flavours[next_index]

      config.flavour = flavours[next_index]
      catppuccin.setup(config)
      catppuccin.load()
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency,
      { noremap = true, silent = true, desc = 'Toggle background transparency' })
    vim.keymap.set('n', '<leader>th', toggle_theme, { noremap = true, silent = true, desc = 'Toggle Catppuccin flovour' })

    -- setup must be called before loading
    vim.cmd.colorscheme 'catppuccin'
  end,
}
