level_manager = {}
level_manager.__index = level_manager

function level_manager:new()
	local new_obj = {
        levels = {},
        game_manager_ref,
        cur_level = 1
	}
	setmetatable(new_obj, level_manager)
	return new_obj
end

function level_manager:add_level(new_level)
    if (new_level != nil) then
        add(self.levels, new_level)
    end
end

function level_manager:init_levels()

    -- 1 - 4 are desert levels
    -- 5 - 8 are forest / grasslands levels

    -- each level contains player starting coordinates and map draw information
    -- p1 x, p1 y, p2 x, p2 y, top left map tiles (x), top left map tiles (y), length, height, left x, right x, top y, bottom y

    -- grouped together based on layout on the map

    -- min_x = 0, 256, 512
    -- max_x = 255, 511, 767

    -- min_y = 127 ,, 255 ,, 383
    -- max_y = 0 ,, 136 ,, 272

    self.levels[1] = {p1 = {x = 2, y = 62.5}, p2 = {x = 246, y = 62.5}, tx=0, ty=0, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}
    self.levels[2] = {p1 = {x = 2, y = 62.5}, p2 = {x = 246, y = 92.5}, tx=33, ty=0, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}
    self.levels[5] = {p1 = {x = 2, y = 32.5}, p2 = {x = 246, y = 32.5}, tx=66, ty=0, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}

    self.levels[3] = {p1 = {x = 2, y = 72.5}, p2 = {x = 246, y = 72.5}, tx=0, ty=17, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}
    self.levels[4] = {p1 = {x = 2, y = 92.5}, p2 = {x = 246, y = 22.5}, tx=33, ty=17, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}
    self.levels[6] = {p1 = {x = 2, y = 32.5}, p2 = {x = 246, y = 32.5}, tx=66, ty=17, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}

    self.levels[7] = {p1 = {x = 2, y = 32.5}, p2 = {x = 246, y = 32.5}, tx=0, ty=34, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}
    self.levels[8] = {p1 = {x = 2, y = 32.5}, p2 = {x = 246, y = 32.5}, tx=33, ty=34, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=127}
    
end

function level_manager:draw()
    map(self.levels[self.cur_level].tx, self.levels[self.cur_level].ty, 0, 0, self.levels[self.cur_level].w, self.levels[self.cur_level].h)
end

function level_manager:get_camera(level_no)
    if (level_no != nil) then
        ret = { self.levels[level_no].min_x, self.levels[level_no].max_x}
        return ret
    else
        return nil
    end

end