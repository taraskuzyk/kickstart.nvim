return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/neotest-python',
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'mfussenegger/nvim-dap-python',
        },
        opts = {
            adapters = {
                ['neotest-python'] = {
                    dap = { justMyCode = false },
                    args = { '--log-level', 'DEBUG' },
                    runner = 'pytest',
                },
            },
        },

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
