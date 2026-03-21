return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('neogit').setup({
            kind = "tab",
            integrations = {
                diffview = true,
            },
            disable_commit_confirmation = true,
        })
    end,
}
