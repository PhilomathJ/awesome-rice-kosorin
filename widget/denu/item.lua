local setmetatable = setmetatable
local beautiful = require("theme.theme")
local gtable = require("gears.table")
local wibox = require("wibox")
local base = require("wibox.widget.base")


---@class DenuItem.module
---@operator call: DenuItem
local M = { mt = {} }

function M.mt:__call(...)
    return M.new(...)
end


---@class DenuItem : wibox.container
---@field package _private DenuItem.private
M.object = { is_menu_item = true }
---@class DenuItem.private
---@field widget wibox.widget.base|nil
---@field index integer
---@field visible boolean
---@field enabled boolean
---@field selected boolean
---@field mouse_move_select? boolean
---@field mouse_move_show_submenu? boolean
---@field cache_submenu? boolean
---@field submenu? unknown
---@field callback? fun(item: DenuItem, menu: Denu, context: Mebox.context): boolean?
---@field on_show? fun(item: DenuItem, menu: Denu, args: Mebox.show.args, context: Mebox.context): boolean?
---@field on_hide? fun(item: DenuItem, menu: Denu)
---@field on_ready? fun(item_widget?: wibox.widget.base, item: MeboxItem, menu: Mebox, args: Mebox.show.args, context: Mebox.context)
---@field layout_id? string
---@field layout_add? fun(layout: wibox.layout, item_widget: wibox.widget.base)
---@field buttons_builder? fun(item: MeboxItem, menu: Mebox, default_click_action: function): awful.button[]
---@field template? widget_template
---@field.update_callback fun(self: DenuItem, item, menu)


---@param context widget_context
---@param width number
---@param height number
---@return widget_layout_result[]|nil
function M.object:layout(context, width, height)
    if not self._private.widget then
        return
    end
    return { base.place_widget_at(self._private.widget, 0, 0, width, height) }
end

---@param context widget_context
---@param width number
---@param height number
---@return number width
---@return number height
function M.object:fit(context, width, height)
    if not self._private.widget then
        return 0, 0
    end
    return base.fit_widget(self, context, self._private.widget, width, height)
end

---@return wibox.widget.base|nil
function M.object:get_widget()
    return self._private.widget
end

---@param widget? widget_value
function M.object:set_widget(widget)
    if self._private.widget == widget then
        return
    end

    widget = widget and base.make_widget_from_value(widget)
    if widget then
        base.check_widget(widget)
    end

    self._private.widget = widget
    self:emit_signal("property::widget")
end

---@return wibox.widget.base[]
function M.object:get_children()
    return self._private.widget and { self._private.widget } or {}
end

---@param children wibox.widget.base[]
function M.object:set_children(children)
    self:set_widget(children[1])
end


---@class DenuItem.new.args
---@field widget? widget_value

---@param args? DenuItem.new.args
---@return DenuItem
function M.new(args)
    args = args or {}

    local self = base.make_widget(nil, nil, { enable_properties = true }) --[[@as DenuItem]]

    gtable.crush(self, M.object, true)

    return self
end

return setmetatable(M, M.mt)
