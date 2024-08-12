return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
        'famiu/bufdelete.nvim',
    },
    keys = {
        { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
        { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
        { '<C-x>', '<cmd>Bdelete<cr>' },
    },
    opts = {
        options = {
            mode = 'buffers',
            diagnostics = 'nvim_lsp',
            always_show_bufferline = true,
            offsets = {
                {
                    filetype = 'neo-tree',
                    text = 'Neo-tree',
                    highlight = 'Directory',
                    text_align = 'left',
                },
            },
        },
    },
}
