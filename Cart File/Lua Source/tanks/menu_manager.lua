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
		item_costs = {armor = 100, fuel = 20, health = 40, ammo = 15},
		item_benefits = {armor = 30, fuel = 20, health = 60, ammo = 7},
		start_game_selection = {forest = "forest", desert = "desert"},
		setting = 1, -- 1 = forest   2 = desert
		rounds = 1,
		current_selection = 1,
		last_setting_selection = 1,
		shop_selection = 0,
		current_shop_player = 1,
		mouse_sprites = {clicked = 0, unclicked = 16},
		mouse_pos = {x = 0, y = 0},
		player1_purchased = {armor = false, fuel = false, health = false, ammo = false},
		player2_purchased = {armor = false, fuel = false, health = false, ammo = false}
	}
	setmetatable(new_obj, menu_manager)
	return new_obj
end

function menu_manager:shop_reset()
	player1_purchased = {armor = false, fuel = false, health = false, ammo = false}
	player2_purchased = {armor = false, fuel = false, health = false, ammo = false}
end

function menu_manager:reset(typec)
	self.menu_manager = false
	self.current_menu = 1
	self.shop_selection = 0
	self.current_shop_player = 1
	self.mouse_pos = {}
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

	-- ⬆️⬇️⬅️➡️❎🅾️

	self.mouse_pos.x = (self.game_manager_ref.camera_manager_ref.camera.cam_x + stat(32) - 1)
	self.mouse_pos.y = (stat(33) - 1)

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
				palt(0, false)
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

	if (self.current_menu == 4 and btn(❎, 1)) then
		if (self.game_manager_ref.round_manager_ref.total_rounds > 1) then
			self.game_manager_ref:set_state(3)
			pal()
			palt(2, true)
			palt(0, false)
		end
		self.current_menu = 3
	elseif (self.current_menu == 4) then
		if (self.mouse_pos.x >= 98.5 and self.mouse_pos.y >= 39 and self.mouse_pos.x <= 112.5 and self.mouse_pos.y <= 51) then
			self.shop_selection = 1
--		end

		elseif (self.mouse_pos.x >= 118.5 and self.mouse_pos.y >= 39 and self.mouse_pos.x <= 132.5 and self.mouse_pos.y <= 51) then
			self.shop_selection = 2
		--end

		elseif (self.mouse_pos.x >= 138.5 and self.mouse_pos.y >= 39 and self.mouse_pos.x <= 152.5 and self.mouse_pos.y <= 51) then
			self.shop_selection = 3
		--end

		elseif (self.mouse_pos.x >= 158.5 and self.mouse_pos.y >= 39 and self.mouse_pos.x <= 172.5 and self.mouse_pos.y <= 51) then
			self.shop_selection = 4
		--end
		elseif (self.mouse_pos.x >= 159 and self.mouse_pos.y >= 70 and self.mouse_pos.x <= 169.5 and self.mouse_pos.y <= 76) then
			self.shop_selection = 5
		else
			self.shop_selection = 0
		end

		if (stat(34) == 1) then
			if (self.shop_selection == 1) then
				if (self.current_shop_player == 1) then
					if (self.player1_purchased.armor == false and self.game_manager_ref.player_manager_ref.players[1].money >= self.item_costs.armor) then
						self.game_manager_ref.player_manager_ref.players[1]:update_money(-self.item_costs.armor)
						if (self.game_manager_ref.player_manager_ref.players[1].has_armor == false) then
							self.game_manager_ref.player_manager_ref.players[1].has_armor = true
						end
						self.game_manager_ref.player_manager_ref.players[1].armor += self.item_benefits.armor

						self.player1_purchased.armor = true
						sfx(2)
					else
						sfx(4)
					end
				else
					if (self.player2_purchased.armor == false and self.game_manager_ref.player_manager_ref.players[2].money >= self.item_costs.armor) then
						self.game_manager_ref.player_manager_ref.players[2]:update_money(-self.item_costs.armor)
						if (self.game_manager_ref.player_manager_ref.players[2].has_armor == false) then
							self.game_manager_ref.player_manager_ref.players[2].has_armor = true
						end
						self.game_manager_ref.player_manager_ref.players[2].armor += self.item_benefits.armor
						self.player2_purchased.armor = true
						sfx(2)
					else
						sfx(4)
					end					
				end
			elseif (self.shop_selection == 2) then
				if (self.current_shop_player == 1) then
					if (self.player1_purchased.fuel == false and self.game_manager_ref.player_manager_ref.players[1].money >= self.item_costs.fuel) then
						self.game_manager_ref.player_manager_ref.players[1]:update_money(-self.item_costs.fuel)
						self.game_manager_ref.player_manager_ref.players[1].fuel += self.item_benefits.fuel
						self.player2_purchased.fuel = true
						sfx(2)
					else
						sfx(4)
					end
				else
					if (self.player2_purchased.fuel == false and self.game_manager_ref.player_manager_ref.players[2].money >= self.item_costs.fuel) then
						self.game_manager_ref.player_manager_ref.players[2]:update_money(-self.item_costs.fuel)
						self.game_manager_ref.player_manager_ref.players[2].fuel += self.item_benefits.fuel
						self.player2_purchased.fuel = true
						sfx(2)
					else
						sfx(4)
					end
				end
			elseif (self.shop_selection == 3) then
				if (self.current_shop_player == 1) then
					if (self.player1_purchased.health == false and self.game_manager_ref.player_manager_ref.players[1].money >= self.item_costs.health) then
						self.game_manager_ref.player_manager_ref.players[1]:update_money(-self.item_costs.health)
						self.game_manager_ref.player_manager_ref.players[1].health += self.item_benefits.health
						self.player2_purchased.health = true
						sfx(2)
					else
						sfx(4)
					end
				else
					if (self.player2_purchased.health == false and self.game_manager_ref.player_manager_ref.players[2].money >= self.item_costs.health) then
						self.game_manager_ref.player_manager_ref.players[2]:update_money(-self.item_costs.health)
						self.game_manager_ref.player_manager_ref.players[2].health += self.item_benefits.health
						self.player2_purchased.health = true
						sfx(2)
					else
						sfx(4)
					end
				end
			elseif (self.shop_selection == 4) then
				if (self.current_shop_player == 1) then
					if (self.player1_purchased.ammo == false and self.game_manager_ref.player_manager_ref.players[1].money >= self.item_costs.ammo) then
						self.game_manager_ref.player_manager_ref.players[1]:update_money(-self.item_costs.ammo)
						self.game_manager_ref.player_manager_ref.players[1].ammo += self.item_benefits.ammo
						self.player1_purchased.ammo = true
						sfx(2)
					else
						sfx(4)
					end
				else
					if (self.player2_purchased.ammo == false and self.game_manager_ref.player_manager_ref.players[2].money >= self.item_costs.ammo) then
						self.game_manager_ref.player_manager_ref.players[2]:update_money(-self.item_costs.ammo)
						self.game_manager_ref.player_manager_ref.players[2].ammo += self.item_benefits.ammo
						self.player2_purchased.ammo = true
						sfx(2)
					else
						sfx(4)
					end
				end
			elseif (self.shop_selection == 5) then
				sfx(3)
				if (self.current_shop_player == 1) then
					self.current_shop_player = 2
				else
					self.current_shop_player = 1
				end
			end
		end

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
	elseif (self.current_menu == 4) then
		-- shop_selection
		-- shop_sprites
		--  armor = 51
		--  fuel = 52
		--  health = 53
		--  ammo = 54

		-- drawing UI box
		rectfill(self.game_manager_ref.camera_manager_ref.camera.cam_x + 20, 30, self.game_manager_ref.camera_manager_ref.camera.cam_x + 105, 84, 0)
		rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 20,30,self.game_manager_ref.camera_manager_ref.camera.cam_x+105,84,7) -- 20
		rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 20,67,self.game_manager_ref.camera_manager_ref.camera.cam_x+105,67,7) -- 32


		-- drawing Item icons
		spr(self.shop_sprites.armor, self.game_manager_ref.camera_manager_ref.camera.cam_x + 29, 45)
		spr(self.shop_sprites.fuel, self.game_manager_ref.camera_manager_ref.camera.cam_x + 49, 45)
		spr(self.shop_sprites.health, self.game_manager_ref.camera_manager_ref.camera.cam_x + 69, 45)
		spr(self.shop_sprites.ammo, self.game_manager_ref.camera_manager_ref.camera.cam_x + 89, 45)

		spr(49, self.game_manager_ref.camera_manager_ref.camera.cam_x + 93, 73)

		-- drawing boxes behind items and thier costs
		if (self.shop_selection == 1) then
			print("cost: "..self.item_costs.armor, self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 74, 7)
			rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 42, self.game_manager_ref.camera_manager_ref.camera.cam_x + 40, 55, 7)
		elseif (self.shop_selection == 2) then
			print("cost: "..self.item_costs.fuel, self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 74, 7)
			rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 45, 42, self.game_manager_ref.camera_manager_ref.camera.cam_x + 60, 55, 7)
		elseif (self.shop_selection == 3) then
			print("cost: "..self.item_costs.health, self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 74, 7)
			rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 65, 42, self.game_manager_ref.camera_manager_ref.camera.cam_x + 80, 55, 7)
		elseif (self.shop_selection == 4) then
			print("cost: "..self.item_costs.ammo, self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 74, 7)
			rect(self.game_manager_ref.camera_manager_ref.camera.cam_x + 85, 42, self.game_manager_ref.camera_manager_ref.camera.cam_x + 100, 55, 7)
		elseif (self.shop_selection == 5) then
			spr(48, self.game_manager_ref.camera_manager_ref.camera.cam_x + 93, 73)
		end
		
		if (self.current_shop_player == 1) then
			print("player 1", self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 23, 7)
			print("balance: "..self.game_manager_ref.player_manager_ref.players[1].money, self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 87, 7)
		elseif (self.current_shop_player == 2) then
			print("player 2", self.game_manager_ref.camera_manager_ref.camera.cam_x + 70, 23, 7)
			print("balance: "..self.game_manager_ref.player_manager_ref.players[2].money, self.game_manager_ref.camera_manager_ref.camera.cam_x + 25, 87, 7)
		end

		if (stat(34) == 0) then
			spr(self.mouse_sprites.clicked, self.mouse_pos.x, self.mouse_pos.y)
		elseif (stat(34) == 1) then
			spr(self.mouse_sprites.unclicked, self.mouse_pos.x, self.mouse_pos.y)
		end

	end
end

function menu_manager:set_menu(menu)
	self.current_menu = menu
end