round_map = {}

round_map.__index = round_map

function round_map:new(init_dim_x, init_dim_y) --Max dimention is 128x64
    local new_obj = {
        dim_x = init_dim_x,
        dim_y = init_dim_y
    }
    setmetatable(new_obj, round_map)
    return new_obj
end

function round_map:set_pixel(x, y, color)
    if (x >= self.dim_x or x < 0) do
        return
    end
    if (y >= self.dim_y or y < 0) do
        return
    end
    sset(x, y + 64, color)
end

function round_map:set_pixels_to_floor(x, y, color)
    for i = y, self.dim_y - 1 do
        self:set_pixel(x, i, color)
    end
end