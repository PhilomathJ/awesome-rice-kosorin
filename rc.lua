require("globals")

local config = require("config")

require("theme.manager").initialize()



local awful = require("awful")
local wibox = require("wibox")

local beautiful = require("theme.theme")
local css = require("utils.css")
local pango = require("utils.pango")
local dpi = Dpi
local hui = require("utils.ui")
local capsule = require("widget.capsule")

local dm = require("widget.denu.menu")
local di = require("widget.denu.item")

local default_item_template = {
    forced_height = dpi(32),
    forced_width = dpi(200),
    id = "#container",
    widget = capsule,
    paddings = hui.thickness { dpi(6), dpi(8) },
    {
        layout = wibox.layout.align.horizontal,
        expand = "inside",
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(12),
            {
                id = "#icon",
                widget = wibox.widget.imagebox,
                resize = true,
                image = config.places.theme .. "/icons/target.svg",
            },
            {
                id = "#text",
                widget = wibox.widget.textbox,
                text = "foo bar"
            },
        },
        {
            widget = wibox.container.margin,
            right = -dpi(2),
            {
                visible = false,
                id = "#right_icon",
                widget = wibox.widget.imagebox,
                resize = true,
            },
        },
    },
}

local popup = dm {
    template = {
        layout = wibox.container.margin,
        margins = 20,
        {
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(4),
            {
                widget = di,
                text = "foo",
                callback = function()
                    print("execute foo")
                end,
                template = default_item_template,
            },
            {
                widget = di,
                test_prop = 23,
                template = default_item_template,
            },
        },
    },
}


local function collect_items(widget, items)
    if widget.is_menu_item then
        table.insert(items, widget)
        return
    end
    for _, child in ipairs(widget:get_children()) do
        collect_items(child, items)
    end
end

local function collect_all_items(self)
    local items = {}
    collect_items(self, items)
    return items
end

local ws = collect_all_items(popup.widget)

popup:show()


Dump(ws, nil, 2)
