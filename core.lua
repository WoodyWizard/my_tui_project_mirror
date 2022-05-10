local core = {}
local widget = require 'menu'


core.counter = 1
core.menu_counter = 1
core.key = nil
core.exit = false
core.curs = nil
core.scr = nil
core.drawFactory = {}



function core:key_events(key)
    self.key = key
    if key == "q" then
        self.scr:refresh ()
        self.curs.endwin ()
        self.exit = true
    end
	if key == 259 then -- UP ARROW
		if widget.widgets[widget.focus_id].selected > 1 then
			widget.widgets[widget.focus_id].selected = widget.widgets[widget.focus_id].selected - 1
		end
	end
	if key == 258 then -- DOWN ARROW
		if widget.widgets[widget.focus_id].selected < #widget.widgets[widget.focus_id].sections  then
			widget.widgets[widget.focus_id].selected = widget.widgets[widget.focus_id].selected + 1
		end
	end
end

function core:init(a,b)
    self.curs = a
    self.scr = b
end

function core:get_key()
    local c = self.scr:getch ()
    if c < 256 then c = string.char (c) end
    return c
end

function core:draw()
    if widget.widgets ~= nil then
        for i = 1, #widget.widgets, 1 do
            widget.widgets[i]:draw(self.curs, self.scr)
        end
    end
end


return core