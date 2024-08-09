return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        require('which-key').setup()

        require('which-key').add {
            { '<leader>c', group = '[C]ode' },
            { '<leader>d', group = '[D]ocument' },
            { '<leader>r', group = '[R]ename' },
            { '<leader>s', group = 'Tele[S]cope' },
            { '<leader>w', group = '[W]orkspace' },
            { '<leader>t', group = '[T]est' },
        }
    end,
}
