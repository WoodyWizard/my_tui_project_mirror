require 'utils'
local curses = require "curses"



local widget = {focus_id = nil, counter = 0, widgets = {}}
local menu = {amount = 0, arrange = true, sections = {}, selected = 1, position = {x = nil, y = nil}, focus = false, id = nil}
local section = {name = "section", colorFont = {active = nil, passive = nil}, colorBackground = {active = nil, passive = nil}, position = {x = nil, y = nil}, id = nil}



function menu:add_section(name, colorFont, colorBackground)
    self.amount = self.amount + 1

    local localSection = deepcopy(section)
    localSection.name = name
    localSection.colorFont = {active = curses.COLOR_BLACK, passive = colorFont}
    localSection.colorBackground = {active = curses.COLOR_CYAN, passive = colorBackground}
    localSection.position = {x = self.position.x, y = self.position.y}
    localSection.id = self.amount

    table.insert(self.sections, localSection )


    if self.box_arrange == true then                                 -- arrange background
        local biggest = 0
        for i = 1, #self.sections, 1 do
            if #self.sections[i].name > biggest then
                biggest = #self.sections[i].name
            end
        end
        for i = 1, #self.sections, 1 do
            if #self.sections[i].name < biggest then
                local difference = biggest - #self.sections[i].name
                for b = 1, difference, 1 do
                    self.sections[i].name = self.sections[i].name .. " "
                end
            end
        end
    end


    if self.arrange == true then
        self.sections[self.amount].position.y = self.position.y  + self.amount
    end
end



function menu:set_focus(flag)
    self.focus = flag
end



function menu:draw(curs, scr)
    if self.sections ~= nil then
        for i = 1, #self.sections, 1 do
            if self.selected == self.sections[i].id then
                scr:attron(curs.color_pair(23))
            else
                scr:attron(curs.color_pair(22))
            end
            scr:mvaddstr ( self.sections[i].position.y, self.sections[i].position.x , self.sections[i].name )
        end
    end
end


function menu:box_background()
    
end


function menu:select()

end


function section:activate()
    local object = self.colorFont.passive
    local object2 = self.colorBackground.passive

    self.colorFont.passive = self.colorFont.active
    self.colorBackground.passive = self.colorBackground.active

    self.colorFont.active = object
    self.colorBackground.active = object2
end



function section:change_name(name)
    self.name = name
end



function widget:create_menu(x, y, arrange, box_arrange)
    if box_arrange == nil then
        box_arrange = false
    end
    widget.counter = widget.counter + 1
    local localMenu = deepcopy(menu)
    localMenu.arrange = arrange
    localMenu.position.x = x
    localMenu.position.y = y
    localMenu.id = widget.counter
    localMenu.box_arrange = box_arrange
    table.insert(self.widgets,localMenu)
    return localMenu
end



function widget:set_focus(id)
    self.focus_id = id
end



function widget:set_counter_value(value)
    self.counter = value
end




return widget