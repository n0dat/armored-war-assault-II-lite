camera_manager = {}

camera_manager.__index = camera_manager

function camera_manager:new(init_game_manager_ref, init_projectile_manager_ref, init_players)
    local new_obj = {
        game_manager_ref = init_game_manager_ref,
        projectile_manager_ref = init_game_manager_ref.projectile_manager_ref,
        players = {},
        camera,
        pause_delay = 1,
        paused = false,
        init_pos = {x = 0, y = 0},
        pause_time
    }
    init_players = init_game_manager_ref.player_manager_ref.players
    for i = 1, #init_players do
        add(new_obj.players, init_players[i])
    end
    new_obj.camera = camera_class:new(new_obj.players[new_obj.game_manager_ref.player_turn].x, new_obj.game_manager_ref.cam_y, new_obj.game_manager_ref.min_x, new_obj.game_manager_ref.max_x)
    setmetatable(new_obj, camera_manager)
    return new_obj
end

function camera_manager:get_pos()
    return {x = self.init_pos.x, y = self.init_pos.y}
end

function camera_manager:reset()
    self.camera.cam_x = 0
    self.camera.cam_y = 0
    self.paused = false
    self.init_pos = {x = 0, y = 0}
    self.pause_delay = 1
    self.pause_time = 0
    self:update()
end

function camera_manager:set_init_pos(x, y)
    if (x != nil and y != nil) then
        self.init_pos.x = x
        self.init_pos.y = y
    end
end

function camera_manager:update()
    if (self.paused) then
        if ((time() - self.pause_time) >= self.pause_delay) then
            self.paused = false
        else
            return
        end 
    end
    if (self.projectile_manager_ref.projectiles[1] != nil) then
        self.camera:set_cam_x(self.projectile_manager_ref.projectiles[1].x - 64)
    else
        self.camera:set_cam_x(self.players[self.game_manager_ref.player_turn].x - 64)
    end
    self.camera:update()
end

function camera_manager:pause_camera()
    self.paused = true
    self.pause_time = time()
end