require("globals")

require("config")

require("theme.manager").initialize()

require("core")


local awful = require("awful")
local wibox = require("wibox")

local di = require("widget.denu.item")
local capsule = require("widget.capsule")

awful.popup {
    x = 50,
    y = 50,
    width = 600,
    height = 300,
    bg = "#004400",
    widget = wibox.widget {
        layout = wibox.container.margin,
        margins = 20,
        {
            widget = di,
            {
                widget = capsule,
                {
                    widget = wibox.widget.textbox,
                    text = "hello world",
                },
            },
        },
    },
}
