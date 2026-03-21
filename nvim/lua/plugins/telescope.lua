return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<M-g>f', '<cmd>Telescope find_files<cr>', desc = 'Telescope find files' },
    { '<M-g>s', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Telescope find document symbols' },
    { '<leader>rg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Telescope buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Telescope help tags' },
    { '<leader>fs', '<cmd>Telescope grep_string<cr>', desc = 'Telescope grep string' },
    { '<M-g>r', '<cmd>Telescope oldfiles<cr>', desc = 'Telescope old files' },
    { '<M-g>g', '<cmd>Telescope git_status<cr>', desc = 'Telescope view changes' },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        -- Default mappings inside telescope can go here if needed
      },
    })
    -- Load fzf extension
    require('telescope').load_extension('fzf')
  end
}
