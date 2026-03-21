return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local api = require("nvim-tree.api")

    require("nvim-tree").setup({
      view = {
        width = 50,
        side = "right",
      },

      filters = {
        dotfiles = false,
      },

      update_focused_file = {
        enable = true,
        update_root = false,
      },

      on_attach = function(bufnr)
        -- Keep default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Collapse all (Alt + -) ONLY inside nvim-tree
        vim.keymap.set("n", "<M-->", api.tree.collapse_all, {
          buffer = bufnr,
          silent = true,
          desc = "Collapse all folders",
        })
      end,
    })

    --------------------------------------------------------------------
    -- Smart Toggle Function
    -- If closed → open
    -- If open & focused → close
    -- If open & not focused → focus
    --------------------------------------------------------------------
    local function toggle_nvimtree_focus()
      local view = require("nvim-tree.view")

      if not view.is_visible() then
        api.tree.open()
        return
      end

      if vim.bo.filetype == "NvimTree" then
        api.tree.close()
      else
        api.tree.focus()
      end
    end

    --------------------------------------------------------------------
    -- Global Keymaps
    --------------------------------------------------------------------

    -- Alt + 1 → Smart Toggle Explorer
    vim.keymap.set("n", "<M-1>", toggle_nvimtree_focus, {
      silent = true,
      desc = "Toggle File Explorer",
    })

    -- Leader + ef → Explorer Find (Reveal current file)
    vim.keymap.set("n", "<leader>ef", function()
      api.tree.find_file({ open = true, focus = true })
    end, {
      silent = true,
      desc = "Explorer Find File",
    })

    -- Leader + ec → Explorer Collapse All
    vim.keymap.set("n", "<leader>ec", api.tree.collapse_all, {
      silent = true,
      desc = "Explorer Collapse All",
    })
  end,
}
