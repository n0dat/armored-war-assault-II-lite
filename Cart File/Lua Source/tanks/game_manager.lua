game_manager = {}
game_manager.__index = game_manager

function game_manager:new()
	local new_obj = {
		game_phase = 1,
		game_state = 1,
		player_turn = 1,
		game_winner = 0,
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
		round_manager_ref,
		players_set = false,
		setting_offset = 0,
		last_player_turn = -1
	}
	setmetatable(new_obj, game_manager)
	return new_obj
end

function game_manager:set_state(state)
	if (state != nil) then
		self.game_state = state
	end
end

function game_manager:reset_all(typec)

	-- game manager reset
	self.game_phase = 1
	self.game_state = 1
	self.game_winner = 0
	self.cam_y = 0
	self.min_x = 0
	self.max_x = 255
	self.players_set = false
	self.last_player_turn = -1

	if (typec != nil) then
		if (typec == 1) then
			self.setting_offset = self.menu_manager_ref.last_setting_selection
		end
	end

	-- reset references
	self.player_manager_ref:reset()
	self.projectile_manager_ref:reset()
	self.round_manager_ref:reset() -- need to re-call set_total_rounds(rounds)
	self.destruction_manager_ref:reset()
	self.camera_manager_ref:reset()
	self.intro_ref:reset()
	self.level_manager_ref:reset()

	if (typec != nil) then
		if (typec == 1) then
			self.menu_manager_ref:reset(typec)
		end
	end

	self.level_manager_ref.cur_level = self.setting_offset

	-- resetting the color palette
	pal()
	palt(2, true)
	palt(0, false)
	pal(0, 0, 1)

end

function game_manager:set_players()
	if (self.players_set == false) then
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

			player1_ref.barrelx = x1 + 7
			player1_ref.barrely = y1 + 2

			player2_ref.barrelx = x2 + 7
			player2_ref.barrely = y2 + 2

			player1_ref.bottom_left.x = x1
			player1_ref.bottom_left.y = y1 + 7
			player1_ref.bottom_right.x = x1 + 7
			player1_ref.bottom_right.y = y1 + 7

			player2_ref.bottom_left.x = x2
			player2_ref.bottom_left.y = y2 + 7
			player2_ref.bottom_right.x = x2 + 7
			player2_ref.bottom_right.y = y2 + 7

			self.player_manager_ref.players[1] = player1_ref
			self.player_manager_ref.players[2] = player2_ref
		end

		self.camera_manager_ref:update()

	end
end

function game_manager:get_state()
	return self.game_state
end

function game_manager:set_player_turn(turn_id)
	self.player_turn = turn_id
end

function game_manager:update()
	
--	if (self.round_manager_ref.cur_round == 1 and self.round_manager_ref.total_rounds == 1 and self.game_winner != 0) then
--		self.round_manager_ref.cur_round = 1
--		self.level_manager_ref.cur_level = 1
--		self:set_state(1)
--		self.menu_manager_ref.menu_open = false
--		self.camera_manager.ref:reset()
--		self.players_set = false
--		self.intro_ref:reset()
	if (self.round_manager_ref.cur_round > self.round_manager_ref.total_rounds) then
		self.round_manager_ref.cur_round = 1
		self.level_manager_ref.cur_level = self.setting_offset
		self:set_state(2)
		self.menu_manager_ref.current_menu = 3
		self.menu_manager_ref.menu_open = false
		self.camera_manager_ref:reset()
		self.players_set = false
		self.intro_ref:reset()
	end

	if (self.players_set == false) then
		self:set_players()
		self.players_set = true
	end

	if (self.menu_manager_ref.menu_open) then
		self.menu_manager_ref:draw()
		if (btnp(🅾️, 1)) then
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
		if (btnp(🅾️, 1)) then
			self.menu_manager_ref.current_menu = 3
			self.menu_manager_ref.menu_open = true
		end
	end

end