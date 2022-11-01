map = {}

map.__index = map

function map:new(dim_x, dim_y)
    dim_x = dim_x
    dim_y = dim_y
    local new_obj = {
        coords = {}
    }
    for i = 0, dim_x do
        new_obj.coords[i] = {}
        for j = 0, dim_y do
            new_obj.coords[i][j] = false
        end
    end
    setmetatable(new_obj, map)
    return new_obj
end