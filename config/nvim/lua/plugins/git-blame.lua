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
        enabled = true,  -- if you want to enable the plugin
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        message_template = truncated_message, -- template for the blame message, check the Message template section for more options
        virtual_text_column = nil,  -- virtual text start column, nil means it will be calculated dynamically
    },
}
