local capi = Capi
local awful = require("awful")
local core = require("core")
local tilted = require("layouts.tilted")


---@class Rice.Layouts
---@field list awful.layout[]
local layouts = {
    list = core.layout.initialize_list {
        tilted.new("tiling"),
        awful.layout.suit.floating,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
    },
}

capi.tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts(layouts.list)
end)

return layouts
