pausestate=Class{_includes=basestate}

function pausestate:update(dt)
	if love.keyboard.waspressed('p') then
		sounds['music']:play()
		gStatemachine:change('play')
	end
end

function pausestate:render(o)
	pause=love.graphics.newImage('pause.png')
	love.graphics.draw(pause,215,90)
end
	

