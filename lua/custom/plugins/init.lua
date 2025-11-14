-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        ui = {
          border = 'rounded',
        },
        hover = {
          max_width = 0.6,
          max_height = 0.8,
          open_link = 'gx',
        },
        diagnostic = {
          on_insert = false,
          on_insert_follow = false,
        },
        lightbulb = {
          enable = false,
        },
      }
      -- Better hover keybinding
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'Lspsaga hover documentation' })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1001,  -- Higher than tokyonight to load last
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe', -- latte, frappe, macchiato, mocha
        transparent_background = false,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
        },
      }
      -- Activate catppuccin
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      -- Git keymaps
      vim.keymap.set('n', '<leader>gs', '<cmd>Git<CR>', { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gd', '<cmd>Gdiffsplit<CR>', { desc = '[G]it [D]iff split' })
      vim.keymap.set('n', '<leader>gD', '<cmd>Gvdiffsplit! HEAD<CR>', { desc = '[G]it [D]iff vs HEAD' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = '[G]it [C]ommit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = '[G]it [P]ush' })
      vim.keymap.set('n', '<leader>gl', '<cmd>Git pull<CR>', { desc = '[G]it Pu[l]l' })
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = '[G]it [B]lame' })
      vim.keymap.set('n', '<leader>gL', '<cmd>Git log<CR>', { desc = '[G]it [L]og' })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      -- Add current file to harpoon
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon [A]dd file' })

      -- Toggle harpoon quick menu
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon menu' })

      -- Jump to marked files
      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon file 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon file 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon file 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon file 4' })

      -- Cycle through marked files
      vim.keymap.set('n', '<C-n>', function()
        harpoon:list():next()
      end, { desc = 'Harpoon next' })
      vim.keymap.set('n', '<C-p>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon prev' })
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        startInInsertMode = true,
      })

      -- Keymaps for grug-far
      vim.keymap.set('n', '<leader>S', '<cmd>GrugFar<CR>', {
        desc = 'Find and [S]ubstitute (grug-far)'
      })
      vim.keymap.set('n', '<leader>sw', function()
        require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } })
      end, {
        desc = '[S]ubstitute current [w]ord'
      })
      vim.keymap.set('v', '<leader>sw', function()
        require('grug-far').with_visual_selection({ prefills = { search = vim.fn.expand('<cword>') } })
      end, {
        desc = '[S]ubstitute selection'
      })
      vim.keymap.set('n', '<leader>sp', function()
        require('grug-far').grug_far({ prefills = { paths = vim.fn.expand('%') } })
      end, {
        desc = '[S]ubstitute in current file'
      })
    end,
  },
}

-- return {}
