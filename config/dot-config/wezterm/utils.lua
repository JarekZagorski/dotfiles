local M = {}

--- merges tables into one, overwriting old values
---@param config table
---@param local_config table
function M.merge_tables(config, local_config)
    for k, v in pairs(local_config) do
        config[k] = v
    end
end

---@return "Windows" | "Unix"
function M.get_os()
    return package.config:sub(1,1) == "\\" and "Windows" or "Unix"
end

return M
