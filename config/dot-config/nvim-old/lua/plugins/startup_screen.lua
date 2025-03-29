return {
    {
        'startup-nvim/startup.nvim',
        opts = { theme = 'dashboard' },
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/plenary.nvim" }
        },
    }
}
