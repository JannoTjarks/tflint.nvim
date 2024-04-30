local M = {}

local config = require("tflint").get_config()
local notify_suffix = require("tflint").get_notify_suffix()

local function check_tflint_installation()
    if vim.fn.findfile(config.tflint_path) == "" then
        vim.notify_once(notify_suffix .. "tflint needs to be installed!", vim.log.levels.INFO)
        return 1
    end

    return 0
end

local function check_tflint_init()
    local tflint_init = vim.fn.system({
        config.tflint_path,
        "--init",
    })

    return tflint_init
end

local function check_mason_nvim_installation()
    if vim.fn.finddir(config.mason_path) == "" then
        vim.notify_once(notify_suffix .. "mason.nvim needs to be installed!", vim.log.levels.INFO)
        return 1
    end

    return 0
end

function M.validate_tflint_installation()
    if check_tflint_installation() == 0 then
        return 0
    end

    if config.use_mason == false then
        return 1
    end

    if not check_mason_nvim_installation() == 0 then
        return 1
    end

    vim.notify_once(
        notify_suffix .. "tflint will be installed through mason.nvim...",
        vim.log.levels.INFO
    )
    vim.cmd("MasonInstall tflint")

    return 2
end

function M.initialize_tflint()
    local tflint_check = vim.fn.system({
        config.tflint_path,
    })

    local msg_not_initialized = 'Plugin "%w*" not found.'
    if string.find(tflint_check, msg_not_initialized) then
        vim.notify_once(
            notify_suffix .. "tflint plugins need to be installed...",
            vim.log.levels.INFO
        )
        vim.fn.system({
            config.tflint_path,
            "--init",
        })

        local tflint_init_status = check_tflint_init()
        if string.find(tflint_init_status, "Failed to install a plugin") then
            vim.notify_once(notify_suffix .. tflint_init_status, vim.log.levels.INFO)
            return 1
        end

        vim.notify_once(notify_suffix .. "tflint is initialized!", vim.log.levels.INFO)

        vim.notify_once(
            notify_suffix .. "Reconnecting tflint language server...",
            vim.log.levels.INFO
        )
        require("lspconfig").tflint.launch()
        vim.notify_once(notify_suffix .. "Reconnected tflint language server!", vim.log.levels.INFO)

        return 0
    end

    if string.find(check_tflint_init(), "is already installed") then
        return 0
    end

    vim.notify_once(notify_suffix .. tflint_check, vim.log.levels.INFO)
    return 1
end

return M
