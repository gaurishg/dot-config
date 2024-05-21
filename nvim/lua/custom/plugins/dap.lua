return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        'nvim-neotest/nvim-nio',
      },
      config = function()
        require('dapui').setup()
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup {
          enabled = true, -- enable this plugin (the default)
          enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true, -- show stop reason when stopped for exceptions
          commented = false, -- prefix virtual text with comment string
          only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
          all_references = false, -- show virtual text on all all references of the variable (not only definitions)
          clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
          --- A callback that determines how a variable is displayed or whether it should be omitted
          --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
          --- @param buf number
          --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
          --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
          --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
          --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
          display_callback = function(variable, buf, stackframe, node, options)
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value
            else
              return variable.name .. ' = ' .. variable.value
            end
          end,
          -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
          virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

          -- experimental features:
          all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
          -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        }
      end,
    },
    'nvim-telescope/telescope-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '-i', 'dap' },
    }

    dap.adapters.bashdb = {
      type = 'executable',
      command = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
      name = 'bashdb',
    }

    vim.keymap.set('n', '<F1>', dap.step_into)
    vim.keymap.set('n', '<F2>', ":lua require'dap'.step_over()<CR>")
    vim.keymap.set('n', '<F3>', dap.step_out)
    vim.keymap.set('n', '<F4>', dap.continue)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.toggle_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end)

    dap.configurations.c = {
      {
        name = 'LaunchGDB',
        type = 'gdb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
    }

    dap.configurations.cpp = dap.configurations.c

    dap.configurations.sh = {
      {
        type = 'bashdb',
        request = 'launch',
        name = 'Launch file',
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
        pathBashdbLib = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
        trace = true,
        file = '${file}',
        program = '${file}',
        cwd = '${workspaceFolder}',
        pathCat = 'cat',
        pathBash = '/bin/bash',
        pathMkfifo = 'mkfifo',
        pathPkill = 'pkill',
        args = {},
        env = {},
        terminalKind = 'integrated',
      },
    }
  end,
}
