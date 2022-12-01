game_manager = {}
game_manager.__index = game_manager

function game_manager:new()
    local new_obj = {
        game_phase = 1,
        game_state = 1,
        round_number = 1,
        player_turn = 1,
        total_rounds,
        cam_y = 0,
        min_x = 0,
        max_x = 255,
        projectile_manager_ref,
        menu_manager_ref,
        camera_manager_ref,
        level_manager_ref,
        player_manager_ref,
        destruction_manager_ref,
        intro_ref,
        last_player_turn = -1
    }
    setmetatable(new_obj, game_manager)
    return new_obj
end

function game_manager:set_state(state)
    self.game_state = state
end

function game_manager:set_players()
    if (self.level_manager_ref != nil) then

        player1_ref = self.player_manager_ref.players[1]
        player2_ref = self.player_manager_ref.players[2]

        x1 = self.level_manager_ref.levels[self.level_manager_ref.cur_level].p1.x
        y1 = self.level_manager_ref.levels[self.level_manager_ref.cur_level].p1.y
        x2 = self.level_manager_ref.levels[self.level_manager_ref.cur_level].p2.x
        y2 = self.level_manager_ref.levels[self.level_manager_ref.cur_level].p2.y

        player1_ref.x = x1
        player1_ref.y = y1

        player2_ref.x = x2
        player2_ref.y = y2

        --brx1 = x1 + 7
        --bry1 = y1 + 2
        --brx2 = x2 + 7
        --bry2 = y2 + 2

        player1_ref.barrelx = x1 + 7
        player1_ref.barrely = y1 + 2

        player2_ref.barrelx = x2 + 7
        player2_ref.barrely = y2 + 2

        --btlx1 = x1
        --btly1 = y1 + 7
        --btrx1 = x1 + 7
        --btry1 = y1 + 7

        player1_ref.bottom_left.x = x1
        player1_ref.bottom_left.y = y1 + 7
        player1_ref.bottom_right.x = x1 + 7
        player1_ref.bottom_right.y = y1 + 7

        --btlx2 = x2
        --btly2 = y2 + 7
        --btrx2 = x2 + 7
        --btry2 = y2 + 7

        player2_ref.bottom_left.x = x2
        player2_ref.bottom_left.y = y2 + 7
        player2_ref.bottom_right.x = x2 + 7
        player2_ref.bottom_right.y = y2 + 7

        self.player_manager_ref.players[1] = player1_ref
        self.player_manager_ref.players[2] = player2_ref

    end
end

function game_manager:get_state()
    return self.game_state
end

function game_manager:set_player_turn(turn_id)
    self.player_turn = turn_id
end

function game_manager:update()
    if (self.menu_manager_ref.menu_open) then
        self.menu_manager_ref:draw()
        if (btnp(❎, 1)) then
            self.menu_manager_ref.menu_open = false
        end
    else
        if (btnp(4)) then
            if (self.player_turn == 1) then
                self.player_turn = 2
            else
                self.player_turn = 1
            end
        end
        if (btnp(❎, 1)) then
            self.menu_manager_ref.current_menu = 2
            self.menu_manager_ref.menu_open = true
        end
    end

end