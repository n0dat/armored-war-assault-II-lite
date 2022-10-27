--Globals for the player class
dbarrel = 0.5 --barrel movement const

--Player class
player = {}

player.__index = player

--Player constructor
function player:new(x, y, sprite, sprite_col) --Sprite collection and starting sprite along with starting coordinites.
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
        facing_left = false
    }
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
    self:move_player()
end

function player:move_player()
    --/check for horizontal movement
  
 
    if (btn(1)) then
        self:move_player_cords(0.5, 0)
        if (self.facing_left) then
            self.barrelx += 7
            self.facing_left = false
        end
    end

    if (btn(0)) then
        self:move_player_cords(-0.5, 0)
        if (not self.facing_left) then
            self.barrelx -= 7
            self.facing_left = true
        end
    end

    --check for vertical movment
    if (btn(2)) then
        if (self.angle < 45) then
            self.angle += dbarrel
        end
    end

    if (btn(3)) then
        if (self.angle > 0) then
            self.angle -= dbarrel
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
end

function player:update()
   self:controls() 
end




