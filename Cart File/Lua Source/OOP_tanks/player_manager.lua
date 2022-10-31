--Globals for player_manager class
solid_ground_color = 15
grav_const = 0.6 --Do not set above 1

--Player Manager Class
player_manager = {}

player_manager.__index = player_manager

function player_manager:new()
    local new_obj = {
        player_turn = 0,
        players = {}
    }
    setmetatable(new_obj, player_manager)
    
    return new_obj
end

function player_manager:add_player(new_player)
    if (new_player != nil) then
        add(self.players, new_player)
        if (#self.players == 1) then
            self.player_turn = 1
        end
    end
end

function player_manager:update()
    if (self.player_turn > 0 and self.player_turn <= #self.players) then
        self.players[self.player_turn]:update()
    end
    self:do_gravity()
end

function player_manager:do_gravity()
    local bl_x
    local bl_y
    local br_x
    local br_y
    for i = 1, #self.players do
        bl_x = self.players[i].bottom_left.x
        bl_y = self.players[i].bottom_left.y - grav_const
        br_x = self.players[i].bottom_right.x
        br_y = self.players[i].bottom_right.y - grav_const
        if (not is_solid(bl_x, bl_y+1, solid_ground_color) and not is_solid(br_x, br_y+1, solid_ground_color)) then
            self.players[i]:move_player_cords(0, grav_const)
        end
    end
end

function player_manager:draw()
   for i = 1, #self.players do
       self.players[i]:draw()
   end
end



