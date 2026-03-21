return {
  -- Sticky context (VS Code sticky scroll)
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup({
        max_lines = 3,        -- class + function + misc
        trim_scope = "outer",
        mode = "cursor",
      })
    end,
  },
}
