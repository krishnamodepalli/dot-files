return {
    {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonUninstall', 'MasonLog' },
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    }
                }
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        dependencies = { 'williamboman/mason.nvim' },
    },
}
