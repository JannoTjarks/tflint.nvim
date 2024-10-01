local M = {}

local config = require("tflint").get_config()
local notify_suffix = require("tflint").get_notify_suffix()
local errors = require("tflint.errors")

--- Runs the command `tflint` and returns the a vim.SystemCompleted
---@return vim.SystemCompleted
---@nodiscard
local function run_tflint()
    return vim.system({ config.tflint_path }, { text = true }):wait()
end

--- Runs the command `tflint --init` and returns the a vim.SystemCompleted
---@return vim.SystemCompleted
---@nodiscard
local function run_tflint_init()
    return vim.system({ config.tflint_path, "--init" }, { text = true }):wait()
end

--- Checks, if tflint is installed. Thats done by looking up the path
--- specified in the configuration.
---@return boolean
---@nodiscard
M.is_tflint_installed = function()
    if vim.fn.findfile(config.tflint_path) == "" then
        return false
    end

    return true
end

--- Initializes tflint if neccassary. Returns true after
--- successful initialization, otherwise false will be returned
---@return boolean
---@nodiscard
M.initialize_tflint = function()
    vim.notify(notify_suffix .. "tflint plugins are missing!", vim.log.levels.INFO)
    vim.notify(notify_suffix .. "tflint plugins will be installed...", vim.log.levels.INFO)

    local tflint_init_stderr = run_tflint_init().stderr
    local init_errors = errors.error_messages_init
    for _, error_message in pairs(init_errors) do
        if tflint_init_stderr ~= nil and string.find(tflint_init_stderr, error_message) then
            vim.notify(notify_suffix .. tflint_init_stderr, vim.log.levels.INFO)
            return false
        end
    end

    vim.notify(notify_suffix .. "tflint is initialized!", vim.log.levels.INFO)

    vim.notify(notify_suffix .. "Reconnecting tflint language server...", vim.log.levels.INFO)
    --- TODO: expects, that nvim-lspconfig is used for the tflint language server
    require("lspconfig").tflint.launch()
    vim.notify(notify_suffix .. "Reconnected tflint language server!", vim.log.levels.INFO)

    return true
end

--- Checks, if all tflint plugins are installed
---
--- Returns true, if a plugin is missing. Otherwise false
---@return boolean
---@nodiscard
M.check_if_tflint_plugins_are_missing = function()
    local tflint_stderr = run_tflint().stderr
    local msg_not_initialized = 'Plugin "%w*" not found.'
    if tflint_stderr ~= nil and string.find(tflint_stderr, msg_not_initialized) then
        return true
    end

    return false
end

---@return boolean
---@nodiscard
M.check_if_tflint_is_healthy = function()
    local tflint_stderr = run_tflint().stderr
    if tflint_stderr ~= nil and string.len(tflint_stderr) ~= 0 then
        vim.notify(notify_suffix .. tflint_stderr, vim.log.levels.WARN)
        return false
    end
    return true
end

return M
