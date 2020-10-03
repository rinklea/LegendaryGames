gameoverstate=class{_includes=basestate}

function gameoverstate:update(dt)
	if love.keyboard.waspressed('escape') then
        love.event.quit()
    end
	if love.keyboard.waspressed('return') then
		gStatemachine:change('serve')
	end
	score=0
	health=3
	level=1
	shrinkstate=false
end

function gameoverstate:render()
	love.graphics.setFont(large)
	love.graphics.printf('GAME OVER',0,virtual_height/3-20,virtual_width,'center')	
	love.graphics.setFont(medium)
	love.graphics.printf("Score:"..tostring(scores),0,virtual_height/2,virtual_width,'center')
	love.graphics.printf("Press Enter To Play",0,virtual_height/2+100,virtual_width,'center')
end