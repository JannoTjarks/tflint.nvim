local M = {}

--- @class status_code
--- @field exit_code_ok integer
--- @field exit_code_error integer
--- @field exit_code_issues_found integer
M.status_code = {
    exit_code_ok = 0,
    exit_code_error = 1,
    exit_code_issues_found = 2,
}

--- @class error_messages_init
--- @field failed_to_load_config string
--- @field failed_to_install_plugin string
--- @field failed_to_fetch_github_release string
--- @field failed_to_find_workspaces string
--- @field failed_to_find_plugin string
M.error_messages_init = {
    failed_to_load_config = "Failed to load TFLint config;",
    failed_to_find_workspaces = "Failed to find workspaces;",
    failed_to_fetch_github_release = "Failed to fetch GitHub releases:",
    failed_to_install_plugin = "Failed to install a plugin;",
    failed_to_find_plugin = "Failed to find a plugin;",
}

return M
