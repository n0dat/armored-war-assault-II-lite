round_manager = {}
round_manager.__index = round_manager

function round_manager:new(init_game_manager_ref)
    local new_obj = {
        rounds = {},
        total_rounds = 1,
        wins_needed,
        total_wins = {p1 = 0, p2 = 0},
        cur_round = 1,
        game_manager_ref = init_game_manager_ref
    }
    setmetatable(new_obj, round_manager)
    return new_obj
end

function round_manager:set_total_rounds(total_rounds)
    if (total_rounds != nil) then

        self.total_rounds = total_rounds

        for i=1,self.total_rounds do
            self.rounds[i] = false
        end
        --self.game_manager_ref.player_manager_ref.players[1].health = count(rounds)
    end
end

function round_manager:end_round(r)
    if (r != nil) then
        self.rounds[self.cur_round] = true
    end
end

function round_manager:is_round_over(r)
    if (r != nil) then
        return self.rounds[self.cur_round]
    end
end

function round_manager:round_winner(winner, r)
    if (winner != nil) then
        if (winner == 1) then
            self.total_wins.p1 += 1
            if (self.total_wins.p1 > self.wins_needed) then
                self.game_manager_ref.game_winner = 1
            end
        end
        if (winner == 2) then
            self.total_wins.p2 += 1
            if (self.total_wins.p2 > self.wins_needed) then
                self.game_manager_ref.game_winner = 2
            end
        end
        self:end_round(r)
    end
end