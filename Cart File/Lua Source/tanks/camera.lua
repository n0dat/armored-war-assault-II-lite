camera_class = {}
camera_class.__index = camera_class

function camera_class:new(init_x, init_y, init_min_x, init_max_x)
    local new_obj = {
        cam_x = init_x,
        cam_y = init_y,
        min_x = init_min_x,
        max_x = init_max_x
    }
    setmetatable(new_obj, camera_class)
    return new_obj
end

function camera_class:set_cam_x(new_x)
    if (new_x < self.min_x) then
        self.cam_x = self.min_x
    elseif (new_x + 128 > self.max_x) then
        self.cam_x = self.max_x - 128
    else
        self.cam_x = new_x
    end
end

function camera_class:update()
    camera(self.cam_x, self.cam_y)
end