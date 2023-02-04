-- source this file and run :PackerSync to install/update plugins

vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
  function(use)
    use({ "wbthomason/packer.nvim", opt = true })

    -- colorschemes
    use({ "dracula/vim", as = "dracula" })

    -- language tools
    use({
      {
        "nvim-treesitter/nvim-treesitter",
        config = function()
          require("stnley.treesitter")
        end,
        run = ":TSUpdate",
      },

      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require("treesitter-context").setup({})
        end,
        after = "nvim-treesitter",
      },
      {
        "nvim-treesitter/playground",
        cmd = { "TSPlaygroundToggle", "TSNodeUnderCursor", "TSCaptureUnderCursor", "TSHighlightCapturesUnderCursor" },
      },
    })

    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("stnley.lsp")
      end,
      event = "BufReadPre",
      requires = {
        {
          "simrat39/inlay-hints.nvim",
          module = "inlay-hints",
          config = function()
            require("stnley.lsp.inlay")
          end,
        },
        {
          "simrat39/symbols-outline.nvim",
          module = "symbols-outline",
          config = function()
            require("symbols-outline").setup({})
          end,
        },
        {
          "folke/trouble.nvim",
          requires = "kyazdani42/nvim-web-devicons",
          module = "trouble",
          config = function()
            require("trouble").setup({})
          end,
        },
      },
    })

    use({ "mfussenegger/nvim-jdtls", module = "jdtls" })

    -- completion
    use({
      "hrsh7th/nvim-cmp",
      transitive_opt = true,
      opt = true,
      requires = {
        { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol" },
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        {
          "saadparwaiz1/cmp_luasnip",
          requires = {
            "L3MON4D3/LuaSnip",
            module = "luasnip",
          },
        },
      },
      event = "InsertEnter",
      config = function()
        require("stnley.cmp")
      end,
    })

    -- debuggers
    use({
      "mfussenegger/nvim-dap",
      module = "dap",
      config = function()
        require("stnley.dap")
      end,
      requires = {
        {
          "rcarriga/nvim-dap-ui",
          module = "dapui",
          config = function()
            require("dapui").setup({})
          end,
        },
        { "leoluz/nvim-dap-go", module = "dap-go" },
        { "mfussenegger/nvim-dap-python", module = "dap-python" },
      },
    })

    -- navigation
    use({
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "kyazdani42/nvim-web-devicons", opt = true },
        { "nvim-telescope/telescope-file-browser.nvim", after = "telescope.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make", after = "telescope.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim", after = "telescope.nvim" },
      },
      config = function()
        require("stnley.telescope")
      end,
    })

    use({
      "phaazon/hop.nvim",
      branch = "v2",
      config = function()
        require("hop").setup({
          quit_key = "<Space>",
          jump_on_sole_occurrence = false,
        })
      end,
      module = "hop",
    })

    -- text manipulation
    use({ "tpope/vim-commentary", event = "BufRead" })

    use({
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup({})
      end,
      event = "InsertEnter",
    })

    -- git
    use({ "tpope/vim-fugitive", cmd = { "Git", "G" } })

    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("gitsigns").setup({})
      end,
      event = "BufRead",
    })

    -- visual aids
    use({
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup({})
      end,
      module = "zen-mode",
    })

    use({
      "hoob3rt/lualine.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("lualine").setup({
          options = { theme = "dracula", globalstatus = true },
        })
      end,
    })

    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("stnley.todo-comments")
      end,
      event = "BufRead",
    })

    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        local c = require("colorizer")
        c.setup({})
        c.attach_to_buffer(0)
      end,
      event = "BufRead",
    })

    -- external features
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("stnley.toggleterm")
      end,
      cmd = "ToggleTerm",
    })

    -- dependencies (not used directly)
    use({
      "nvim-lua/plenary.nvim",
      module = "plenary",
      module_pattern = "plenary.*",
    })

    use({
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
    })
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
