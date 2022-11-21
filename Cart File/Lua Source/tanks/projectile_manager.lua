projectile_manager = {}
projectile_manager.__index = projectile_manager

function projectile_manager:new(init_destruction_manager_ref, init_camera_manager_ref, arm_time)
    local new_obj = {
        projectiles = {},
        arming_time = arm_time or 0.15, --3 frames,
        split_delay = 0.5,
        destruction_manager_ref = init_destruction_manager_ref,
        camera_manager_ref,
    }
    setmetatable(new_obj, projectile_manager)
    return new_obj
end

function projectile_manager:spawn_projectile(x, y, vel_x, vel_y, p_type) --spawn new projectile using a vector
    local new_projectile = projectile:new(x, y, vel_x, vel_y, 9, p_type)
    add(self.projectiles, new_projectile)
end

function projectile_manager:remove_projectile(i)
    del(self.projectiles, self.projectiles[i])
end

function projectile_manager:update()
   self:arm_projectiles()
   self:update_projectiles_pos() 
end

function projectile_manager:update_projectiles_pos()
    local new_y_vel
    for i = 1, #self.projectiles do
        if (self.projectiles[i] != nil) then
            if (not self.projectiles[i]:check_collision()) then
                self.projectiles[i].vel.y += bullet_grav_const
                if (self.projectiles[i].vel.y > 1) then
                    self.projectiles[i].vel.y = 1
                end
                self.projectiles[i].x += self.projectiles[i].vel.x
                self.projectiles[i].y += self.projectiles[i].vel.y
                
                self.projectiles[i]:split(self)
            else
                sfx(0)
                self.destruction_manager_ref:add_crater(self.projectiles[i].x, self.projectiles[i].y, 5)
                self.camera_manager_ref:pause_camera()
                self:remove_projectile(i)
            end
            
        end
    end 
end

function projectile_manager:arm_projectiles()
    for i = 1, #self.projectiles do
        if (not self.projectiles[i].armed and (time() - self.projectiles[i].spawn_time > self.arming_time)) then
            self.projectiles[i].is_armed = true
        end
    end 
end

function projectile_manager:draw()
   for i = 1, #self.projectiles do
       self.projectiles[i]:draw()
   end
end
