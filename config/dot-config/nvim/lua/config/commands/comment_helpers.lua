---@enum comment_type
local comment_type = {
  none = 0,
  act = 1,
  assert = 2,
}

local M = {}

local function test()
  -- Assert 0.6 => asdf
  -- Assert 0.2
  -- Act 1 => asdf
  -- Assert 1.1 => asdf
  -- Act 1 => asdf
end

---@param lang string
---@param node TSNode
---
---@diagnostic disable-next-line
function M.iterateComments(lang, node)
  local query = vim.treesitter.query.parse(lang, [[
     (comment) @comment
  ]])

  return query:iter_captures(node, 0)
end

---@class RecountOpts
---@field act integer first action's count
---@field assert integer first assert's count
---@field testStart string[] TS

---@param opts? RecountOpts
function M.recount_steps(opts)
  opts = vim.tbl_extend('keep', opts, {
    act = 0,
    assert = 1,
    testStart = { "function_declaration", "method_declaration" },
  })

  local current_buffer = vim.api.nvim_get_current_buf()
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)

  if not lang then
    vim.notify(
      ("recount: Could not get TS language for %s"):format("lang"),
      vim.log.levels.ERROR
    )
    return
  end

  local node = vim.treesitter.get_node()
  while node and not vim.list_contains(opts.testStart, node:type()) do
    node = node:parent()
  end

  if not node then
    vim.notify(
      "recount: Could not get node representing beginning of the test",
      vim.log.levels.ERROR
    )
    return
  end

  local act = opts.act - 1
  local assert = opts.assert - 1
  local actions = 0

  for _, c, _ in M.iterateComments(lang, node) do
    -- create regex that will capture whole comment's content
    local comment_format = vim.bo.commentstring:gsub("%s", ""):format("%s*(.*)")
    local line = vim.treesitter.get_node_text(c, current_buffer)
    local text = line:gmatch(comment_format)()

    -- vim.print {
    --   format = comment_format,
    --   line = line,
    --   text = text,
    -- }

    ---@type "Act" | "Assert" | "None"
    local type = "None"
    local fmt = ""
    local explanation = text:gmatch("=>%s*(.*)")()

    if text:find("^Act") then
      type = "Act"
      act = act + 1
      assert = opts.assert - 1

      fmt = ("Act %d"):format(act)
    elseif text:find("^Assert") then
      type = "Assert"
      assert = assert + 1

      fmt = ("Assert %d.%d"):format(act, assert)
    end

    if type ~= "None" then
      local ans = text:gsub(("(%s.*)=?"):format(type), fmt)
      if explanation then
        ans = ("%s => %s"):format(ans, explanation)
      end
      ans = vim.bo.commentstring:format(ans)

      local start_row, start_col = c:start()
      local end_row, end_col = c:end_()

      vim.api.nvim_buf_set_text(current_buffer, start_row, start_col, end_row, end_col, { ans })
      actions = actions + 1
    end
  end
  if actions > 0 then
    vim.notify(
      "recount: recounted test steps",
      vim.log.levels.INFO
    )
  end
end

---@param command_opts? RecountOpts
function M.registerRecount(command_opts)
  command_opts = command_opts or {}
  vim.api.nvim_create_user_command("Recount", function(opts)
    M.recount_steps(vim.tbl_extend('keep', opts, command_opts))
  end, {})
end

return M
