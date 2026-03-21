return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    local log = io.open(vim.fn.stdpath("cache") .. "/notify.log", "a")
    local orig_notify = vim.notify
    vim.notify = function(msg, level, o)
      if log then
        log:write(os.date("%H:%M:%S") .. " [" .. tostring(level or 0) .. "] " .. tostring(msg) .. "\n")
        log:flush()
      end
      orig_notify(msg, level, o)
    end

    require("noice").setup(opts)
  end,
}
