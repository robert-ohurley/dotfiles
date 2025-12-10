local message_template = " <summary> • <date> • <author> • <<sha>>"

-- truncate to max 50 chars
local max_len = 50
local truncated_message = message_template:sub(1, max_len)

return {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin will only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        -- your configuration comes here
        -- for example
        enabled = false,  -- if you want to enable the plugin
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        message_template = (" <summary> • <date> • <author> • <<sha>>").sub(1, max_len), -- template for the blame message, check the Message template section for more options
        virtual_text_column = vim.api.nvim_win_get_width(0) - 50 + 1,  -- virtual text start column, check. Start virtual text at column section for more options
    },
}
