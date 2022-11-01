
projectile = {}

projectile.__index = projectile

function projectile:new(init_x, init_y, init_vel_x, init_vel_y, init_spr)
    local new_obj = {
        x = init_x or 0,
        y = init_y or 0,
        vel = { x = init_vel_x, y = init_vel_y},
        spr = init_spr,
        is_armed = false,
        spawn_time = time(),
        has_landed = false,
        exploded_coords = {x, y}
    }
    setmetatable(new_obj, projectile)
    return new_obj
end

function projectile:check_collision()
    if (self.is_armed == false) then
        return false
    elseif (pget(self.x-1, self.y) != sky_color or pget(self.x+1, self.y) != sky_color or pget(self.x, self.y+1) != sky_color or pget(self.x, self.y-1) != sky_color) then
        return true
    end
end 

function projectile:draw()
    spr(self.spr, self.x, self.y, 1, 1)
end
