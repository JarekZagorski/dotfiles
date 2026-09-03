---------------------
--- Basic options ---
---------------------

vim.opt.number = true
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 12

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

---------------
--- Plugins ---
---------------

vim.pack.add {
  "https://github.com/tpope/vim-fugitive",
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
}

local fzfLua = require("fzf-lua")
fzfLua.setup({
  -- "borderless-full",
  "border-fused",
})

-----------
--- LSP ---
-----------

-- for configuration common in all files
vim.lsp.config("*", {})

vim.lsp.enable({"lua_ls"})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },

  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = false,
    })
  end,

  settings = {
    Lua = {
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        }
      },
    },
  },
})

------------------
--- Completion ---
------------------

-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.cmd[[set completeopt+=menuone,popup,preview,fuzzy]]

-- limits max number of candidates for completion
vim.opt.pumheight = 12

------------
--- Keys ---
------------

vim.keymap.set("i", "<TAB>", function ()
  if vim.fn.pumvisible() == 0 then
    vim.lsp.omnifunc(1, 1)
  else
  end
end)

local function cmd(command)
  return function ()
    vim.cmd(command)
  end
end

vim.keymap.set("n", "gl", vim.diagnostic.open_float)

vim.keymap.set("n", "<leader>gg", cmd"Git")
