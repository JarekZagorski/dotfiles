local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local actions_state = require 'telescope.actions.state'
local utils = require 'telescope.utils'
local make_entry = require "telescope.make_entry"
local previewers = require "telescope.previewers"

local M = {}


---@diagnostic disable-next-line
local function git_fixup(prompt_bufnr)
  local cwd = actions_state.get_current_picker(prompt_bufnr).cwd
  local selection = actions_state.get_selected_entry()
  if selection == nil then
    utils.__warn_no_selection "actions.git_fixup"
    return
  end
  actions.close(prompt_bufnr)
  local stdout, ret, stderr = utils.get_os_command_output({ "git", "commit", "--fixup", selection.value }, cwd)
  if ret == 0 then
    vim.notify(table.concat(stdout, "\n"), vim.log.levels.INFO)
    vim.cmd "checktime"
  else
    if #stderr == 0 then
      utils.notify("actions.git_fixup", {
        msg = string.format(
          "Cannot create fixup on %s.\nMost likely there are no staged items",
          selection.value
        ),
        level = "ERROR"
      })
    else
      utils.notify("actions.git_fixup", {
        msg = string.format("Error creating fixup commit on %s. Git: %s",
          selection.value,
          table.concat(stderr, " ")
        ),
        level = "ERROR"
      })
    end
  end
end

---@diagnostic disable-next-line
function M.fixup_picker(opts)
  opts = opts or {}
  opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_git_commits(opts))
  opts.git_command = vim.F.if_nil(
    opts.git_command,
    utils.__git_command({ "log", "--pretty=oneline", "--no-merges", "--abbrev-commit", "--", "." }, opts)
  )

  pickers.new(opts, {
    prompt_title = "Git fixup",
    finder = finders.new_oneshot_job(opts.git_command, opts),
    sorter = conf.generic_sorter(opts),
    previewer = {
      previewers.git_commit_diff_to_parent.new(opts),
      previewers.git_commit_diff_to_head.new(opts),
      previewers.git_commit_diff_as_was.new(opts),
      previewers.git_commit_message.new(opts),
    },
    attach_mappings = function(_, _)
      actions.select_default:replace(git_fixup)
      return true
    end,
  }):find()
end

return M
