local M = {}

local plugin_name = "tflint.nvim"
local notify_suffix = "[" .. plugin_name .. "] "

local default_config = {
    use_mason = true,
    mason_path = vim.fn.stdpath("data") .. "/mason/",
    tflint_path = vim.fn.stdpath("data") .. "/mason/bin/tflint",
}

local running_config = vim.tbl_deep_extend("keep", default_config, {})

function M.setup(opts)
    running_config = vim.tbl_deep_extend("keep", opts or {}, default_config)
end

function M.get_config()
    return running_config
end

function M.get_notify_suffix()
    return notify_suffix
end

function M.get_plugin_name()
    return plugin_name
end

return M
