destruction_manager = {}
destruction_manager.__index = destruction_manager

function destruction_manager:new()
    local new_obj = {
        craters = {}
    }
    setmetatable(new_obj, destruction_manager)
    return new_obj
end

function destruction_manager:add_crater(x, y, radius)
    local new_crater = crater:new(x, y, radius)
    add(self.craters, new_crater)
end

function destruction_manager:clear_craters()
    self.craters = {}
end

function destruction_manager:draw()
    for i = 1, #self.craters do
        circfill(self.craters[i].x, self.craters[i].y, self.craters[i].radius, sky_color)
    end
end