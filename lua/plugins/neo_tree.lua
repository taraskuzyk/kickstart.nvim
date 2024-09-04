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
        always_show = {
            '.docx',
        },
        never_show = {
            '__pycache__',
        },
        never_show_by_pattern = {
            '*pycache*',
            '*pyc',
        },
    },
}
