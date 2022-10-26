pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

//globals

//barrel movement const
dbarrel = 0.5

//ground level
ground = 56
//gravity
grav_const = 0.6

//player tables
players = {}
players[1] = {}
players[2] = {}

//projectiles
missles={}

//1 = movement
//2 = shoot
gamephase = 0

// on ground
on_ground = false
  
  // keeps track of which player is currently moving
current_player = 1	


// turn based keys
end_turn_key = ❎
fire_key = 🅾️
-->8
function _init()
  gamephase = 1
  player_turn = 1
  palt(0, false)//draw black
  palt(2, true)//do not draw white
  init_players()
end

function _update60()
		print("here",7)
		if (gamephase == 1) then
			move_phase_update()
		end

end
  
function _draw()
  cls()
  print(solid_ret, 7)
  map(0,0,0,0,16,16)
  draw_players()
  print(new_y, 7)
  print(players[1].bottom_left.y)
end

function get_tile(tile_type, x, y)
 m = fget(mget(x, y), tile_type)
 print(m, 0, 0)
 return m
end

function can_move(x, y)
 return not get_tile(7, x, y)
end

function do_gravity()
 local curr_y
	local curr_x
	for i = 1, #players do
		cur_x = players[i].bottom_left.blx
		new_y = players[i].bottom_left.bly - grav_const
		if (not is_solid(cur_x, new_y + 1)) then
				move_player_cords(i, 0, grav_const)
		end
	end
end
--[[
function do_gravity()
 p1yg = player1.y
 p2yg = player2.y

 if (not on_ground) then
  p1yg += gravity
 end
 r = can_move(player1.x/8, p1yg/8)
 if (r) then
  player1.y = mid(0, p1yg, 127)
  on_ground = false
 else
  p1yg -= 1
  on_ground = true
 end
 if (can_move(player1.x, p1y)) then
  player1.y = mid(0, p1yg, 127)
 end

 if (not on_ground) then
  p2yg += gravity
 end
 r = can_move(player2.x/8, p2yg/8)
 if (r) then
  player2.y = mid(0, p2yg, 127)
  on_ground = false
 else
  p2yg -= 1
  on_ground = true
 end
 if (can_move(player2.x, p2yg)) then
  player2.y = mid(0, p2yg, 127)
 end
 
 
end

--]]

function init_players()
		players = {
		 {
				x = 15,
				y = 25,
				bottom_left = {
					blx = 0,
					bly = 0
				},
				bottom_right = {
					brx = 0,
					bry = 0
				},
				sprite = 4,
				sprites = {4,5,6,7}, --all possible sprites
				angle = 0,
				barrelx = 0,
				barrely = 0,
				facing_left = false
			},
			{
				x = 110,
				y = 25,
				bottom_left = {
					blx = 0,
					bly = 0
				},
				bottom_right = {
					brx = 0,
					bry = 0
				},
				sprite = 20,
				sprites = {20,21,22,23},
				angle = 0,
				barrelx = 0,
				barrely = 0,
				facing_left = false
			} 
		}
		
		players[1].bottom_left.blx = players[1].x
		players[1].bottom_left.bly = players[1].y + 7
		
		players[1].bottom_right.brx = players[1].x + 7
		players[1].bottom_right.bry = players[1].y + 7
		
		players[2].bottom_left.blx = players[2].x
		players[2].bottom_left.bly = players[2].y + 7
		
		players[2].bottom_right.brx = players[2].x + 7
		players[2].bottom_right.bry = players[2].y + 7
		
		players[1].barrelx = players[1].x + 7
		players[1].barrely = players[1].y + 2
		
		players[2].barrelx = players[2].x + 7
		players[2].barrely = players[2].y + 2
end

function draw_players()
	for i = 1, #players do
		spr(players[i].sprite,players[i].x,players[i].y, 1, 1, players[i].facing_left)
	end
end

function update_player_sprites()
		for i = 1, #players do
	  if (players[i].angle < 10) then
	    players[i].sprite = players[i].sprites[1]
	  elseif (players[i].angle < 20) then
	    players[i].sprite = players[i].sprites[2]
	  elseif (players[i].angle < 30) then
	    players[i].sprite = players[i].sprites[3]
	  else
	    players[i].sprite = players[i].sprites[4]
	  end 
	 end 
end

function move_players(player_id)
  //check for horizontal movement
  
 
 if (btn(➡️, 0)) then
   move_player_cords(player_id, 0.5, 0)
   
   if players[player_id].facing_left then
   	players[player_id].barrelx += 7
   	players[player_id].facing_left = false
			end
 end
  
 if (btn(⬅️, 0)) then
   move_player_cords(player_id, -0.5, 0)
   if not players[player_id].facing_left then
   	players[player_id].barrelx -= 7
   	players[player_id].facing_left = true
			end
 end
  
 //check for vertical movment
 if (btn(⬆️, 0)) then
   if (players[player_id].angle < 45) then
     players[player_id].angle += dbarrel
   end
 end
 
 if (btn(⬇️, 0)) then
  if (players[player_id].angle > 0) then
     players[player_id].angle -= dbarrel
  end
 end
 
 update_player_sprites()
  
end

function move_player_cords(pid, dx, dy)
	players[pid].x += dx
	players[pid].y += dy
	
	players[pid].bottom_left.blx += dx
	players[pid].bottom_left.bly += dy
	
	players[pid].bottom_right.brx += dx
	players[pid].bottom_right.bry += dy
end
 

-->8
function draw_missile() 
  //spr
end

function move_phase_update()
   --do_gravity()
   // above needs to be
   // re-implemented
   print ("here")
   do_gravity()
   
   if (btn(end_turn_key, 0)) then
    current_player = 2
   end
   if (btn(end_turn_key, 1)) then
    current_player = 1
   end
   
   move_players(current_player)

end

--collision detection (pixel basis)

function is_solid(x, y)
	if (pget(x, y) == 15) then
		solid_ret = true
		return true
	else
		solid_ret = false
		return false
	end
end
__gfx__
0000000000aaaa002222222222222222222222222222222222222222222222252222222252222225000000000000000000000000000000000000000000000000
000000000aaaaaa02222222222225222222252222222522522225255222252522222522222222222000000000000000000000000000000000000000000000000
00700700aa0aa0aa2222222222999555229995552299955522999552229995222299955522222222000000000000000000000000000000000000000000000000
00077000aaaaaaaa2222222222999222229992222299922222999222229992222299922222222222000000000000000000000000000000000000000000000000
00077000a0aaaa0a2222222289999999899999998999999989999999899999998999999922222222000000000000000000000000000000000000000000000000
00700700aa0aa0aa2222222295050509905050599050505990505059905050599050505922222222000000000000000000000000000000000000000000000000
000000000aa00aa02222222206966965569669605696696056966960569669605696696022222222000000000000000000000000000000000000000000000000
0000000000aaaa002222222225050502205050522050505220505052205050522050505252222225000000000000000000000000000000000000000000000000
00000000000000000000000022222222222222222222222222222222222222252222222200000000000000000000000000000000000000000000000000000000
00000000000000000000000022225222222252222222522522225255222252522222522200000000000000000000000000000000000000000000000000000000
00000000000000000000000022777555227775552277755522777552227775222277755500000000000000000000000000000000000000000000000000000000
00000000000000000000000022777222227772222277722222777222227772222277722200000000000000000000000000000000000000000000000000000000
00000000000000000000000087777777877777778777777787777777877777778777777700000000000000000000000000000000000000000000000000000000
00000000000000000000000075050507705050577050505770505057705050577050505700000000000000000000000000000000000000000000000000000000
00000000000000000000000006766765567667605676676056766760567667605676676000000000000000000000000000000000000000000000000000000000
00000000000000000000000025050502205050522050505220505052205050522050505200000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccfffffffffccccccccccccccf000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffffffccccccccccccff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccfffffffffffccccccccccfff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffffffffccccccccffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccfffffffffffffccccccfffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffffffffffccccffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccfffffffffffffffccfffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
8080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9080808080808080808080808080909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9192808080808080808080808090938100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8191928080808080808080809093818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8181919290909090909090909381818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8181818181818181818181818181818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8181818181818181818181818181818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8181818181818181818181818181818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8181818181818181818181818181818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8181818181818181818181818181818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
