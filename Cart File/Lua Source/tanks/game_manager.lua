game_manager = {}
game_manager.__index = game_manager

function game_manager:new()
    local new_obj = {
        game_phase = 1,
        round_number = 1,
        player_turn = 1,
        cam_y = 0,
        min_x = 0,
        max_x = 255,
        projectile_manager_ref,
        last_player_turn = -1
    }
    setmetatable(new_obj, game_manager)
    return new_obj
end

function game_manager:set_player_turn(turn_id)
    self.player_turn = turn_id
end

function game_manager:update()
    if (btnp(4)) then
        if (self.player_turn == 1) then
            self.player_turn = 2

        else
            self.player_turn = 1
        end
    end
    if (#self.projectile_manager_ref.projectiles != 0) then
        if (self.last_player_turn == -1) then
            self.last_player_turn = self.player_turn
            self.player_turn = 3 --Temporary disable tank controls
        end 
    else
        if (self.last_player_turn != -1) then
            self.player_turn = self.last_player_turn
            self.last_player_turn = -1
        end
    end

end