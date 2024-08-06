local function add_to_pythonpath(path)
    local current_pythonpath = vim.fn.getenv 'PYTHONPATH'

    if current_pythonpath ~= vim.NIL and current_pythonpath ~= '' then
        current_pythonpath = current_pythonpath .. ':' .. path
    else
        current_pythonpath = path
    end

    vim.fn.setenv('PYTHONPATH', current_pythonpath)
end

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree reveal' },
    },
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ['<C-p>'] = function(state)
                        local path = state.tree:get_node().path
                        print('Added to Python Path: ' .. path)
                        add_to_pythonpath(path)
                    end,
                },
            },
        },
    },
}
