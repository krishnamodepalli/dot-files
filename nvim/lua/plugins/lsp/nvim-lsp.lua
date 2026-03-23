return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        -- Setup mason-lspconfig to auto-install servers
        require('mason-lspconfig').setup({
            ensure_installed = {
                'ts_ls',  -- TypeScript/JavaScript
                'lua_ls', -- Lua
                'cssls',  -- CSS/SCSS/LESS
                'somesass_ls', -- SCSS specific language server (good for cross-file variable completion)
                'css_variables', -- Optionally helpful for CSS variables across files
                'basedpyright', -- Python language server
            },
            automatic_installation = true,
        })

        -- Provide capabilities to all servers so that completion features (like snippet support)
        -- are acknowledged by servers like cssls. This must run early.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
        if has_cmp then
            capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
        else
            capabilities.textDocument.completion.completionItem.snippetSupport = true
        end

        vim.lsp.config('*', {
            capabilities = capabilities,
        })

        -- Note: Servers are configured and enabled in lua/lsp.lua

        -- Setup LSP keymaps on attach
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local opts = { buffer = args.buf, noremap = true, silent = true }
                -- LSP navigation
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                
                -- LSP actions
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format({ async = true })
                end, opts)

                -- Diagnostics
                vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<M-{>', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', '<M-}>', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
            end,
        })
    end,
}
