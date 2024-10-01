local M = {}

---@type string
local plugin_name = "tflint.nvim"
---@type string
local notify_suffix = "[" .. plugin_name .. "] "

--- @class config
--- @field tflint_path string
local default_config = {
    tflint_path = vim.fn.stdpath("data") .. "/mason/bin/tflint",
}

local running_config = vim.tbl_deep_extend("keep", default_config, {})

--- Sets the configuration
---@param opts config
function M.setup(opts)
    running_config = vim.tbl_deep_extend("keep", opts or {}, default_config)
end

--- Returns the running configuration
---@return config
function M.get_config()
    return running_config
end

--- Returns the suffix, which should be added to all notifications
---@return string
function M.get_notify_suffix()
    return notify_suffix
end

--- Returns the plugin name
---@return string
function M.get_plugin_name()
    return plugin_name
end

return M
