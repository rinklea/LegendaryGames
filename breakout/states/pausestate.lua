pausestate=class{_includes=basestate}

function pausestate:update(dt)
	if love.keyboard.waspressed('space') then
		gStatemachine:change('play')
	end
	if love.keyboard.waspressed('escape') then
		love.event.quit()
	end
end

function pausestate:render()
	pause=love.graphics.newImage('images/pause.png')
	love.graphics.draw(pause,187,80)
	paddle:render()
	for k,brick in pairs( bricks) do
			brick:render()
	end
	love.graphics.setFont(small)
	love.graphics.print("Score:"..tostring(score),virtual_width-50,5)
	renderhealth(health)
end
	

