bullet_grav_const = 0.01
sky_color = 12
ground_color_sand = 15
ground_color_grass = 3
        
function is_solid(x, y, solid_color)
	if (pget(x, y) == ground_color_sand or pget(x, y) == ground_color_grass) then
		return true
	else
		return false
	end
end

function is_not_solid(x, y, not_solid_color)
	if (pget(x,y) == not_solid_color) then
		return true
	else
		return false
	end
end
function set_pixel_map_data(x, y, val)
	y = 0x1000 + (y_level*64)
	address = 0x1000 + (y*64) + x
	memset(address, val, 1)
end

