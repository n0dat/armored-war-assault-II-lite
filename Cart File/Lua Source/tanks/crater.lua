crater = {}
crater.__index = crater

function crater:new(init_x, init_y, init_radius)
    local new_obj = {
        x = init_x or 0,
        y = init_y or 0,
        radius = init_radius
    }
    setmetatable(new_obj, crater)
    return new_obj
end

