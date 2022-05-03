local curses = require "curses"
local utf8 = require 'lua-utf8'
local libmenu = require 'menu'
local core = require 'core'
local exit = false


local newMenu = libmenu:create_menu(true, 10, 10)
newMenu:add_section("First", curses.COLOR_BLACK, curses.COLOR_BLUE)
newMenu:add_section("Second", curses.COLOR_BLACK, curses.COLOR_BLUE)
newMenu:add_section("Third", curses.COLOR_BLACK, curses.COLOR_BLUE)
newMenu:add_section("Fourth", curses.COLOR_BLACK, curses.COLOR_BLUE)

libmenu:set_focus(1)




local function main ()
    local stdscr = curses.initscr ()
    curses.cbreak ()
    curses.echo (false)	-- not noecho !
    curses.nl (false)	-- not nonl !
    stdscr:clear ()
	stdscr:keypad(true)
	core:init(curses,stdscr)
	
	local terminalX, terminalY = stdscr:getmaxyx()

	curses.start_color()
	curses.init_pair(22, curses.COLOR_BLACK , curses.COLOR_BLUE)
	curses.init_pair(23, curses.COLOR_BLACK , curses.COLOR_CYAN)



	while core.exit == false do
		for i = 1, 4, 1 do
			if newMenu.selected == newMenu.sections[i].id then
				stdscr:attron(curses.color_pair(23))
			else
				stdscr:attron(curses.color_pair(22))
			end
			stdscr:mvaddstr ( newMenu.sections[i].position.y, newMenu.sections[i].position.x , newMenu.sections[i].name )
		end


		core:key_events(core:get_key())
		stdscr:refresh ()
	end

end



local function err (err)
    curses.endwin ()
    print "Caught an error:"
    print (debug.traceback (err, 2))
    os.exit (2)
end

xpcall (main, err)