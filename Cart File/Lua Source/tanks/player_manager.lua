--Globals for player_manager class
solid_ground_color = 15
grav_const = 0.6 --Do not set above 1

--Player Manager Class
player_manager = {}

player_manager.__index = player_manager

function player_manager:new(init_game_manager_ref)
    local new_obj = {
        players = {},
        game_manager_ref = init_game_manager_ref
    }
    setmetatable(new_obj, player_manager) 
    return new_obj
end

function player_manager:add_player(new_player)
    if (new_player != nil) then
        add(self.players, new_player)
    end
end

function player_manager:update()
    local current_player_ref = self.players[self.game_manager_ref.player_turn]
    if (current_player_ref != nil) then 
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
    end
end

function player_manager:draw()
   for i = 1, #self.players do
       self.players[i]:draw()
   end
end



