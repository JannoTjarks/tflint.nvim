-- Rerun tests only if their modification time changed.
cache = true

std = luajit
codes = true

self = false

-- Global objects defined by the C code
read_globals = {
    "vim",
}

-- Without this ignore, luacheck would throw an error
-- for the global variable in vim.g.tflint_runned
ignore = {
    "122", -- Indirectly setting a readonly global
}
