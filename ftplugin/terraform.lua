local notify_suffix = require("tflint").get_notify_suffix()
local utils = require("tflint.utils")

if utils.validate_tflint_installation() == 0 then
    utils.initialize_tflint()
elseif utils.validate_tflint_installation() == 2 then
    vim.notify(notify_suffix .. "please restart neovim after MasonInstall!", vim.log.levels.INFO)
else
    vim.notify(notify_suffix .. "stopped because an error gets thrown", vim.log.levels.INFO)
end
