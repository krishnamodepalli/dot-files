-- Server-specific configuration (Neovim 0.11+ API)

-- Python (basedpyright) with balanced rules
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',

        -- [ ERRORS ] real bugs, almost never false positives
        reportUndefinedVariable = 'error',
        reportAssertAlwaysTrue = 'error',
        reportInvalidStringEscapeSequence = 'error',

        -- [ WARNINGS ] useful signal, low noise
        reportUnusedImport = 'warning',
        reportUnusedVariable = 'warning',
        reportImplicitOverride = 'warning',
        reportDuplicateImport = 'warning',
        reportUninitializedInstanceVariable = 'warning',

        -- [ SILENCED ] too noisy without full type annotations
        reportUnknownParameterType = 'none',
        reportUnknownArgumentType = 'none',
        reportUnknownVariableType = 'none',
        reportUnknownMemberType = 'none',
        reportMissingTypeArgument = 'none',
        reportMissingParameterType = 'none',
        reportAny = 'none',
      },
    },
  },
})

-- Lua language server with Neovim-specific settings
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  },
})

-- Enable LSP servers
vim.lsp.enable('basedpyright')
vim.lsp.enable('css_variables')
vim.lsp.enable('cssls')
vim.lsp.enable('clangd')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('intelephense')
vim.lsp.enable('lua_ls')
vim.lsp.enable('somesass_ls')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('ts_ls')
