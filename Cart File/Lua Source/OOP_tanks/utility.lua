bullet_grav_const = 0.01
sky_color = 12
        
function is_solid(x, y, solid_color)
	if (pget(x, y) == solid_color) then
		return true
	else
		return false
	end
end
