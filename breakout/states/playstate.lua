playstate=class{_includes=basestate}
health=3
recoverypoints=10000
function playstate:init()
	if scrolling then			--initialize only if not paused
		timer=0
		startball=math.random(10,15)
		powerball=Powerup()
		powerbrick=Powerup()
		startbrick=math.random(15,20)
		ball1=Ball(math.random(7))
		ball2=Ball(math.random(7))
	end
end
function playstate:update(dt)
	timer=timer+dt

		if love.keyboard.waspressed('space') then
			gStatemachine:change('pause')
			scrolling=false
		end
		if love.keyboard.waspressed('escape') then
			love.event.quit()
		end
		
		if ball:collide(paddle) then
			ball.y =paddle.y - 8
			ball.dy=-ball.dy
			if ball.x < paddle.x + ( paddle.width / 2) and  paddle.dx < 0 then
            	 ball.dx = -20-(8 * ( paddle.x +  paddle.width / 2 -  ball.x))
     		elseif  ball.x >  paddle.x + ( paddle.width / 2) and  paddle.dx > 0 then
            	 ball.dx = 20+(8 * math.abs( paddle.x +  paddle.width / 2 -  ball.x))
       		end
		end

		if ball1:collide(paddle) then
			ball1.y =paddle.y - 8
			ball1.dy=-ball1.dy
			if ball1.x < paddle.x + ( paddle.width / 2) and  paddle.dx < 0 then
            	 ball1.dx = -20-(8 * ( paddle.x +  paddle.width / 2 -  ball1.x))
     		elseif  ball1.x >  paddle.x + ( paddle.width / 2) and  paddle.dx > 0 then
            	 ball1.dx = 20+(8 * math.abs( paddle.x +  paddle.width / 2 -  ball1.x))
       		end
		end

		if ball2:collide(paddle) then
			ball2.y =paddle.y - 8
			ball2.dy=-ball2.dy
			if ball2.x < paddle.x + ( paddle.width / 2) and  paddle.dx < 0 then
            	 ball2.dx = -20-(8 * ( paddle.x +  paddle.width / 2 -  ball2.x))
     		elseif  ball2.x >  paddle.x + ( paddle.width / 2) and  paddle.dx > 0 then
            	 ball2.dx = 20+(8 * math.abs( paddle.x +  paddle.width / 2 -  ball2.x))
       		end
		end

		for k,brick in pairs(bricks) do
			brick:update(dt)			--to update smoke/particlesytem
			if ball:collide(brick) and brick.visible then
				brick.color=brick.color+1
				score=score+brick.color*100
				if score>=recoverypoints then
					paddle:grow()
					recoverypoints=recoverypoints*3
				end
				brick:hit()
				if checkvictory() then
					levels=level
					level=level+1
					yes=false						--to remove powerballup balls from screen
					gStatemachine:change('victory')
				end
				if ball.dx>0 and ball.x<brick.x then
					ball.dy=-ball.dy
					ball.dx=-ball.dx				 	
				elseif ball.dx<0 and ball.x>brick.x+brick.width then
					ball.dx=-ball.dx
					ball.dy=-ball.dy
				end
			ball.dy=-ball.dy*1.02
			break
			end
			if ball1:collide(brick) and brick.visible then
				brick.color=brick.color+1
				score=score+(brick.tier*200 + brick.color*25)
				brick:hit()
				if checkvictory() then
					levels=level
					level=level+1
					yes=false		--to remove powerballup balls from screen
					gStatemachine:change('victory')
				end
				if ball1.dx>0 and ball1.x<brick.x then
					ball1.dy=-ball1.dy
					ball1.dx=-ball1.dx				 	
				elseif ball1.dx<0 and ball1.x>brick.x+brick.width then
					ball1.dx=-ball1.dx
					ball1.dy=-ball1.dy
				end
			ball1.dy=-ball1.dy*1.02
			break
			end
			if ball2:collide(brick) and brick.visible then
				brick.color=brick.color+1
				score=score+(brick.tier*200 + brick.color*25)
				brick:hit()
				if checkvictory() then
					levels=level
					level=level+1
					yes=false		--to remove powerballup balls from screen
					gStatemachine:change('victory')
				end
				if ball2.dx>0 and ball2.x<brick.x then
					ball2.dy=-ball2.dy
					ball2.dx=-ball2.dx				 	
				elseif ball2.dx<0 and ball2.x>brick.x+brick.width then
					ball1.dx=-ball1.dx
					ball1.dy=-ball1.dy
				end
			ball2.dy=-ball2.dy*1.02
			break
			end
		end

		if ball:collide(lockedbrick) then
			if lockedbrick.lock==false then
				lockedbrick:hit()
			elseif lockedbrick.lock==true then
				if ball.dx>0 and ball.x<lockedbrick.x then
					ball.dy=-ball.dy
					ball.dx=-ball.dx				 	
				elseif ball.dx<0 and ball.x>lockedbrick.x+lockedbrick.width then
					ball.dx=-ball.dx
					ball.dy=-ball.dy
				end
				ball.dy=-ball.dy*1.02
			end
		end
	
		scores=score

		if yes then 
			if ball.y>=virtual_height and ball1.y>=virtual_height and ball2.y>=virtual_height then 
				health=health-1
				yes=false
				paddle:shrink()
				shrinkstate=true
				gStatemachine:change('serve')
				overstate=0
			end
		else
			if ball.y>=virtual_height then
				health=health-1
				paddle:shrink()
				shrinkstate=true
				gStatemachine:change('serve')
				overstate=0
			end
		end
		if health==0 then
			gStatemachine:change('gameover')
		end
		
		if timer>=startball then
			color=1
			powerball:update(dt)
		end
		if timer>=startbrick then
			color=2
			powerbrick:update(dt)
		end
		if powerball:collide(paddle) then
			yes=true
			powerball:hit()
		end
		if powerbrick:collide(paddle) then
			powerbrick:hit()
			state=true
			lockedbrick.lock=false
		end
		if yes then					--yes means powerballup added
			ball1:update(dt)
			ball2:update(dt)
		end
	function checkvictory()
		for j,brick in pairs(bricks) do
			if brick.visible and lockedbrick.visible then 
				return false
			end
		end
		return true
	end	

	paddle:update(dt)
	ball:update(dt)

	
end


				

function playstate:render()
	paddle:render()
	ball:render()
	for k,brick in pairs(bricks) do
			brick:render()
	end
	for k, brick in pairs(bricks) do
    	brick:renderParticles()
    end
	love.graphics.setFont(small)
	love.graphics.print("Score:"..tostring(score),virtual_width-50,5)
	renderhealth(health)
	if timer>=startball and color==1 then
		powerball:render()
	end
	if timer>=startbrick and color==2 then
		powerbrick:render()
	end
	if yes then
		ball1:render()
		ball2:render()
	end
	lockedbrick:render()	
end