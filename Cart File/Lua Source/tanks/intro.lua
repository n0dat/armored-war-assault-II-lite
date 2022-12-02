intro = {}
intro.__index = intro

function intro:new()
	local new_obj = {
		intro_frame_count = 0,
		show_intro = true,
		intro_over = false,
		next_scene = 0
	}
	setmetatable(new_obj, intro)
	return new_obj
end

function intro:reset()
	self.intro_frame_count = 0
	self.show_intro = true
	self.intro_over = false
	self.next_scene = 0

end

function intro:update(game_manager)
	if (self.next_scene > 165) then
		game_manager:set_state(2)
	else
		self.next_scene += 1
	end
end

function intro:draw()
	spr (42,55,45,2,2)
	if self.show_intro then
		self.show_intro = false
		pal(1, 0, 1)
		pal(3, 0, 1)
		pal(9, 0, 1)
		pal(10, 0, 1)
		pal(5, 0, 1)
		pal(11, 0, 1)
	end
	if self.intro_frame_count > 8 then
		pal(1, 5, 0)
		pal(5, 5, 1)
	end
	if self.intro_frame_count > 16 then
		pal(3, 6, 1)
		pal(11, 7, 1)
		pal(10, 6, 1)
		pal(9, 5, 1)
	end
	if self.intro_frame_count > 24 then 
		print ("iron squids", 42, 64, 7)
		pal(7, 12, 1)
	end
	if self.intro_frame_count > 30 then
		pal()
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
	end
	self.intro_frame_count += 0.5
end
