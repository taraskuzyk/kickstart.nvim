return {
    {
        'mfussenegger/nvim-dap-python',
        config = function()
            local dap = require 'dap'
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch file',
                    pythonPath = 'python',
                },
            }
        end,
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'mfussenegger/nvim-dap-python',
            'nvim-neotest/neotest-python',
        },
        config = function()
            require('neotest').setup {
                adapters = {
                    require 'neotest-python' {
                        dap = { justMyCode = false, console = 'integratedTerminal' },
                        args = { '--log-level', 'DEBUG' },
                        runner = 'pytest',
                    },
                },
            }
        end,

        keys = function()
            local neotest = require 'neotest'
            return {
                {
                    '<leader>tc',
                    function()
                        neotest.run.run()
                    end,
                    desc = 'Test Closest',
                },
                {
                    '<leader>tC',
                    function()
                        neotest.run.run { strategy = 'dap' }
                    end,
                    desc = 'Test Closest Debug',
                },
                {
                    '<leader>tf',
                    function()
                        neotest.run.run { vim.fn.expand '%' }
                    end,
                    desc = 'Test File',
                },
                {
                    '<leader>tF',
                    function()
                        neotest.run.run { vim.fn.expand '%', strategy = 'dap' }
                    end,
                    desc = 'Test File Debug',
                },
                {
                    '<leader>tS',
                    function()
                        neotest.run.stop()
                    end,
                    desc = 'Test Stop',
                },
                {
                    '<leader>ts',
                    function()
                        neotest.summary.toggle()
                    end,
                    desc = 'Test Toggle Summary',
                },
                {
                    '<leader>ta',
                    function()
                        neotest.run.run(vim.fn.getcwd())
                    end,
                    desc = 'Test Run All',
                },
            }
        end,
    },
}
