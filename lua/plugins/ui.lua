return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",
        transparent = true,
      })
      require("onedark").load()
    end,
  },

  {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("dashboard")
    local telescope = require("telescope.builtin")

    dashboard.setup({
      theme = "hyper",
      config = {
        week_header = { enable = true },
        shortcut = {
          {
            desc = "󰊳 Update",
            group = "@property",
            action = "Lazy sync",
            key = "u",
          },
          {
            desc = " Files",
            group = "Label",
            action = function()
              telescope.find_files({ cwd = vim.fn.getcwd() })
            end,
            key = "f",
          },
          {
            desc = " Explorer",
            group = "DiagnosticHint",
            action = "Neotree left toggle reveal",
            key = "e",
          },
        },
      },
    })
  end,
},

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "none",
          diagnostics = "nvim_lsp",
          always_show_bufferline = true,
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true,
          theme = "onedark",
        },
      })
    end,
  },

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>qq", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics" },
      { "<leader>qb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>ql", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP list" },
      { "<leader>qf", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
      { "<leader>qo", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist" },
    },
  },
}