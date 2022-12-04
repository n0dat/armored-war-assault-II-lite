menu_manager = {}
menu_manager.__index = menu_manager

function menu_manager:new(init_game_manager_ref)
    -- main = 1
    -- pause = 2
    -- end game = 3
    -- shop = 4
	local new_obj = {
        current_menu = 1,
        game_manager_ref = init_game_manager_ref,
        menu_open = false,
        shop_sprites = {armor = 51, fuel = 52, health = 53, ammo = 54},
        start_game_selection = {forest = "forest", desert = "desert"},
        setting = 1, -- 1 = forest   2 = desert
        rounds = 1,
        current_selection = 1,
        last_setting_selection = 1,
	}
	setmetatable(new_obj, menu_manager)
	return new_obj
end

function menu_manager:reset(typec)
    self.menu_manager = false
    self.current_menu = 1
    if (typec != nil) then
        if (typec == 1) then
            self.rounds = 1
            self.setting = 1
            self.current_selection = 1
        end
        if (typec == 2) then
            self.game_manager_ref.level_manager_ref.cur_level = self.last_setting_selection
        end
    end
end

function menu_manager:update()

    -- ⬆️⬇️⬅️➡️

    --if (btn(❎, 1)) then
        if (self.current_menu == 1) then

            if (btn(❎, 1)) then
                pal(1, 1, 1)
                pal(5, 5, 1)
                pal(3, 3, 1)
                pal(11, 11, 1)
                pal(10, 10, 1)
                pal(9, 9, 1)
                pal(7, 7, 1)
                self.intro_over = true
                pal(0, 1, 1)
                pal(0, 0, 1)
                pal()
                palt(2, true)
                self.game_manager_ref:set_state(3)
                self.current_menu = 3
                self.game_manager_ref.round_manager_ref:set_total_rounds(self.rounds)
                if (self.setting == 1) then
                    self.game_manager_ref.setting_offset = 1
                    self.game_manager_ref.level_manager_ref.cur_level = 1
                else
                    self.game_manager_ref.setting_offset = 5
                    self.last_setting_selection = 5
                    self.game_manager_ref.level_manager_ref.cur_level = 5
                end
            end

            if (btnp(⬇️, 0) or btnp(⬆️, 0)) then
                if (self.current_selection == 1) then
                    self.current_selection = 2
                else
                    self.current_selection = 1
                end
            end

            if (btnp(➡️, 0)) then
                if (self.current_selection == 1) then
                    self.rounds += 1
                    if (self.rounds > 8) then
                        self.rounds = 1
                    end
                else
                    if (self.setting == 1) then
                        self.setting = 2
                    else
                        self.setting = 1
                    end
                end
            end

            if (btnp(⬅️, 0)) then
                if (self.current_selection == 1) then
                    self.rounds -= 1
                    if (self.rounds < 1) then
                        self.rounds = 8
                    end
                else
                    if (self.setting == 1) then
                        self.setting = 2
                    else
                        self.setting = 1
                    end
                end
            end

        elseif (self.current_menu == 2) then
            if (btn(❎, 1)) then
                pal(1, 1, 1)
                pal(5, 5, 1)
                pal(3, 3, 1)
                pal(11, 11, 1)
                pal(10, 10, 1)
                pal(9, 9, 1)
                pal(7, 7, 1)
                pal(0, 1, 1)
                pal(1, 1, 1)
                pal()
                palt(2, true)
                self.game_manager_ref:set_state(3)
            end
        end
    --end

    if (btn(❎, 0) and self.current_menu == 3) then
        self.game_manager_ref:reset_all()
        pal(1, 1, 1)
        pal(5, 5, 1)
        pal(3, 3, 1)
        pal(11, 11, 1)
        pal(10, 10, 1)
        pal(9, 9, 1)
        pal(7, 7, 1)
        pal(0, 0, 1)
        pal(1, 1, 1)
        pal()
        palt(2, true)
        self.game_manager_ref:set_state(2)
        self.current_menu = 1
    end

    if (btn(🅾️, 0) and self.current_menu == 3) then
        self.game_manager_ref:reset_all(1)
        pal(1, 1, 1)
        pal(5, 5, 1)
        pal(3, 3, 1)
        pal(11, 11, 1)
        pal(10, 10, 1)
        pal(9, 9, 1)
        pal(7, 7, 1)
        pal(0, 0, 1)
        pal(1, 1, 1)
        pal()
        palt(2, true)
        self.game_manager_ref:set_state(3)
        self.current_menu = 3
    end

end

function menu_manager:draw()
    if (self.current_menu == 1) then
        rectfill(self.game_manager_ref.camera_manager_ref.camera.cam_x + 20, 35, self.game_manager_ref.camera_manager_ref.camera.cam_x + 105, 79, 0)
        rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 20, 35, self.game_manager_ref.camera_manager_ref.camera.cam_x + 105, 79, 7)
        rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 32, 62, self.game_manager_ref.camera_manager_ref.camera.cam_x + 92, 62, 7)

        print("armored war assault", self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 40, 7)
        print("ii lite", self.game_manager_ref.camera_manager_ref.camera.cam_x + 50, 50, 7)
        print("press q to start", self.game_manager_ref.camera_manager_ref.camera.cam_x + 30, 70, 7)

        print("num rounds: "..self.rounds, self.game_manager_ref.camera_manager_ref.camera.cam_x + 40, 85, 8)

        if (self.current_selection == 1) then
            spr(50, self.game_manager_ref.camera_manager_ref.camera.cam_x + 32, 85)
        else
            spr(50, self.game_manager_ref.camera_manager_ref.camera.cam_x + 32, 95)
        end

        if (self.setting == 1) then
            print("setting: "..self.start_game_selection.desert, self.game_manager_ref.camera_manager_ref.camera.cam_x + 40, 95, 8)
        else
            print("setting: "..self.start_game_selection.forest, self.game_manager_ref.camera_manager_ref.camera.cam_x + 40, 95, 8)
        end
        
    elseif (self.current_menu == 2) then
        rectfill(self.game_manager_ref.camera_manager_ref.camera.cam_x + 20, 35, self.game_manager_ref.camera_manager_ref.camera.cam_x + 105, 79, 0)
        rect(self.game_manager_ref.camera_manager_ref.camera.cam_x,35,self.game_manager_ref.camera_manager_ref.camera.cam_x+105,79,7) -- 20
        rect(self.game_manager_ref.camera_manager_ref.camera.cam_x,62,self.game_manager_ref.camera_manager_ref.camera.cam_x+92,62,7) -- 32

        print("armored war assault poggers", 25, 40, 8)
        print("ii lite", 50, 50, 7)
        print("this is a pause menu", 30, 70, 7)
    elseif (self.current_menu == 3) then
        winner = self.game_manager_ref.game_winner
        rectfill(self.game_manager_ref.camera_manager_ref.camera.cam_x + 5, 35, self.game_manager_ref.camera_manager_ref.camera.cam_x+105, 79, 7) -- top left x = 20

        if (winner == 0) then
            print("its a draw!", self.game_manager_ref.camera_manager_ref.camera.cam_x + 10, 40, 8)
        else
            print("player "..winner.." wins!", self.game_manager_ref.camera_manager_ref.camera.cam_x+10, 40, 8) -- x = 25
        end

        print("❎ to leave or", self.game_manager_ref.camera_manager_ref.camera.cam_x+10, 60, 8) -- 
        print("🅾️ to play again", self.game_manager_ref.camera_manager_ref.camera.cam_x+10, 70, 8) -- en
    end
end

function menu_manager:set_menu(menu)
    self.current_menu = menu
end