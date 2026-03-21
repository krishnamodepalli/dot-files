return {
  -- Code outline / symbol tree
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        backends = { "treesitter", "lsp" },
        layout = {
          min_width = 30,
        },
        show_guides = true,
      })

      -- Keymaps (defined here)
      vim.keymap.set("n", "<M-7>", "<cmd>AerialToggle<CR>", {
        desc = "Outline (Aerial)",
      })

      vim.keymap.set("n", "<M-,>", "<cmd>AerialPrev<CR>", {
        desc = "Previous symbol",
      })

      vim.keymap.set("n", "<M-.>", "<cmd>AerialNext<CR>", {
        desc = "Next symbol",
      })
    end,
  },
}
