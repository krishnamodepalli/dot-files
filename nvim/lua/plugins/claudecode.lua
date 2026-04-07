return {
  {
    -- Minimal snacks.nvim — only here as terminal provider for claudecode
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      terminal = { enabled = true },
    },
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      auto_start = true,
      track_selection = true,
      terminal = {
        provider = "snacks",
        split_side = "right",
        split_width_percentage = 0.35,
        auto_close = true,
      },
      diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      desc = "Focus Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Add buffer to context" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       mode = "v", desc = "Send selection" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  },
}
