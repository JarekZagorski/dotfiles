local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    ---@diagnostic disable: missing-fields
    matching = {
        disallow_partial_fuzzy_matching = true
    },

    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            --vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },

    -- ... Your other configuration ...

    mapping = {
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    select = true,
                })
            else
                fallback()
            end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- elseif vim.snippet.active({ direction = 1 }) then
            elseif luasnip.locally_jumpable(1) then
                -- vim.snippet.jump(1)
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                --elseif vim.snippet.active({ direction = -1 }) then
            elseif luasnip.locally_jumpable(-1) then
                -- vim.snippet.jump(-1)
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        -- ... Your other mappings ...
    },

    preselect = 'None',
    -- ... Your other configuration ...
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
        { name = "luasnip_choice" },
        { name = "buffer" },
    })
})
