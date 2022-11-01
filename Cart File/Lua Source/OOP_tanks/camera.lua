camera = {}
camera.__index = camera

function camera:new(init_x, init_y)
    local new_obj = {
        world_origin = {x = init_x, y = init_y},
        world_window = {min_x = self.world_origin.x - 63, max_x = self.world_origin.x + 64, max_y = self.world_origin.y - 63, min_y = self.world_origin.y + 64}
    }
end