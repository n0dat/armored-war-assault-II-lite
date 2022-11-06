map_manager = {}
map_manager.__index = map_manager

function map_manager:new(init_dim_x, init_dim_y, ground_color)
    local new_obj = {
        dim_x = init_dim_x,
        dim_y = init_dim_y,
        ground_color = ground_color or 15,
        sky_color = 12,
        current_map = round_map:new(init_dim_x, init_dim_y)
    }
    setmetatable(new_obj, map_manager)
    return new_obj
end

function map_manager:generate_map(avg_height, deviation)
    local current_y = avg_height
    local min_y = avg_height + deviation
    local max_y = avg_height - deviation

    for i = 0, self.dim_x - 1 do
        if (rnd() > 0.5) do
            if (current_y - 1 > max_y) then
                current_y -= 1
            end
        else
            if (current_y + 1 < min_y) then
                current_y += 1
            end
        end
        self.current_map:set_pixels_to_floor(i, current_y, self.ground_color)
        --[[
        for j = current_y, self.dim_y do
            self.current_map.coords[i][j] = true
            if (i+1 <= self.dim_x) then
                self.current_map.coords[i+1][j] = true
            end
        end
        --]]
    end
end

function map_manager:draw()
    map(0, 32, 0, 0, 32, 32)
    --[[
    for i = 0, self.dim_x do
        for j = 0, self.dim_y do
            if (self.current_map.coords[i][j]) then
                pset(i, j, self.ground_color)
            end
        end
    end
    --]]
end