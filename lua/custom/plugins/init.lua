-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
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
      vim.keymap.set('n', '<leader>gD', '<cmd>Gdiffsplit HEAD<CR>', { desc = '[G]it [D]iff vs HEAD' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = '[G]it [C]ommit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = '[G]it [P]ush' })
      vim.keymap.set('n', '<leader>gl', '<cmd>Git pull<CR>', { desc = '[G]it Pu[l]l' })
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = '[G]it [B]lame' })
      vim.keymap.set('n', '<leader>gL', '<cmd>Git log<CR>', { desc = '[G]it [L]og' })
    end,
  },
}

-- return {}
