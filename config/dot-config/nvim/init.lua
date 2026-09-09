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

local fzfLua = require("fzf-lua.init")
fzfLua.setup({
  "border-fused",
})

-----------
--- LSP ---
-----------

-- for configuration common in all files
vim.lsp.config("*", {
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = false,
    })
  end,
})

vim.lsp.enable({
  "lua_ls",
  "gopls",
  "clangd",
})

------------------
--- Completion ---
------------------

-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.cmd [[set completeopt+=menuone,popup,preview,fuzzy,noinsert]]

-- limits max number of candidates for completion
vim.opt.pumheight = 12

------------
--- Keys ---
------------

vim.keymap.set("i", "<TAB>", function()
  local y = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  local c = line:sub(y, y + 1)
  if #c > 0 and not c:match("[%s\n]") then
    if vim.fn.pumvisible() == 0 then
      vim.print(c)
      vim.lsp.omnifunc(1, 1)
    else
      vim.api.nvim_feedkeys(vim.keycode("<C-y>"), "n", true)
    end
  else
    return "<TAB>"
  end
end, { expr = true })
vim.keymap.set("i", "<C-f>", function ()
  vim.lsp.omnifunc(1, 1)
end)

-- git
vim.keymap.set("n", "<leader>gg", vim.cmd.Git)

-- search of various kinds
vim.keymap.set("n", "<leader>ff", fzfLua.files, { desc = "File Finder" })
vim.keymap.set("n", "fg", fzfLua.live_grep, { desc = "File Grep" })

-- diagnostic
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostics" })

-- lsp
vim.keymap.set("n", "gdd", vim.lsp.buf.definition)
vim.keymap.set("n", "gdt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help)
vim.keymap.set("n", "gr", vim.lsp.buf.references)

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
