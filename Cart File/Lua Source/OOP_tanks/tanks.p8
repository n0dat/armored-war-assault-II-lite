pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

#include player.lua
#include player_manager.lua
#include utility.lua
#include projectile.lua
#include projectile_manager.lua

function _init()
    palt(0, false)//draw black
    palt(2, true)//do not draw white
    glbl_projectile_manager = projectile_manager:new()
    glbl_player_manager = player_manager:new()
    glbl_player_manager:add_player(player:new(15, 25, 4, 0.5, {4,5,6,7}, glbl_projectile_manager))
    glbl_player_manager:add_player(player:new(110, 25, 20, 0.5, {20,21,22,23}, glbl_projectile_manager))
    
    
end

function _update60()
    glbl_player_manager:update()
    glbl_projectile_manager:update()
end

function _draw()
    cls()
    map(0,0,0,0,16,16)
    glbl_player_manager:draw()
    glbl_projectile_manager:draw()
				print(stat(7))
end

__gfx__
0000000000aaaa002222222222222222222222222222222222222222222222252222222252222222000000000000000000000000000000000000000000000000
000000000aaaaaa02222222222225222222252222222522522225255222252522222522222222222000000000000000000000000000000000000000000000000
00700700aa0aa0aa2222222222999555229995552299955522999552229995222299955522222222000000000000000000000000000000000000000000000000
00077000aaaaaaaa2222222222999222229992222299922222999222229992222299922222222222000000000000000000000000000000000000000000000000
00077000a0aaaa0a2222222289999999899999998999999989999999899999998999999922222222000000000000000000000000000000000000000000000000
00700700aa0aa0aa2222222295050509905050599050505990505059905050599050505922222222000000000000000000000000000000000000000000000000
000000000aa00aa02222222206966965569669605696696056966960569669605696696022222222000000000000000000000000000000000000000000000000
0000000000aaaa002222222225050502205050522050505220505052205050522050505222222222000000000000000000000000000000000000000000000000
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
