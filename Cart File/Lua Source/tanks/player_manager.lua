--Globals for player_manager class
solid_ground_color = 15
grav_const = 0.6 --Do not set above 1

--Player Manager Class
player_manager = {}
player_manager.__index = player_manager

function player_manager:new(init_game_manager_ref)
    local new_obj = {
        players = {},
        game_manager_ref = init_game_manager_ref,
        round = 1,
    }
    setmetatable(new_obj, player_manager) 
    return new_obj
end

function player_manager:reset()
    for i = 1, #self.players do
        self.players[i]:reset()
    end
    self.round = 1
end

function player_manager:add_player(new_player)
    if (new_player != nil) then
        add(self.players, new_player)
    end
end

function player_manager:add_player_cmr(cam_mgr_ref)
    for i = 1, #self.players do
        self.players[i].cm_ref = cam_mgr_ref
    end
end

function player_manager:reset_player_health()
    for i = 1, #self.players do
        self.players[i].health = 100
    end
end

function player_manager:update()

    self.round = self.game_manager_ref.round_manager_ref.cur_round

    local current_player_ref = self.players[self.game_manager_ref.player_turn]

    for i = 1, #self.players do
        if (self.players[i].health <= 0) then
            if (not self.game_manager_ref.round_manager_ref:is_round_over()) then
                self.game_manager_ref.projectile_manager_ref:remove_all_projectiles()
                self.game_manager_ref.destruction_manager_ref:clear_craters()

                self.game_manager_ref.camera_manager_ref:reset()
                self.game_manager_ref.round_manager_ref.cur_round += 1
                self.game_manager_ref.level_manager_ref.cur_level += 1
                if (self.game_manager_ref.setting_offset != 1) then
                    --
                    if (self.game_manager_ref.level_manager_ref.cur_level > 8) then
                        self.game_manager_ref.level_manager_ref.cur_level = 1
                    end
                end

                if (i == 1) then
                    self.game_manager_ref.player_turn = 2
                    self.game_manager_ref.round_manager_ref:round_winner(2)
                elseif (i == 2) then
                    self.game_manager_ref.player_turn = 1
                    self.game_manager_ref.round_manager_ref:round_winner(1)
                end

                --self.game_manager_ref.player_turn = (i == 1) and 2 or 1

                --self.game_manager_ref.round_manager_ref:round_winner(self.game_manager_ref.player_turn)

                --self.game_manager_ref:set_players()

                self.game_manager_ref.players_set = false

                self:reset_player_health()



                if (self.game_manager_ref.round_manager_ref.total_rounds > 1 and self.game_manager_ref.round_manager_ref.cur_round <= self.game_manager_ref.round_manager_ref.total_rounds) then
                    self.game_manager_ref.menu_manager_ref.current_menu = 4
                end

                self.game_manager_ref:set_state(2)
                --return
            end
        end
    end

    if (current_player_ref != nil and #self.game_manager_ref.projectile_manager_ref.projectiles == 0) then 
        current_player_ref:update()
    end
    self:do_gravity()
end

function player_manager:do_gravity()
    local bl_x
    local bl_y
    local br_x
    local br_y
    local can_fall
    for i = 1, #self.players do
        self.players[i].can_move = false
        can_fall = true
        bl_x = self.players[i].bottom_left.x
        bl_y = self.players[i].bottom_left.y -- grav_const
        br_x = self.players[i].bottom_right.x
        br_y = self.players[i].bottom_right.y -- grav_const
        for i = 0, 7 do
            if (i == 0) then
                can_fall = is_not_solid(bl_x, bl_y+1, sky_color)
            elseif (i == 7) then
                can_fall = is_not_solid(br_x, br_y+1, sky_color)
            else
                can_fall = is_not_solid(bl_x + i, bl_y+1, sky_color)
            end
            if (not can_fall) then
                break
            end
        end
        if (can_fall) then
            self.players[i]:move_player_cords(0, grav_const)
        end
        --[[
        if (is_not_solid(bl_x, bl_y+1, sky_color) and is_not_solid(br_x, br_y+1, sky_color)) then
            self.players[i]:move_player_cords(0, grav_const)
        end
        --]]
        self.players[i].can_move = true
    end
end

function player_manager:draw()
   for i = 1, #self.players do
       self.players[i]:draw()
   end
end



