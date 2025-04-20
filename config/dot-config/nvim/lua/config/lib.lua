local M = {}

---@param spaces integer default 4
---@param expandTab boolean default true
function M.setTabWidth(spaces, expandTab)
  spaces = spaces or 4
  expandTab = expandTab or true
  vim.opt.softtabstop = spaces
  vim.opt.shiftwidth = spaces
  vim.opt.expandtab = expandTab
end

return M
