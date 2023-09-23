local M = {}

local defaults = {
    --- @type string
    file_path = vim.fn.stdpath('state') .. '/persisted_colorscheme',
    --- @type string
    default_colorscheme = nil
}
M.options = defaults

--- @param theme string
local function apply_theme(theme)
    vim.cmd("colorscheme " .. theme)
end

--- @param path string
local function store_theme(path)
    local colorscheme = vim.g.colors_name
    -- if not colorscheme then return end
    local f = io.open(path, "w")
    if not f then return end
    f:write(colorscheme)
    f:close()
end

--- @param path string
--- @param fallback nil | string
local function load_theme(path, fallback)
    local f = io.open(path, "r")
    if not f then return nil end
    local stored_theme = f:read("*a")
    f:close()
    if stored_theme then
        apply_theme(stored_theme)
    elseif fallback then
        apply_theme(fallback)
    end
end

function M.setup(opts)
    local options = vim.tbl_extend('force', M.options, opts)

    load_theme(options.file_path, options.default_colorscheme)

    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        callback = function()
            store_theme(options.file_path)
        end
    })
end

return M
