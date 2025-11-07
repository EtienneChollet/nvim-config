return {
  'Vigemus/iron.nvim',
  config = function()
    local iron = require 'iron.core'

    iron.setup {
      config = {
        -- Repl definitions
        repl_definition = {
          python = {
            command = { vim.fn.expand('~/.venv/bin/ipython'), '--no-autoindent' },
          },
        },
        -- How the REPL window will be opened
        repl_open_cmd = require('iron.view').right(80),
        -- repl_open_cmd = require('iron.view').bottom(20), -- horizontal split alternative
      },
      keymaps = {
        send_motion = '<leader>jc', -- Send motion (e.g., <leader>jc + ip for paragraph)
        visual_send = '<leader>jc', -- Send visual selection
        send_line = '<leader>jl', -- Send current line
        send_mark = '<leader>jm', -- Send to mark
        cr = '<leader>j<cr>', -- Send line and move to next
        interrupt = '<leader>j<space>', -- Interrupt REPL
        exit = '<leader>jq', -- Exit REPL
        clear = '<leader>jr', -- Clear REPL
      },
      highlight = {
        italic = true,
      },
    }

    -- Function to send current cell (delimited by # %%) to REPL
    local function send_cell()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')

      -- Find start of cell (search backward for # %%)
      local cell_start = 1
      for i = current_line, 1, -1 do
        local line = vim.fn.getline(i)
        if line:match('^%s*#%s*%%%%') then
          cell_start = i + 1
          break
        end
      end

      -- Find end of cell (search forward for # %%)
      local cell_end = total_lines
      for i = current_line + 1, total_lines do
        local line = vim.fn.getline(i)
        if line:match('^%s*#%s*%%%%') then
          cell_end = i - 1
          break
        end
      end

      -- Get cell lines
      local lines = vim.fn.getline(cell_start, cell_end)

      -- Trim leading blank lines
      while #lines > 0 and lines[1]:match('^%s*$') do
        table.remove(lines, 1)
      end

      -- Trim trailing blank lines
      while #lines > 0 and lines[#lines]:match('^%s*$') do
        table.remove(lines, #lines)
      end

      -- Send to REPL if there's content
      if #lines > 0 then
        require('iron.core').send(nil, lines)
      end
    end

    -- Function to jump to next cell
    local function next_cell()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')

      for i = current_line + 1, total_lines do
        local line = vim.fn.getline(i)
        if line:match('^%s*#%s*%%%%') then
          vim.fn.cursor(i, 1)
          return
        end
      end
    end

    -- Function to jump to previous cell
    local function prev_cell()
      local current_line = vim.fn.line('.')

      for i = current_line - 1, 1, -1 do
        local line = vim.fn.getline(i)
        if line:match('^%s*#%s*%%%%') then
          vim.fn.cursor(i, 1)
          return
        end
      end
    end

    -- Helper function to get indentation level
    local function get_indent(line_num)
      local line = vim.fn.getline(line_num)
      local indent = line:match('^%s*')
      return #indent
    end

    -- Function to send current Python function or class to REPL
    local function send_function_or_class()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')

      -- Find the start (def or class line) by searching backward
      local def_line = nil
      local def_indent = nil

      for i = current_line, 1, -1 do
        local line = vim.fn.getline(i)
        -- Match 'def ' or 'class ' at start (after any whitespace)
        if line:match('^%s*def%s') or line:match('^%s*class%s') then
          def_line = i
          def_indent = get_indent(i)
          break
        end
      end

      if not def_line then
        print('No function or class found')
        return
      end

      -- Find the end by looking for the next line with same or less indentation
      local end_line = total_lines

      for i = def_line + 1, total_lines do
        local line = vim.fn.getline(i)
        -- Skip blank lines
        if not line:match('^%s*$') then
          local indent = get_indent(i)
          -- If we hit same or less indentation, we've found the end
          if indent <= def_indent then
            end_line = i - 1
            break
          end
        end
      end

      -- Get the lines
      local lines = vim.fn.getline(def_line, end_line)

      -- Trim trailing blank lines
      while #lines > 0 and lines[#lines]:match('^%s*$') do
        table.remove(lines, #lines)
      end

      -- Send to REPL if there's content
      if #lines > 0 then
        require('iron.core').send(nil, lines)
      end
    end

    -- Additional useful keybindings
    vim.keymap.set('n', '<leader>js', '<cmd>IronRepl<cr>', { desc = 'Start REPL' })
    vim.keymap.set('n', '<leader>jR', '<cmd>IronRestart<cr>', { desc = 'Restart REPL' })
    vim.keymap.set('n', '<leader>jf', '<cmd>IronFocus<cr>', { desc = 'Focus REPL' })
    vim.keymap.set('n', '<leader>jh', '<cmd>IronHide<cr>', { desc = 'Hide REPL' })

    -- Send code blocks
    vim.keymap.set('n', '<leader>jj', send_cell, { desc = 'Send cell to REPL' })
    vim.keymap.set('n', '<leader>jd', send_function_or_class, { desc = 'Send function/class to REPL' })

    -- Cell navigation
    vim.keymap.set('n', ']c', next_cell, { desc = 'Jump to next cell' })
    vim.keymap.set('n', '[c', prev_cell, { desc = 'Jump to previous cell' })
  end,
}
