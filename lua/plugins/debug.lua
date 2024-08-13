-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'leoluz/nvim-dap-go',
        'mfussenegger/nvim-dap-python',
    },
    keys = function(_, keys)
        local dap = require 'dap'
        local dapui = require 'dapui'
        return {
            -- Basic debugging keymaps, feel free to change to your liking!
            { '<A-C>', dap.continue, desc = 'Debug: Start/Continue' },
            { '<A-J>', dap.step_into, desc = 'Debug: Step Into' },
            { '<A-O>', dap.step_over, desc = 'Debug: Step Over' },
            { '<A-K>', dap.step_out, desc = 'Debug: Step Out' },
            { '<A-S>', dap.close, desc = 'Debug: Stop' },
            { '<A-b>', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
            {
                '<A-B>',
                function()
                    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
                end,
                desc = 'Debug: Set Breakpoint',
            },
            { '<A-R>', dap.repl.toggle(), desc = 'Debug: REPL toggle' },
            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
            unpack(keys),
        }
    end,
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            automatic_installation = true,
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'delve',
                'debugpy',
            },
        }

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        require('dap-go').setup {
            delve = {
                -- On Windows delve must be run attached or it crashes.
                -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
                detached = vim.fn.has 'win32' == 0,
            },
        }
    end,
}
