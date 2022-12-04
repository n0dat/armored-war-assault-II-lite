
projectile = {}

projectile.__index = projectile

function projectile:new(init_x, init_y, init_vel_x, init_vel_y, init_spr, proj_type, proj_dir, init_power, init_damage)
    local new_obj = {
        x = init_x or 0,
        y = init_y or 0,
        vel = { x = init_vel_x, y = init_vel_y},
        spr = init_spr,
        is_armed = false,
        spawn_time = time(),
        has_landed = false,
        exploded_coords = {x, y},
        shot_type = proj_type or 1,
        is_split = false,
        direction = proj_dir or 1,
        power = init_power or 10,
        damage = init_damage or 500
    }
    setmetatable(new_obj, projectile)
    return new_obj
end

function projectile:check_collision()
    if (not self.is_armed) then
        return false
    elseif ((pget(self.x-1, self.y) != sky_color or pget(self.x+1, self.y) != sky_color or pget(self.x, self.y+1) != sky_color or pget(self.x, self.y-1) != sky_color) and
            (pget(self.x-1, self.y) != 5 or pget(self.x+1, self.y) != 5 or pget(self.x, self.y+1) != 5 or pget(self.x, self.y-1) != 5)) then
        return true
    end
end 

function projectile:draw()
    spr(self.spr, self.x, self.y, 1, 1)
end

function projectile:split(proj_man)
    if (self.is_split == false and self.shot_type == 2) then
        if (self.is_armed and (time() - self.spawn_time > 0.50)) then
            if (self.direction ==  1) then
                proj_man:spawn_projectile(self.x+2, self.y, self.vel.x * 1.15, self.vel.y * 1.15, 1, 1)
                proj_man:spawn_projectile(self.x-2, self.y, self.vel.x * 0.85, self.vel.y * 0.85, 1, 1)
                self.is_split = true

            else
                proj_man:spawn_projectile(self.x-2, self.y, self.vel.x * 1.15, self.vel.y * 1.15, 1, 0)
                proj_man:spawn_projectile(self.x+2, self.y, self.vel.x * 0.85, self.vel.y * 0.85, 1, 0)
                self.is_split = true
            end

        end
    end
end

-- Draws bounding box
function projectile:check_within_range(x_param, y_param)
    if (((self.x + self.power) > x_param) and ((self.x - self.power) < x_param) and ((self.y + self.power) > y_param) and ((self.y - self.power) < y_param)) then
        return true
    end
end