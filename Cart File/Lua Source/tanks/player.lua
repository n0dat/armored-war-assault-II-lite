--Globals for the player class
dbarrel = 0.5 --barrel movement const

--Player class
player = {}

player.__index = player

--Player constructor
function player:new(x, y, sprite, init_speed, sprite_col, projectile_mngr_ref) --Sprite collection and starting sprite along with starting coordinites.
    local new_obj = {
        x = x or 15,
        y = y or 25,
        bottom_left = {
            x = 0,
            y = 0
        },
        bottom_right = {
            x = 0,
            y = 0
        },
        sprite = sprite or 4,
        sprites = sprite_col or {4,5,6,7}, --all possible sprites
        angle = 0,
        barrelx = 0,
        barrely = 0,
        barrel_rise = 0,
        facing_left = false,
        speed = init_speed or 0.5,
        engine_power = 2,
        pm_ref = projectile_mngr_ref,
        shot_power = 1,
        shot_type = 1
    }
    -- shot type = 1 is standard single bomb
    -- shot type = 2 is cluster bomb

    setmetatable(new_obj, player)
    
    
    new_obj.bottom_left.x = new_obj.x
    new_obj.bottom_left.y = new_obj.y + 7
    
    new_obj.bottom_right.x = new_obj.x + 7
    new_obj.bottom_right.y = new_obj.y + 7
    
    new_obj.barrelx = new_obj.x + 7
    new_obj.barrely = new_obj.y + 2
    
    
    return new_obj
end

function player:controls()
    self:shoot()
    self:move_player()
end

function player:set_shot_type(shot)
    self.shot_type = shot
end


-- this is always creating a cluster shot
-- set the last value in the spawn_projectile() call to 1 to have standard shots
function player:shoot()
    if (btnp(5)) then
        if (not self.facing_left) then
            sfx(1)
            self.pm_ref:spawn_projectile(self.barrelx, self.barrely - self.barrel_rise, self.shot_power*cos(self.angle*(1/360)), self.shot_power*sin(self.angle*(1/360)), 2)
        else
            sfx(1)
            self.pm_ref:spawn_projectile(self.barrelx, self.barrely - self.barrel_rise, -1*self.shot_power*cos(self.angle*(1/360)), self.shot_power*sin(self.angle*(1/360)), 2)
        end
    end
end

function player:move_player()
    --/check for horizontal movement
  
    if (btn(1)) then
        if (not is_solid(self.bottom_right.x + 1, self.bottom_right.y, solid_ground_color)) then
            self:move_player_cords(self.speed, 0)
            if (self.facing_left) then
                self.barrelx += 7
                self.facing_left = false
            end
        elseif (not is_solid(self.bottom_right.x + 1, self.bottom_right.y - self.engine_power, solid_ground_color)) then
            self:move_player_cords(self.speed, -1 * self.engine_power)
            if (self.facing_left) then
                self.barrelx += 7
                self.facing_left = false
            end
        end
    end

    if (btn(0)) then
        if (not is_solid(self.bottom_left.x - 1, self.bottom_left.y, solid_ground_color)) then
            self:move_player_cords(-1*self.speed, 0)
            if (not self.facing_left) then
                self.barrelx -= 7
                self.facing_left = true
            end
        elseif (not is_solid(self.bottom_left.x - 1, self.bottom_left.y - self.engine_power, solid_ground_color)) then
            self:move_player_cords(-1*self.speed, -1 * self.engine_power)
            if (not self.facing_left) then
                self.barrelx -= 7
                self.facing_left = true
            end
        end
    end

    --check for vertical movment
    if (btn(2)) then
        if (self.angle < 45) then
            self.angle += dbarrel
            self:set_barrel_rise()
        end
    end

    if (btn(3)) then
        if (self.angle > 0) then
            self.angle -= dbarrel
            self:set_barrel_rise()
        end
    end
 
    self:update_player_sprites()
  
end

function player:move_player_cords(dx, dy)
    self.x += dx
	self.y += dy
	
	self.bottom_left.x += dx
	self.bottom_left.y += dy
	
	self.bottom_right.x += dx
	self.bottom_right.y += dy
    
    self.barrelx += dx
    self.barrely += dy
end

function player:set_barrel_rise()
    if (self.angle < 10) then
        self.barrel_rise = 0
    elseif (self.angle < 30) then
        self.barrel_rise = 1
    else
        self.barrel_rise = 2
    end 
end

function player:update_player_sprites()
    if (self.angle < 10) then
        self.sprite = self.sprites[1]
    elseif (self.angle < 20) then
        self.sprite = self.sprites[2]
    elseif (self.angle < 30) then
        self.sprite = self.sprites[3]
    else
        self.sprite = self.sprites[4]
    end 
end

function player:draw()
   spr(self.sprite, self.x, self.y, 1, 1, self.facing_left)
   spr(9, self.barrelx , self.barrely - self.barrel_rise, 1, 1)
end

function player:update()
    self:controls()
end




