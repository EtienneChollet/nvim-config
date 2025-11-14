return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- State to track current sort mode and column visibility
    local sort_by_mtime = false
    local show_columns = false  -- Start with columns hidden

    -- Initial setup with minimal columns (just icon)
    require('oil').setup({
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
    })

    -- Helper function to get current column config
    local function get_columns()
      if show_columns then
        return { "icon", "mtime" }
      else
        return { "icon" }
      end
    end

    -- Function to toggle between mtime and alphabetical sorting
    local function toggle_sort()
      sort_by_mtime = not sort_by_mtime

      if sort_by_mtime then
        require('oil').setup({
          columns = get_columns(),
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
          columns = get_columns(),
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

    -- Function to toggle column visibility
    local function toggle_columns()
      show_columns = not show_columns

      local sort_config = sort_by_mtime
        and { { "type", "asc" }, { "mtime", "desc" } }
        or { { "type", "asc" }, { "name", "asc" } }

      require('oil').setup({
        columns = get_columns(),
        view_options = {
          show_hidden = true,
          sort = sort_config,
        },
      })

      local status = show_columns and "shown" or "hidden"
      vim.notify("Oil: Columns " .. status, vim.log.levels.INFO)

      -- Refresh oil buffer if it's currently open
      if vim.bo.filetype == 'oil' then
        vim.cmd('edit')
      end
    end

    -- Keybindings
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>os", toggle_sort, { desc = "[O]il: toggle [S]ort order" })
    vim.keymap.set("n", "<leader>oi", toggle_columns, { desc = "[O]il: toggle [I]nfo" })
  end,
}
