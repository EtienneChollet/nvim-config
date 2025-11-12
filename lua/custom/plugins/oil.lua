return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- State to track current sort mode
    local sort_by_mtime = false

    -- Initial setup with alphabetical sorting
    require('oil').setup({
      view_options = {
        show_hidden = true,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
    })

    -- Function to toggle between mtime and alphabetical sorting
    local function toggle_sort()
      sort_by_mtime = not sort_by_mtime

      if sort_by_mtime then
        require('oil').setup({
          view_options = {
            show_hidden = true,
            sort = {
              { "type", "asc" },
              { "mtime", "desc" },  -- Most recently modified first
            },
          },
        })
        vim.notify("Oil: Sorting by modification time (newest first)", vim.log.levels.INFO)
      else
        require('oil').setup({
          view_options = {
            show_hidden = true,
            sort = {
              { "type", "asc" },
              { "name", "asc" },  -- Alphabetical order
            },
          },
        })
        vim.notify("Oil: Sorting alphabetically", vim.log.levels.INFO)
      end

      -- Refresh oil buffer if it's currently open
      if vim.bo.filetype == 'oil' then
        vim.cmd('edit')
      end
    end

    -- Keybindings
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>os", toggle_sort, { desc = "[O]il: toggle [S]ort order" })
  end,
}
