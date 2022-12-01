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
    l1_p1 = {x = 2, y = 62.5, barx = 9, bary = 64.5, botlx = 2, botly = 69.5, botrx = 9, botry = 69.5}
    l1_p2 = {x = 246, y = 62.5, barx = 253, bary = 64.5, botlx = 246, botly = 69.5, botrx = 253, botry = 69.5}
    self.levels[1] = {p1 = {x = 2, y = 62.5}, p2 = {x = 246, y = 62.5}, tx=0, ty=0, w=32, h=16, min_x=0, max_x=255, max_y=0, min_y=122}
    --level_2
    --level_3
    --level_4
    --level_5
    --level_6
    --level_7
    --level_8

    --self:add_level(level_1)
    
end

-- this will initialize all player postional parameters
function level_manager:begin_level(level_no, p1, p2)
    p1.x = self.levels[level_no].p1.x
    p1.y = self.levels[level_no].p1.y
    p1.bottom_left.x = self.levels[level_no].p1.botlx
    p1.bottom_left.y = self.levels[level_no].p1.botly
    p1.bottom_right.x = self.levels[level_no].p1.botrx
    p1.bottom_right.y = self.levels[level_no].p1.botry
    p1.barrelx = self.levels[level_no].p1.barx
    p1.barrely = self.levels[level_no].p1.bary

    p2.x = self.levels[level_no].p2.x
    p2.y = self.levels[level_no].p2.y
    p2.bottom_left.x = self.levels[level_no].p2.botlx
    p2.bottom_left.y = self.levels[level_no].p2.botly
    p2.bottom_right.x = self.levels[level_no].p2.botrx
    p2.bottom_right.y = self.levels[level_no].p2.botry
    p2.barrelx = self.levels[level_no].p2.barx
    p2.barrely = self.levels[level_no].p2.bary
end

function level_manager:draw()
    if (self.cur_level == 1) then
        map(0, 0, self.levels[1].tx, self.levels[1].ty, self.levels[1].w, self.levels[1].h)
        --map(0, 0, 0, 0, 32, 16)
    elseif (self.cur_level == 2) then
    elseif (self.cur_level == 3) then
    elseif (self.cur_level == 4) then
    elseif (self.cur_level == 5) then
    elseif (self.cur_level == 6) then
    elseif (self.cur_level == 7) then
    elseif (self.cur_level == 8) then
    end
end

function level_manager:get_camera(level_no)
    if (level_no != nil) then
        ret = { self.levels[level_no].min_x, self.levels[level_no].max_x}
        return ret
    else
        return nil
    end

end