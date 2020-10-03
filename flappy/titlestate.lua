titlestate=Class{_includes=basestate}

function titlestate:update(dt)
	if love.keyboard.waspressed('return') then
		gStatemachine:change('count')
	end
end

function titlestate:render(o)
	love.graphics.setFont(titlefont)
	love.graphics.printf('Flappy Bird',0,64,virtual_width,'center')
	love.graphics.setFont(mediumfont)
	love.graphics.printf('Press Enter To Play',0,100,virtual_width,'center')
end