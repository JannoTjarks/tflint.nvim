if vim.g.tflint_runned == true then
    return
end

vim.g.tflint_runned = true

local notify_suffix = require("tflint").get_notify_suffix()
local utils = require("tflint.utils")

if utils.is_tflint_installed() == false then
    vim.notify(notify_suffix .. "please install tflint! Without tflint the plugin is not able to work.", vim.log.levels.WARN)
    return
end

if utils.check_if_tflint_plugins_are_missing() == true then
    if utils.initialize_tflint() == false then
        vim.notify(notify_suffix .. "stopped because an error gets thrown", vim.log.levels.WARN)
        return
    end
end

if utils.check_if_tflint_is_healthy() == false then
    vim.notify(notify_suffix .. "stopped because an error gets thrown", vim.log.levels.WARN)
    return
end
