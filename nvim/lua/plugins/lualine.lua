return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,

          component_separators = "",
          section_separators = { left = "", right = "" },
        },

        sections = {
          -- LEFT SIDE
          lualine_a = {
            {
              "filename",
              path = 1, -- relative path
            },
          },

          lualine_b = {},
          lualine_c = {},

          -- RIGHT SIDE
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
            },

            {
              "branch",
              icon = "",
            },
          },

          lualine_y = {
            {
              "filetype",
              icon_only = false,
            },

            {
              "mode",
              fmt = function(str)
                return str:sub(1, 3)
              end,
            },
          },

          lualine_z = {
            {
              "location",
            },
          },
        },

        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
      })
    end,
  },
}
