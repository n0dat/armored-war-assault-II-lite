menu_manager = {}
menu_manager.__index = menu_manager

function menu_manager:new()
    -- main = 1
    -- shop = 2
	local new_obj = {
        current_menu = 1,
        menu_open = false
	}
	setmetatable(new_obj, menu_manager)
	return new_obj
end

function menu_manager:update(g_manager)
    if (btn(❎, 1)) then
        if (self.current_menu == 1) then
            palt(0, true)
            pal(1, 1, 0)
            pal(5, 5, 0)
            pal(3, 3, 0)
            pal(11, 11, 0)
            pal(10, 10, 0)
            pal(9, 9, 0)
            pal(7, 7, 0)
            self.intro_over = true
            palt(2, true)
            pal(0, 1, 1)
            g_manager:set_state(3)
        end
        if (self.current_menu == 2) then
            palt(0, true)
            pal(1, 1, 0)
            pal(5, 5, 0)
            pal(3, 3, 0)
            pal(11, 11, 0)
            pal(10, 10, 0)
            pal(9, 9, 0)
            pal(7, 7, 0)
            palt(2, true)
            pal(0, 1, 1)
            palt(5, true)
        end
    end
end

function menu_manager:draw()
    if (self.current_menu == 1) then
        --
        palt(0, true)
        --pal(1, 0, 1)
        rectfill(20, 35, 105, 79, 0)
        rect(20, 35, 105, 79, 7)
        rect(32, 62, 92, 62, 7)

        print("armored war assault", 25, 40, 7)
        print("ii lite", 50, 50, 7)
        print("press q to start", 30, 70, 7)
    end

    if (self.current_menu == 2) then
        --
        palt(0, true)
        palt(5, false)
        --pal(1, 0, 1)
        rectfill(20, 35, 105, 79, 0)
        rect(20, 35, 105, 79, 7)
        rect(32, 62, 92, 62, 7)

        print("armored war assault", 25, 40, 7)
        print("ii lite", 50, 50, 7)
        print("this is a pause menu", 30, 70, 7)
    end
end

function menu_manager:set_menu(menu)
    self.current_menu = menu
end