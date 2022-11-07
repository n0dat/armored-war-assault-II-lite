intro_frame_count = 0
intro = false
intro_over = false

function intro:draw()
 spr (42,55,45,2,2)
 if not intro then
  intro = true
  pal(1, 0, 1)
  pal(3, 0, 1)
  pal(9, 0, 1)
  pal(10, 0, 1)
  pal(5, 0, 1)
  pal(11, 0, 1)
 end
 if fcount > 8 then
	 pal(1, 5, 0)
  pal(5, 5, 1)
 end
 if fcount > 16 then
	 //pal(1, 13, 1)
  pal(3, 6, 1)
  pal(11, 7, 1)
  pal(10, 6, 1)
  pal(9, 5, 1)
 end
 if fcount > 24 then 
 print ("iron squids", 42, 64, 7)
 pal(7, 12, 1)
 end
 if fcount > 30 then
	 pal()
	intro_over = true
 end
end